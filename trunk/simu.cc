#include <iostream>
#include <iomanip>
#include <sstream>
#include <fstream>
#include <X11/Xlib.h>
#include <X11/keysym.h>

//for sleep :
#include <unistd.h>

using namespace std;

int verbose;

// SIMULATOR DEPENDENT
uint32_t video[640*480]; //the size of the video memory


//PROCESSOR DEPENDENT
uint16_t r[128]; //128 registers on 16 bits 
uint16_t pc;     //16-bit program counter
bool flagV, flagN, flagZ;   //processor has 3 flags, V=overflow, N=negative and Z=zero 

//DISPLAY DRIVER DEPENDENT
uint8_t charROM[256][8];

int mem[8192]; //the memory mapped at address 000 0000000000000 to 000 1111111111111
int dispMem[8192];

bool sign_r0;
bool sign_r;
int rval;

uint32_t v_acc;
uint32_t v_reg;
//------------------------------------------------------------------------------

/** 
 * converts a binary number under a string format into an integer
 * @param[in] s the input string containing the binary number
 * @return the integer corresponding to the positive binary number contain in s
 */
uint8_t b2ToInt(string s){
	if (s.length() != 8) cout << "Error b2ToInt: length of s=" << s << " is not 8 ";
	uint8_t value=0;
	for (uint8_t i=0;i<s.length();i++)
		if(s[i]=='1' | s[i]=='m') value += 1 << 7-i;
	return value;
}

/** 
 * initializes the ROM memory with the corresponding characters 
 */
void charROMInit(){
	ifstream is("rom.data");
	string line; // S string for a line to read
	int i=0, j=0;
	while(is.good()) {
		is >> line;
		if (is.good() & (line[0]!='-')){
			charROM[i][j]=b2ToInt(line.substr(0,8));
			j = (j+1) % 8;
			if (j==0)
				i = i+1;
		}
	}
}

/**
 * parses 1 line from .obj file containing the instructions
 */
void parse() {
	uint16_t adr = 0x0800; //the address where the code segment starts
	while (!cin.eof()) {
    // read a line
    char buf[256];
    cin.getline(buf, 256);
    string line(buf);
    istringstream sstr(line);
    sstr >> hex >> mem[adr];
    adr++;
  }
}

/*Change this for memory related display*/
/*we do not have a video memory, but a character memory*/
void render_all()
{
	for (int y = 0; y < 60; y++)
	for (int x = 0; x < 80; x++)
	for (uint8_t k1=0;k1<8;k1++)
	for (uint8_t k2=0;k2<8;k2++){
		unsigned char c = 255 ; //255=white; color is coded RRRGGBBB on 8 bits
		c *=  (charROM[dispMem[y*80+x]][k1] >> (7-k2))  % 2; 
		video[(8*(y)+k1)*(640)+8*x+k2]=((c&0xe0)<<16) + ((c&0x18)<<11) + ((c&0x7)<<5);
		//video[(8*(y)+k1)*(640)+8*x+k2]=c*((1<<16)+(1<<8)+1);
	}
}

int compteur=0;
void step()
{
	bool doInstr = false;
	bool setFlags = false;
	int tempPC=-1;
	bool tempFlagV, tempFlagN, tempFlagZ;
	bool signRi;
	bool signImm;
	int temp;
	uint16_t dev;
	int j;
	uint16_t val;
	
	//FETCH
	uint16_t instr = mem[pc];
	
	//DECODE
	uint16_t instrCode  =  instr >> 11;  
	uint16_t instrPred  = (instr >> 8) & 7;
	uint16_t instrFlag  = (instr >> 7) & 1;
	setFlags = instrFlag; //pfff
	
	uint16_t reg  =  instr & 0x7f;
	uint32_t imm =   instr & 0xff;

	if(verbose) {
	cout << "flags=" <<flagZ<<flagN<<flagV<<endl;
	cout << "r0=" << r[0]<<endl;
	cout << setfill('0')  << " pc="    << setw(4) << hex << pc 
	                      << " instr=" << setw(4) << hex << instr
	                      << " code="  << setw(2) << hex << instrCode
	                      << " imm="   << setw(2) << hex << imm
	                      << " pred="  << setw(1) << hex << instrPred << endl;
	}

	//predicate execution: check if the instruction with instrCode will be executed
	//or the processor will just jump to the next one.
	//TODO check for corectness
	switch (instrPred) {
		#define zero flagZ
		#define negative flagN
		#define overflow flagV
		case 0: /* GT */ doInstr = not zero & not negative; break;
		case 1: /* GE */ doInstr = not negative;            break;
		case 2: /* EQ */ doInstr = zero;                    break;
		case 3: /* NE */ doInstr = not zero;                break;
		case 4: /* LE */ doInstr = zero or negative;        break;
		case 5: /* LT */ doInstr = not zero and negative;   break;
		case 6: /* OV */ doInstr = overflow;                break;
		case 7: /* NC */ doInstr = true;                    break;
	}	
	
	if(verbose) cout << "Do instruction ="<< doInstr <<endl;
	tempFlagV = flagV;
	tempFlagN = flagN;
	tempFlagZ = flagZ;
	
	//DEBUGGING
	int i=-2; //A SUPPRIMER
	compteur++;
	if(false && compteur%10==0)
		cout << "mem[0x1000...0x100C]=["
		<< mem[0x1000-1] << " ("
		<< mem[0x1000+0] << ", "
		<< mem[0x1000+1] << ", "
		<< mem[0x1000+2] << ", "
		<< mem[0x1000+3] << ", "
		<< mem[0x1000+4] << ")  ("
		<< mem[0x1000+5] << ", "
		<< mem[0x1000+6] << ", "
		<< mem[0x1000+7] << ", "
		<< mem[0x1000+8] << ", "
		<< mem[0x1000+9] << ")  ("
		<< mem[0x1000+10] << ", "
		<< mem[0x1000+11] << ", "
		<< mem[0x1000+12] << ", "
		<< mem[0x1000+13] << ", "
		<< mem[0x1000+14] << ", "
		<< mem[0x1000+15] << " "
		 << "]" << endl;
	
	if (doInstr==true){
		switch (instrCode) {
			case 0:   // ldl
				r[0] = imm;      
			break;
			case 1: // ldh
				r[0] = (r[0] & 0xFF) + (imm<<8);
			break;
			case 2:  // mv2reg
				r[reg] = r[0];
			break;
			case 3:// mv2acc
				r[0] = r[reg];
			break;
			case 4:   // rd
				//check device
				dev = r[0]>>13;
				if (dev==0)
					r[reg] = mem[r[0] & 0x1FFF];
				else if (dev==1)
					r[reg] = dispMem[r[0] & 0x1FFF];
				else{
					std::ostringstream o;
					o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": Address too large, only memory and DisplayMemory are connected to the proc ";
					throw o.str();
				}
			break;
			case 5:   // wr 
				//check device
				dev = r[0]>>13;
				if (dev==0)
					mem[r[0] & 0x1FFF] = r[reg];
				else if (dev==1)
					dispMem[r[0] & 0x1FFF] = r[reg];
				else{{
					std::ostringstream o;
					o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": Address too large, only memory and DisplayMemory are connected to the proc ";
					throw o.str();
				}
					std::ostringstream o;
					o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": Address too large, only memory and DisplayMemory are connected to the proc ";
					throw o.str();
				}
			break;
			case 6:   // rdInc
				//check device
				dev = r[0]>>13;
				if (dev==0)
					r[reg] = mem[r[0] & 0x1FFF];
				else if (dev==1)
					r[reg] = dispMem[r[0] & 0x1FFF];
				else{
					std::ostringstream o;
					o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": Address too large, only memory and DisplayMemory are connected to the proc ";
					throw o.str();
				}
				r[0]++;
			break;
			case 7:   // wrInc 
				//check device
				dev = r[0]>>13;
				if (dev==0)
					mem[r[0] & 0x1FFF] = r[reg];
				else if (dev==1)
					dispMem[r[0] & 0x1FFF] = r[reg];
				else{
					std::ostringstream o;
					o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": Address too large, only memory and DisplayMemory are connected to the proc ";
					throw o.str();
				}
				r[0]++;
			break;
			case 8:   // rdDec
				//check device
				dev = r[0]>>13;
				if (dev==0)
					r[reg] = mem[r[0] & 0x1FFF];
				else if (dev==1)
					r[reg] = dispMem[r[0] & 0x1FFF];
				else{
					std::ostringstream o;
					o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": Address too large, only memory and DisplayMemory are connected to the proc ";
					throw o.str();
				}
				r[0]--;
			break;
			case 9:   // wrDec 
				//check device
				dev = r[0]>>13;
				if (dev==0)
					mem[r[0] & 0x1FFF] = r[reg];
				else if (dev==1)
					dispMem[r[0] & 0x1FFF] = r[reg];
				else{
					std::ostringstream o;
					o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": Address too large, only memory and DisplayMemory are connected to the proc ";
					throw o.str();
				}
				r[0]--;
			break;
			case 10:  // jmp
				//cout << "r[reg]=" << r[reg] << " reg=" << reg << endl;
				tempPC = r[reg];
			break;
			case 11:   // jmr, add Ri to PC     CHECKED !!
				//check sign of R[i]
				signRi = r[reg]>>15;
				if (signRi==0) 
					tempPC = pc + r[reg];
				else 
					tempPC = pc - ((0xFFFF ^ r[reg])+1);
			break;
			case 12:   // jmi
				
				if (imm>127) //trying to jump at a negative address
				{
					std::ostringstream o;
					o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": Trying to jump with negative immediate "<<imm-256<<"."<<endl;
					throw o.str();
				} 
				tempPC = imm;
				
				cout << "Never use jmi, too dangerous.\n";
			break;
			case 13:   // jmri, ON VA DIRE QU'ON EMPILE, c'est celui qui marche...
				//check sign of imm
				//mem[r[127]] = pc;
				//r[127]++;
				signImm = imm>>7;
				if (signImm==0) 
					tempPC = pc + imm; //jump forward
				else 
					tempPC = pc - ((imm ^ 0xFF)+1); //jump back
			break;
			case 14:   // jsr,
				//TODO check if we are not storing pc in video memory :P IS THAT POSSIBLE ? .. Shouldn't be the dispMem ?
				mem[r[127]]=pc;				
				r[127]++;
				tempPC = r[reg];
			break;
			case 15:   // jsri, 
				//check sign of imm
				mem[r[127]] = pc;
				r[127]++;
				if (imm>127) //trying to jump at a negative address
				{
					std::ostringstream o;
					o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": Trying to jump with negative immediate "<<imm-256<<"."<<endl;
					throw o.str();
				}
				tempPC = imm;
			break;
			case 16:   // rts, 
				//check sign of imm
				r[127]--; //this is positive (or should be) ATTENTION ICI !! Pfff ça m'a fait perdre beaucoup de temps
				tempPC= mem[r[127]]+1;
			break;
			case 17:   // nop,
				//cout << "NOP !" << endl;
				//sleep(1);
			break;
			case 18:   // add,
				
				v_acc= r[0];
				v_reg= r[reg];
				
				v_acc = v_acc + v_reg;
				sign_r0 = r[0]>>15;
				sign_r = r[reg]>>15;
				
				r[0] = v_acc & 0xFFFF;
				if ((sign_r0 ^ sign_r)==1){ //different signs
					flagV == 0;
					flagN = (r[0]>>15);	
				}
				else
					if ((sign_r0 & sign_r)==1){ //negative both
						//ATTENTION
						rval = v_acc - (2<<16);
						flagV = (rval<-32768 || rval>32767);
						flagN=1;
					}
					else 
					if ((sign_r0 | sign_r)==0){ //positive both
						flagV=(v_acc>32767);
						flagN=0;					
					}

				flagZ = (r[0]==0);
				
 
			break;
			case 19:   // sub,
				
				v_acc= r[0];
				v_reg= (1<<16)-r[reg];
				
				v_acc = v_acc + v_reg;
				sign_r0 = r[0]>>15;
				sign_r = (r[reg]>>15) ^ 1; 
				
				
				
				r[0] = v_acc & 0xFFFF;
				if ((sign_r0 ^ sign_r)==1){ //different signs
					flagV == 0;
					flagN = (r[0]>>15);	
				}
				else
					if ((sign_r0 & sign_r)==1){ //negative both
						//ATTENTION
						rval = v_acc - (2<<16);
						flagV = (rval<-32768 || rval>32767);
						flagN=1;
					}
					else 
					if ((sign_r0 | sign_r)==0){ //positive both
						flagV=(v_acc>32767);
						flagN=0;					
					}

				flagZ = (r[0]==0);
				
			break;
			case 20:   // mul,
				
				sign_r0 = (0xFFFF & r[0])>>15;
				sign_r  = (0xFFFF & r[reg])>>15;
				
				int res;
				
				// NON MAIS C'ETAIT QUOI CETTE MULTIPLICATION A 8 BITS ?
				flagV=0;
				if (( sign_r0 ^ sign_r )==0) //positive result
				{
					if (sign_r == 1) { //negative terms
						res = (65536 - (r[0] & 0xFFFF))*(65536 - (r[reg] & 0xFFFF));
					} else { //positive terms
						res = (r[0] & 0xFFFF) * (r[reg] & 0xFFFF);
					}
					flagV = res>65535;
					flagN = 0;										
				}else{ //negative x positive = negative //ATTENTION
					if (sign_r == 1) //
						res = 65536 - (((r[0] & 0xFFFF))*(65536 - (r[reg] & 0xFFFF)));
					else
						res = 65536 - ((65536 - (r[0] & 0xFFFF))*((r[reg] & 0xFFFF)));		
					flagV = res<-65536;
					flagN=1;	
				}
				r[0]=res & 0xFFFF;
				
				
			break;
			case 21:   //cmp : interprétation de ouf : je fais la différence et je ne garde que les flags
				/*temp  = r[0] - r[reg];
				if (temp==0){
					flagV=0;flagN=0;flagZ=1;								
				}else{
					flagV=0;flagN=0;flagZ=0;}*/


				v_acc= r[0];
				v_reg= (1<<16)-r[reg];
				
				v_acc = v_acc + v_reg;
				sign_r0 = r[0]>>15;
				sign_r = (r[reg]>>15) ^ 1; 

				;
				flagV == 0;
				if ((sign_r0 ^ sign_r)==1){ //different signs
					flagN = ((v_acc & 0xFFFF)>>15);	
				}
				else
					if ((sign_r0 & sign_r)==1){ //negative both
						rval = v_acc - (2<<16);
						flagN=1;
					}
					else 
					if ((sign_r0 | sign_r)==0){ //positive both
						flagN=0;					
					}

				flagZ = ((v_acc & 0xFFFF)==0);




			break;
			case 22:   // swap, 
				r[reg] = (r[reg] >> 8) + ((r[reg] & 0xFF)<<8); 
				if (r[reg]==0){
					flagZ=1;flagN=0;flagV=0;}								
				else{
					flagZ=0;flagN=0;flagV=0;}
			break;			
			case 23: //clear
				r[reg]=0;
				if (r[reg]==0)
					{flagZ=1;flagN=0;flagV=0;}								
				else
					{flagZ=0;flagN=0;flagV=0;}
			break;
			case 24: //and
				r[0] = r[0] & r[reg];
				if (r[0]==0)
					{flagZ=1;flagN=0;flagV=0;}								
				else
					{flagZ=0;flagN=0;flagV=0;}
			break;
			case 25: //or
				r[0] = r[0] | r[reg];
				if (r[0]==0)
					{flagZ=1;flagN=0;flagV=0;}								
				else
					{flagZ=0;flagN=0;flagV=0;}
			break;
			case 26: //xor
				r[0] = r[0] ^ r[reg];
				if (r[0]==0)
					{flagZ=1;flagN=0;flagV=0;}								
				else
					{flagZ=0;flagN=0;flagV=0;}
			break;
			case 27: //not
				r[0] = r[reg] ^ 0xFFFF;
				if (r[0]==0)
					{flagZ=1;flagN=0;flagV=0;}								
				else
					{flagZ=0;flagN=0;flagV=0;}
			break;
			case 28: //lsr
				r[0] = (r[0]>>r[reg]);
				if (r[0]==0)
					{flagZ=1;flagN=0;flagV=0;}								
				else
					{flagZ=0;flagN=0;flagV=0;}
			break;
			case 29: //lsl
				r[0] = (r[0]<<r[reg]);
				if (r[0]==0)
					{flagZ=1;flagN=0;flagV=0;}								
				else
					{flagZ=0;flagN=0;flagV=0;}
			break;
			case 30: //ror
				val=0;
				for (j=0;j<r[reg];j++)
					val += 1<<j;//pow(2,j);
				r[0] = (r[0]>>r[reg]) + ((r[0] & val)<<r[reg]);
				if (r[0]==0)
					{flagZ=1;flagN=0;flagV=0;}								
				else
					{flagZ=0;flagN=0;flagV=0;}
			break;
			case 31: //rol
				val=0;
				for (j=15;j>15-r[reg];j--)
					val+= 1<<j; //pow(2,j);
				r[0] = (r[0]>>r[reg]) + ((r[0]&val)>>(16-r[reg])); //TODO
				if (r[0]==0)
					{flagZ=1;flagN=0;flagV=0;}								
				else
					{flagZ=0;flagN=0;flagV=0;}
			break;
		}
	}
	
	
	if (doInstr==true)
		if (tempPC>-1)
			pc = tempPC;	 	
		else
			pc++;
	else {
		pc++;
	}

	if (setFlags==false) {
		flagV=tempFlagV;
		flagN=tempFlagN;
		flagZ=tempFlagZ;
	}
	
	doInstr = false;	

}

/*
utilisation :
simu -v : verbose mode
simu -a 57 : actualise l'affichage seulement tous les 57 pas

pas défaut : 10
ces options ne sont pas cumulables. (en même temps, le -v ralentit l'exécution.)

*/



int main(int argc, char* argv[])
{
	verbose = 0;
	if (argc>1) {
		string opt(argv[1]);
		if(opt=="-v")
			verbose=1;
	}
	int updateper = 10;
	if (argc>2) {
		string opt(argv[1]);
		if(opt=="-a") {
		    string par(argv[2]);
		    istringstream sstr(par);
    		sstr >> updateper;
		}
	}
	
	try{
		charROMInit();
	}catch (std::string s) {
		cerr << "Exception while parsing command line: " << s << endl;
		return 1;
	}

	//X window initialization
	Display *dpy = XOpenDisplay(NULL);

	Window w = XCreateSimpleWindow(dpy, DefaultRootWindow(dpy), 
				 0, 0, 640, 480,
				 0, BlackPixel(dpy, DefaultScreen(dpy)), 
				 BlackPixel(dpy, DefaultScreen(dpy)));
	XMapWindow(dpy, w);
	XStoreName(dpy, w, "ASR1 2008 RISC simulator");
	XSelectInput(dpy, w, ExposureMask | KeyPressMask);

	GC gc = XCreateGC(dpy, w, 0, NULL);
	XImage *img = XCreateImage(dpy, DefaultVisual(dpy, DefaultScreen(dpy)), 
			     24, ZPixmap, 0,
			     (char *)video, 640, 480, 32, 640*4);
	
	// fist update to the video memory
	parse();	
	render_all();
	
	XPutImage(dpy, w, gc, img, 0, 0, 0, 0, 640, 480);
	XFlush(dpy);

	pc = 0x0800;
	
	int n=0;

	while (true) {
		step();
		if(!((++n)%updateper)) {
			render_all();
			XPutImage(dpy, w, gc, img, 0, 0, 0, 0, 640, 480);
			XFlush(dpy);
		}
	}

	return 0;
}
