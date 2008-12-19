#include <cstdlib>
#include <iostream>
#include <iomanip>
#include <sstream>
#include <string>
#include <list>
#include <map>
#include <vector>
//#include <math.h>

using namespace std;

int verbose;
int way;

vector<uint32_t> hexcode; // the code is compiled into this vector

map<string, uint32_t> label;   // the labels 

// A structure set up in the first pass, and used in the second pass to resolve labels
enum atr_type {JMI, JMRI, JMSI, LDL, LDL16, LDL32} ;

struct address_to_resolve {
  uint32_t hexcode_index; // index in the hexcode vector
  int way;
  atr_type type;
  string label;
} ;

vector<address_to_resolve> todo; 



uint32_t line_number; // in the input file

uint32_t base_address = 0x0800; // address at which the code will be compiled
uint32_t current_address; // 


uint32_t read_condpred(list<string> &slist) {
	int pred_code=0;
	string s = slist.front();
	if (string(s, 0, 2) != "?p")  {  //implicit predicate p8 (nothing is done)
		return 7;
	}
	else {
		//Now the options are: GT, GE, EQ, NE, LE, OV, NV
		slist.pop_front();
		s = slist.front();
		if (s ==  "GT")  pred_code = 0;
		else if(s=="GE") pred_code = 1;
		else if(s=="EQ") pred_code = 2;
		else if(s=="NE") pred_code = 3;
		else if(s=="LE") pred_code = 4;
		else if(s=="LT") pred_code = 5;
		else if(s=="OV") pred_code = 6;
		else if(s=="NC") pred_code = 7;
		else{ 
			std::ostringstream o;
			o << "Error in " <<  __FILE__ << "@" << __LINE__ << ". Invalid option for predicate: got " << s << " expected: "
			  << "one of GT, GE, EQ, NE, LE, LT, OV, NC.";
			throw o.str();
		}
		slist.pop_front();
	}
	return pred_code;
}

uint32_t read_sr(list<string> &slist) {
  string s = slist.front();
  if (string(s, 0, 2).compare("!s")==1)  {  //implicit predicate p8 (nothing is done)
	return 0;
    }
  else {
		slist.pop_front();
		return 1;	
	}
}


uint32_t read_pred(list<string> &slist) {
  string s = slist.front();
  if (s[0]!='p')  { 
    cerr << "Error, line " << line_number << ": expected predicate register, got " << s << "'." << endl;
    exit(-1);
    }
  else {
    s.erase(0, 1);
    istringstream valstr(s);
    int val;
    valstr >> val;
    if (val < 0 || val > 7) {
      cerr << "Error, line " << line_number << ": invalid predicate register p" << s << "'." << endl;
      exit(-1);
    }
    slist.pop_front();
    return val;
  }
}


uint32_t read_reg(list<string> &slist) {
  string s = slist.front();
  if (s[0] != 'r')  {
    cerr << "Error, line " << line_number << ": expected register, got " << s << "'." << endl;
    exit(-1);
    }
  else {
    s.erase(0, 1);
    istringstream valstr(s);
    int val;
    valstr >> val;
    if (val < 0 || val > 127) {
      cerr << "Error, line " << line_number << ": invalid register r" << s << "'." << endl;
      exit(-1);
    }
    slist.pop_front();
    return val;
  }
}

uint32_t read_rx_ry(list<string>  & slist) {
  uint32_t code, rx, ry;
  code = 0;
  rx = read_reg(slist);
  code += rx<<4;
  ry = read_reg(slist);
  code += ry<<0;
  return code;
}

uint32_t read_rx(list<string>  & slist) {
  uint32_t code, rx;
  code = 0;
  rx = read_reg(slist);
  code += rx;
  return code;
}

uint32_t read_px_ry(list<string>  & slist) {
  uint32_t code, px, ry;
  code = 0;
  px = read_pred(slist);
  code += px<<4;
  ry = read_reg(slist);
  code += ry<<0;
  return code;
}

uint32_t read_int(string s) {
  uint32_t val;
  if(string(s, 0, 2) == "0x") {
    s.erase(0, 2);
    istringstream valstr(s);
    valstr >> hex >> val;
  }
  else {
    istringstream valstr(s);
    valstr >> val;
  }
  return val;
}

uint32_t read_imm8(list<string>  & slist){
  string s = slist.front();
  int val;
  
  if (s[0]=='-')
  val = read_int(string(s,1,s.length()-1));
	else
	val = read_int(s);
  
 if (s[0]=='-')
	val = -val;
  
 if (val < -128 || val > 127) {
    cerr << "Error, line " << line_number << ": invalid 8-bit immediate constant " << s << " with value "<<val<<"." << endl;
    exit(-1);
  }
  slist.pop_front();
  
  if (val>=0)
  	return val;
  else 
	return 256+val;
}


uint32_t read_imm8_or_label(list<string>  & slist, atr_type atrt){
  string s = slist.front();
  int val;
  if(s[0]<'0' || s[0]>'9' || s[0]!='-') { //assume a label
    address_to_resolve atr;
    atr.hexcode_index = hexcode.size();
    atr.type = atrt;
    atr.way = way;
    atr.label = s;
    todo.push_back(atr);
    slist.pop_front();
    return 0;
  }
  else { // assume a numeric constant
    
  if (s[0]=='-')
  val = read_int(string(s,1,s.length()-1));
	else
	val = read_int(s);
  
 if (s[0]=='-')
	val = -val;

    if (val < (-128) || val > 127) {
      cerr << "Error, line " << line_number << ": invalid 8-bit immediate constant " << s <<" with value "<<val<<" ." << endl;
      exit(-1);
    }
    slist.pop_front();
    return val;
  }
}


uint32_t read_imm16_or_label(list<string>  & slist){
  string s = slist.front();
  if(s[0]<'0' || s[0]>'9') { //assume a label
    address_to_resolve atr;
    atr.hexcode_index = hexcode.size();
    atr.type = LDL16;
    atr.label = s;
    todo.push_back(atr);
    return 0;
  }
  else { // assume a numeric constant
    istringstream valstr(s);
    uint32_t val = read_int(s);
    if (val < 0 || val > (1<<16)) {
      cerr << "Error, line " << line_number << ": invalid 16-bit immediate constant " << s << "'." << endl;
      exit(-1);
    }
    slist.pop_front();
    return val;
  }
}


// this function returns the 16-bit code of an instruction
uint32_t read_op(list<string>  & slist, uint32_t current_address) {
  uint32_t code;
  code = 0;
  uint32_t pred;
  // read the predicates if they exist, and put its number in place
  uint32_t sr = read_sr(slist);
  code += sr << 7;
  try{
  	pred = read_condpred(slist);
  }catch(std::string s){
		cerr << "Exception while parsing command line: " << s << endl;
		return 1;

  }

  code += pred << 8;
  
  // now read the instruction itself

  if (slist.front() == "ldl") { 
    slist.pop_front();
    code += 0 << 11; //opcode is 00000
	code += read_imm8(slist);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option not permitted in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}  
  }
  
  else if (slist.front() == "ldh") {
    slist.pop_front();
    code += 1<< 11;
    code += read_imm8(slist);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option not permitted in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  //TODO THIS IS FOR YOU 
  else if (slist.front() == "mv2reg") {
    slist.pop_front();
    code += 2 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "mv2acc") {
    slist.pop_front();
    code += 3 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "rd") {
    slist.pop_front();
    code += 4 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "wr") {
    slist.pop_front();
    code += 5 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "rdinc") {
    slist.pop_front();
    code += 6 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "wrinc") {
    slist.pop_front();
    code += 7 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "rddec") {
    slist.pop_front();
    code += 8 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "wrdec") {
    slist.pop_front();
    code += 9 << 11;
    code += read_reg(slist);
  }
  
  //Enregistre le numéro de la ligne en cours dans l'accumulateur, en partie basse
  //Transformé en "ldl xx" ou xx est l'adresse en cours modulo 256
  else if (slist.front() == "ldlline") {  
    slist.pop_front();
    code += 0 << 11;
    code += current_address%256;
  }
  //Enregistre le numéro de la ligne en cours dans l'accumulateur, en partie haute
  //Transformé en "ldh xx" ou xx est l'adresse en cours divisée par 256
  else if (slist.front() == "ldhline") {
    slist.pop_front();
    code += 1 << 11;
    code += current_address>>8;
  }
  
  
  else if (slist.front() == "jmp") {
    slist.pop_front();
    code += 10 << 11;
    code += read_reg(slist);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option useless in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else if (slist.front() == "jmr") {
    slist.pop_front();
    code += 11 << 11;
    code += read_reg(slist);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option useless in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else if (slist.front() == "jmi") {
    slist.pop_front();
    code += 12 << 11;
    code += read_imm8_or_label(slist, JMI);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option not permitted in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else if (slist.front() == "jmri") {
    slist.pop_front();
    code += 13 << 11; 
    code += read_imm8_or_label(slist, JMRI);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option useless in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else if (slist.front() == "jsr") {
    slist.pop_front();
    code += 14 << 11;
    code += read_reg(slist);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option nTODOd in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else if (slist.front() == "jsi") {
    slist.pop_front();
    code += 15 << 11;
    code += read_imm8_or_label(slist, JMSI);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option not permitted in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else if (slist.front() == "rts") {
    slist.pop_front();
    code += 16 << 11;
  }
  else if (slist.front() == "nop") {
    slist.pop_front();
    code += 17 << 11;
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option completely useless in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else if (slist.front() == "add") {
    slist.pop_front();
    code += 18 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "sub") {
    slist.pop_front();
    code += 19 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "mul") {
    slist.pop_front();
    code += 20 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "cmp") {
    slist.pop_front();
    code += 21 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "swap") {
    slist.pop_front();
    code += 22 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "clr") {
    slist.pop_front();
    code += 23 << 11;
    code += read_reg(slist);
 }
  else if (slist.front() == "and") {
    slist.pop_front();
    code += 24 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "or") {
    slist.pop_front();
    code += 25 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "xor") {
    slist.pop_front();
    code += 26 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "not") {
    slist.pop_front();
    code += 27 << 11;
    code += read_reg(slist);
  }
  else if (slist.front() == "lsr") {
    slist.pop_front();
    code += 28 << 11;
    code += read_imm8(slist);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option not permitted in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else if (slist.front() == "lsl") {
    slist.pop_front();
    code += 29 << 11;
    code += read_imm8(slist);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option not permitted in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else if (slist.front() == "ror") {
    slist.pop_front();
    code += 30 << 11;
    code += read_imm8(slist);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option not permitted in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else if (slist.front() == "rol") {
    slist.pop_front();
    code += 31 << 11;
    code += read_imm8(slist);
	if (sr>0) {
		cerr << "Error, line " << line_number << ": !s option not permitted in "<< slist.front() <<" ."<<  endl;
        exit(-1);
	}
  }
  else {
    cerr << "Error, line " << line_number << ": unknown opcode '" << slist.front() << "'." << endl;
    exit(-1);
  }
  return code;
}


/** This is where the fun part starts */
int main(int argc, char* argv[]){

	verbose = 0;
	if (argc>1) {
		string opt(argv[1]);
		if(opt=="-v")
		verbose=1;
	}


	line_number = 0; // the line in the source code
	current_address = base_address; // the address in the object code

	// Pass 1 
	if(verbose){
		cerr << "**** PASS 1 ****" << endl;
	}
	while (!cin.eof()) {

		// read a line
		char buf[256];
		cin.getline(buf, 256);
		string line(buf);
		line_number++;
		if (line.empty())
			continue;

		// break the line into tokens
		istringstream sstr(line);
		list<string> slist;
		while (!sstr.eof()) {
			string str;
			sstr >> str;
			if (str[0] == ';') // comment: stop parsing here
				break;      
			else
			{
				if (!str.empty()) 
				slist.push_back(str);
			}
		}

		if (!slist.empty()) {     // Now process the tokens
			string s;
			uint32_t code = 0;

			s = slist.front();
			
			//Ecrit les entiers à la place des instructions
			if (s.length()==4 && s=="data") {
				slist.pop_front();
				while(!slist.empty()) {
					s = slist.front();
					istringstream iss(s);
					int e;
					iss >> e;
					slist.pop_front();
					hexcode.push_back(e);
					current_address ++;
				}
			}
			
			//Ecrit les entiers à la place des instructions (codés en hexadécimal)
			if (s.length()==5 && s=="datax") {
				slist.pop_front();
				while(!slist.empty()) {
					s = slist.front();
					istringstream iss(s);
					int e;
					iss >> hex >> e;
					slist.pop_front();
					hexcode.push_back(e);
				}
			}

			//Ecrit les entiers à la place des instructions (signés)
			if (s.length()==10 && s=="datasigned") {
				slist.pop_front();
				while(!slist.empty()) {
					s = slist.front();
					istringstream iss(s);
					int e;
					iss >> e;
					if(e<0) e=(e+1)+0xFFFF;
					slist.pop_front();
					hexcode.push_back(e);
					current_address ++;
				}
			}


			// is the first token a label ?
			if (s[s.length()-1] == ':') {
				string id = s.substr(0, s.length()-1);
				// Does the label already exist ?
				if (label.find(id) != label.end()) {
					cerr << "Error, label " << id  << " already defined " << endl;
					exit(-1);  
				}
				label[id] = current_address;        
				slist.pop_front(); // remove it
				if(verbose){
					cerr << "label " << id << " @ " << setfill('0')  << setw(4) << hex << current_address <<endl;
				}
			}

			if (!slist.empty()) {     //proceed, if this is not a label
				s = slist.front();

				//normal instructions
				uint32_t instr = read_op(slist, current_address); //get the instruction code
				code = instr; //the code of the instruction
				hexcode.push_back(code);//put the code into hexcode /XXX only 5 bits not good for hex
				if(verbose){
					cerr << "@ " << setfill('0')  << setw(4) << hex << current_address  //TODO fix verbose printings
					<< ": "  << setw(4) << hex << code << endl;
				}
				current_address ++;

			}
		}
	}
	
	// Pass 2
	if(verbose){
		cerr << "**** PASS 2 ****" << endl;
	}

	// Fix all the missing labels
	for (uint32_t i=0; i<todo.size(); i++) {
		address_to_resolve atr = todo[i];
		uint32_t index = atr.hexcode_index;
		atr_type type = atr.type;
		string s = atr.label;
		uint32_t instr;

		// look up the label
		if (label.find(s) == label.end()) {
			cerr << "Error, label " << s  << " is used but not defined " << endl;
			exit(-1);  
		}
		// OK, the label exists
		uint32_t resolved_address = label[s];      
		uint32_t instr_address = base_address + index;
		// Now put the address to its proper place
		if ((type==JMRI) || (type==JMSI)) {
			instr = hexcode[index];
			int delta = resolved_address - instr_address;
			if(delta<-128 || delta>127) {
				cerr << "Error, jmri to label " << s  << " out of range (" << delta << ")" << endl;
				exit(-1);  
			}

			if (delta<0)
				delta = 256 + delta; //2's complement
			instr=instr+(delta);
			hexcode[index] = instr;
			if(verbose){
				cerr << "Resolved label " << s 
				<< ", at address " << setfill('0')  << setw(4) << hex << instr_address
				<< " code is now " << setfill('0')  << setw(4) << hex << instr << endl;
			}
		}

	}

	// Output
	if(verbose){
		cerr << "Outputing object code..." << endl;
	}
	for (uint32_t i=0; i<hexcode.size(); i++) {
		cout << setfill('0')  << setw(4) << hex << hexcode[i] << endl;
	}
	if(verbose){
		cerr << "...done" << endl;
	}
}


