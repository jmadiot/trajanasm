



/*
  simu.cc du cours ASR1 2008
  Ce fichier est distrubué sous licence GPL
*/
#include <iostream>
#include <iomanip>
#include <sstream>
#include <fstream>
#include <string>
#include <list>
#include <X11/Xlib.h>
#include <X11/keysym.h>
#include <cstdlib>
#include <math.h>

using namespace std;

int verbose;
int skip_frame_counter;

// The screen will be updated every FRAMESKIP  str to the screen
#define FRAMESKIP 10

#define TOPSCREEN 0x5000
#define TOPRAM 0x8000

// SIMULATOR DEPENDENT
uint32_t video[640*480]; //the size of the video memory


//PROCESSOR DEPENDENT
uint16_t r[128]; //128 registers on 16 bits 
uint32_t pc;     //16-bit program counter
bool p[3];       //the 3 predicates 
bool flags[3];   //processor has 3 flags, V=overflow, N=negative and Z=zero 

//DISPLAY DRIVER DEPENDENT
int dispMem[8192]; //should be 4800, but 8129 is 2^13 (there are 13 lines at the
                   //input of this memory) . This memory is mapped at address:
                   // 001 0000000000000 to 001 1111111111111
int charROM[256][8];

int mem[8192]; //the memory mapped at address 000 0000000000000 to 000 1111111111111



bool s_r0;
bool s_r;
int rval;
uint32_t v_acc;
uint32_t v_reg;
//------------------------------------------------------------------------------

/** 
 * converts a binary number under a string format into an integer
 * @param[in] s the input string containing the binary number
 * @return the integer corresponding to the positive binary number contain in s
 */
int b2ToInt(string s){
	if (s.length() != 8){
	std::ostringstream o;
		o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": length of s=" << s << " is not 8 ";
		throw o.str();
	}
 	unsigned int value=0;
	for (uint8_t i=0;i<s.length();i++)
 		value += pow(2,7-i)*(s[i]=='1'?1:0);
	
	return value;
}

/** 
 * Takes as input an unsigned integer x and an selector s.
 * Returns true if in the binary representation of x, the
 * corresponding coefficient of 2^s is 1, else false
 * @param[in] x - the input unsigned number
 * @param[in] s - the coefficient needed to be checked 
 * @return 1 if in binary representation coeff. of 2^s is 1, else 0
 */ 
bool char2bool(unsigned char x, unsigned char s){
unsigned char y;
	y=x>>s;
	return y%2;
}

/** 
 * initializes the ROM memory with the corresponding characters 
 */
void charROMInit(){

	ifstream is("rom.data"); // open a file stream

	string line; // S string for a line to read
	int i=0, j=0;
	while(is.good()) // As long as there's data
	{
		is >> line; // read a line                      //TODO:il doit y avoir moyen d'entrer les espaces là dedans
		//sscanf("%s", &line);
		if (is.good()){
			//cout << b2ToInt(line.substr(0,8))<< endl;
			charROM[i][j]=b2ToInt(line.substr(0,8));
			//cout << line.substr(0,8) << endl;
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
  for (int y = 0; y < 60; y++) {
    for (int x = 0; x < 80; x++) {
		for (uint8_t k1=0;k1<8;k1++)
			for (uint8_t k2=0;k2<8;k2++){
				unsigned char c = 255 ; //255=white; color is coded RRRGGBBB on 8 bits
				c=c*char2bool(charROM[dispMem[y*80+x]][k1],7-k2); 
	  			video[(8*(y)+k1)*(640)+8*x+k2]=((c&0xe0)<<16) + ((c&0x18)<<11) + ((c&0x7)<<5);
			}
    }
  }
}


int tractopelle = 0;


void step()
{
	bool doInstr = false;
	bool setFlags = false;
	int tempPC=-1;
	bool tempFlags[3];
	bool signRi;
	bool signImm;
	int temp;
	uint16_t dev;
	int j;
	uint16_t val;
	tractopelle++;
	//if(0==tractopelle%1000) printf("mem[0x50..0x53]=%+d %+d %+d %+d\n", mem[0x50], mem[0x51], mem[0x52], mem[0x53]);

	// FETCH
	uint16_t instr = mem[pc]; 			//fetch the instruction
	//DECODE	
	uint16_t instrCode  =  instr >> 11;  
	uint16_t instrPred  = (instr >> 8) & 0x7;
	uint16_t instrFlag  = (instr >> 7) & 0x1;
	setFlags = (instrFlag==0?0:1);
	
	
	uint16_t reg  =  instr & 0x7f;
	uint32_t imm =   instr & 0xff;

	if(verbose) {
	cout << "flags = " <<flags[2]<<flags[1]<<flags[0]<<endl;
	cout << "r0 = " << r[0]<<endl;
	cout << setfill('0')  << " pc="     << setw(4) << hex << pc 
	                      << " instr=" << setw(4) << hex << instr
	                      << " code=" << setw(2) << hex << instrCode
	                      << " imm=" << setw(2) << hex << imm
	                      << " pred="<< setw(1)<<hex<<instrPred<<endl;
	}

	//predicate execution: check if the instruction with instrCode will be executed
	//or the processor will just jump to the next one.
	//TODO check for corectness
		/*cout << "JM pc=" << pc << " ";
		int jmi;
		for(jmi=0; jmi<12; jmi++) {
			cout << r[jmi] << ";";
		}
		cout << endl;*/
	switch (instrPred) {
		case 0: // GT
			if (flags[2]==flags[1] && flags[0]==0)
				doInstr = true;
			break;
		case 1: // GE
			if (flags[2]==flags[1])
				doInstr = true;
			break;
		case 2: // EQ
			if (flags[0]==1)
				doInstr = true;
			break;
		case 3: // NE
			if (flags[0]==false)
				doInstr = true;
			break;
		case 4: // LE
			if (flags[2]!=flags[1] || flags[0]==1)
				doInstr = true;
			break;
		case 5: // LT
			if (flags[2]!=flags[1])
				doInstr = true;
			break;
		case 6: // OV
			if (flags[2]==1)
				doInstr = true;
			break;
		case 7: // NC
				doInstr = true;
			break;
	}	
	
	if(verbose) cout << "Do instruction ="<< doInstr <<endl;
	for (int i=0;i<3;i++)
		tempFlags[i] = flags[i];
	
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
			case 10:   // jmp 
				tempPC = r[reg];
			break;
			case 11:   // jmr, add Ri to PC
				//check sign of R[i]
				signRi = r[reg]>>15;
				if (signRi==0) 
					tempPC = pc + r[reg];
				else 
					tempPC = pc - r[reg];//TODO
			break;
			case 12:   // jmi
				if (imm>127) //trying to jump at a negative address
				{
					std::ostringstream o;
					o << "Error in " <<  __FILE__ << "@" << __LINE__ << ": Trying to jump with negative immediate "<<imm-256<<"."<<endl;
					throw o.str();
				} 
				tempPC = imm;
			break;
			case 13:   // jmrI, 
				//check sign of imm
				signImm = imm>>7;
				if (signImm==0) 
					tempPC = pc + imm; //jump forward
				else 
					tempPC = pc - ((imm ^ 0xFF)+1); //jump back
			break;
			case 14:   // jsr,
				//TODO check if we are not storing pc in video memory :P
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
				tempPC= mem[r[127]]+1;
				r[127]--; //this is positive (or should be)
			break;
			case 17:   // nop, 
			break;
			case 18:   // add,
				
				v_acc= r[0];
				v_reg= r[reg];
				
				v_acc = v_acc + v_reg;
				s_r0 = r[0]>>15;
				s_r = r[reg]>>15;
				
				
				
				r[0] =v_acc & 0xFFFF;
				if ((s_r0 ^ s_r)==1){ //different signs
					flags[2]=0;
					flags[1]=(r[0]>>15);	
				}
				else
					if ((s_r0 & s_r)==1){ //negative both
						rval = v_acc - (2<<17);
						if (rval<(-128) || rval>127)
							flags[2]=1;
						else
							flags[2]=0;
					flags[1]=1;											
					}else 
					if ((s_r0 | s_r)==0){ //positive both
						
						if (v_acc>127)
							flags[2]=1;
						else
							flags[2]=0;											
					flags[1]=0;					
					}

				if (r[0]==0)
					flags[0]=1;
				else
					flags[0]=0;
				
 
			break;
			case 19:   // sub,
				
				v_acc= r[0];
				v_reg= (1<<16)-r[reg];
				
				v_acc = v_acc + v_reg;
				s_r0 = r[0]>>15;
				s_r = (r[reg]>>15) ^ 1; 
				
				
				
				r[0] =v_acc & 0xFFFF;
				if ((s_r0 ^ s_r)==1){ //different signs
					flags[2]=0;
					flags[1]=(r[0]>>15);	
				}
				else
					if ((s_r0 & s_r)==1){ //negative both
						rval = v_acc - (2<<17);
						if (rval<(-128) || rval>127)
							flags[2]=1;
						else
							flags[2]=0;
					flags[1]=1;											
					}else 
					if ((s_r0 | s_r)==0){ //positive both
						
						if (v_acc>127)
							flags[2]=1;
						else
							flags[2]=0;											
					flags[1]=0;					
					}

				if (r[0]==0)
					flags[0]=1;
				else
					flags[0]=0;
				
			break;
			case 20:   // mul,
				
				s_r0 = (0xFF & r[0])>>7;
				s_r  = (0xFF & r[reg])>>7;

				flags[2]=0;
				if (( s_r0 ^ s_r )==0) //positive result
				{
					if (s_r == 1) //negative terms
						r[0] = (256 - (r[0] & 0xFF))*(256 - (r[reg] & 0xFF));
					else //positive terms
						r[0] = (r[0] & 0xFF) * (r[reg] & 0xFF);
				flags[1]=0;										
				}else{ //negative x positive = nagative
					if (s_r == 1) //
						r[0] = 256 - (((r[0] & 0xFF))*(256 - (r[reg] & 0xFF)));
					else
						r[0] = 256 - (((r[0] & 0xFF))*(256 - (r[reg] & 0xFF)));				
				}
				
				
			break;
			case 21:   //cmp
				temp  = r[0] - r[reg];
				if (temp==0){
					flags[2]=0;flags[1]=0;flags[0]=1;								
				}else{
					flags[2]=0;flags[1]=0;flags[0]=0;}
			break;
			case 22:   // swap, 
				r[reg] = (r[reg] >> 8) + ((r[reg] & 0xFF)<<8); 
				if (r[reg]==0){
					flags[2]=0;flags[1]=0;flags[0]=1;}								
				else{
					flags[2]=0;flags[1]=0;flags[0]=0;}
			break;			
			case 23: //clear
				r[reg]=0;
				if (r[reg]==0)
					{flags[2]=0;flags[1]=0;flags[0]=1;}								
				else
					{flags[2]=0;flags[1]=0;flags[0]=0;}
			break;
			case 24: //and
				r[0] = r[0] & r[reg];
				if (r[0]==0)
					{flags[2]=0;flags[1]=0;flags[0]=1;}								
				else
					{flags[2]=0;flags[1]=0;flags[0]=0;}
			break;
			case 25: //or
				r[0] = r[0] | r[reg];
				if (r[0]==0)
					{flags[2]=0;flags[1]=0;flags[0]=1;}								
				else
					{flags[2]=0;flags[1]=0;flags[0]=0;}
			break;
			case 26: //xor
				r[0] = r[0] ^ r[reg];
				if (r[0]==0)
					{flags[2]=0;flags[1]=0;flags[0]=1;}								
				else
					{flags[2]=0;flags[1]=0;flags[0]=0;}
			break;
			case 27: //not
				r[0] = r[reg] ^ 0xFFFF;
				if (r[0]==0)
					{flags[2]=0;flags[1]=0;flags[0]=1;}								
				else
					{flags[2]=0;flags[1]=0;flags[0]=0;}
			break;
			case 28: //lsr
				r[0] = (r[0]>>r[reg]);
				if (r[0]==0)
					{flags[2]=0;flags[1]=0;flags[0]=1;}								
				else
					{flags[2]=0;flags[1]=0;flags[0]=0;}
			break;
			case 29: //lsl
				r[0] = (r[0]<<r[reg]);
				if (r[0]==0)
					{flags[2]=0;flags[1]=0;flags[0]=1;}								
				else
					{flags[2]=0;flags[1]=0;flags[0]=0;}
			break;
			case 30: //ror
				val=0;
				for (j=0;j<r[reg];j++)
					val += pow(2,j);
				r[0] = (r[0]>>r[reg]) + ((r[0] & val)<<r[reg]);
				if (r[0]==0)
					{flags[2]=0;flags[1]=0;flags[0]=1;}								
				else
					{flags[2]=0;flags[1]=0;flags[0]=0;}
			break;
			case 31: //rol
				val=0;
				for (j=15;j>15-r[reg];j--)
					val+= pow(2,j);
				r[0] = (r[0]>>r[reg]) + ((r[0]&val)>>(16-r[reg])); //TODO
				if (r[0]==0)
					{flags[2]=0;flags[1]=0;flags[0]=1;}								
				else
					{flags[2]=0;flags[1]=0;flags[0]=0;}
			break;
		}
	}
	
	if (doInstr==true)
		if (tempPC>-1)
			pc = tempPC;	 	
		else
			pc++;
	else{
	pc++;
	}

	if (setFlags==false)
		for (j=0;j<3;j++)		
		flags[j]=tempFlags[j];
	
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
