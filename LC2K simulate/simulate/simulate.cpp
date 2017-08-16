#define  _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include<cstringt.h>
#include <string>
#include<cmath>
using namespace std;
#define NUMMEMORY 65536 /* maximum number of words in memory */
#define NUMREGS 8 /* number of machine registers */
#define MAXLINELENGTH 1000

typedef struct stateStruct {
	int pc;
	int mem[NUMMEMORY];
	int reg[NUMREGS];
	int numMemory;
} stateType;

void printState(stateType *);
int convertNum(int num);
string processnum(int num);
int regnum(string num);
int offsetnum(string num);
int
main(int argc, char *argv[])
{
	char line[MAXLINELENGTH];
	stateType state;

	memset(state.mem, 0, sizeof(state.mem));
	memset(state.reg, 0, sizeof(state.reg));

	FILE *filePtr;

	if (argc != 2) {
		printf("error: usage: %s <machine-code file>\n", argv[0]);
		exit(1);
	}

	filePtr = fopen(argv[1], "r");
	if (filePtr == NULL) {
		printf("error: can't open file %s", argv[1]);
		perror("fopen");
		exit(1);
	}

	int instruction = 0;
	state.pc = 0;
	/* read in the entire machine-code file into memory */
	for (state.numMemory = 0; fgets(line, MAXLINELENGTH, filePtr) != NULL;
		state.numMemory++) {
		if (sscanf(line, "%d", state.mem + state.numMemory) != 1) {
			printf("error in reading address %d\n", state.numMemory);
			exit(1);
		}
		printf("memory[%d]=%d\n", state.numMemory, state.mem[state.numMemory]);
	}

	rewind(filePtr);
	for (state.pc = 0; fgets(line, MAXLINELENGTH, filePtr) != NULL;
		 state.pc++) {
		int processnumber = 0;
		sscanf(line, "%d", &processnumber);
		string command = processnum(processnumber);
		if (command.substr(7, 3) == "000")
		{
			printState(&state);
			int rega = 0;
			int regb = 0;
			int desreg = 0;
			rega = regnum(command.substr(10, 3));
			regb = regnum(command.substr(13, 3));
			desreg = regnum(command.substr(29, 3));
			state.reg[desreg] = state.reg[rega] + state.reg[regb];
			instruction++;
		}//add
		else if (command.substr(7, 3) == "001")
		{
			printState(&state);
			int rega = 0;
			int regb = 0;
			int desreg = 0;
			rega = regnum(command.substr(10, 3));
			regb = regnum(command.substr(13, 3));
			desreg = regnum(command.substr(29, 3));
			state.reg[desreg] = !(state.reg[rega] & state.reg[regb]);
			instruction++;
		}//nand
		else if (command.substr(7, 3) == "010")
		{
			printState(&state);
			int rega = 0;
			int regb = 0;
			int offset = 0;
			rega = regnum(command.substr(10, 3));
			regb = regnum(command.substr(13, 3));
			offset = offsetnum(command.substr(16,16));
			state.reg[regb] = state.mem[state.reg[rega]+offset];
			instruction++;
		}//lw
		else if (command.substr(7, 3) == "011")
		{
			printState(&state);
			int rega = 0;
			int regb = 0;
			int offset = 0;
			rega = regnum(command.substr(10, 3));
			regb = regnum(command.substr(13, 3));
			offset = offsetnum(command.substr(16, 16));
			state.mem[state.reg[rega] + offset] = state.reg[regb];
			instruction++;
			if (state.numMemory < state.reg[rega] + offset+1)
				state.numMemory = state.reg[rega] + offset+1;
		}//sw
		else if (command.substr(7, 3) == "100")
		{
			printState(&state);
			int rega = 0;
			int regb = 0;
			int offset = 0;
			rega = regnum(command.substr(10, 3));
			regb = regnum(command.substr(13, 3));
			offset = offsetnum(command.substr(16, 16));
			if (state.reg[rega] == state.reg[regb])
			{
				int newnumMemory = state.pc + 1 + offset;
				rewind(filePtr);
				while (newnumMemory--)
					fgets(line, MAXLINELENGTH, filePtr);
				state.pc += offset;
			}
			instruction++;
		}//beq
		else if (command.substr(7, 3) == "101")
		{
			printState(&state);
			int rega = 0;
			int regb = 0;
			int offset = 0;
			rega = regnum(command.substr(10, 3));
			regb = regnum(command.substr(13, 3));
			offset = offsetnum(command.substr(16, 16));
			state.reg[regb] = state.pc + 1;
			int newnumMemory = state.reg[rega];
			rewind(filePtr);
			while (newnumMemory--)
				fgets(line, MAXLINELENGTH, filePtr);
			state.pc =state.reg[rega]-1;
			instruction++;
		}//jalr
		else if (command.substr(7, 3) == "110")
		{
			printState(&state);
			instruction++;
			printf("%s\n", "machine halted");
			printf("%s%d%s\n", "total of ", instruction, " instructions executed");
			printf("%s\n", "final state of machine:");
			state.pc++;
			printState(&state);
			exit(0);
		}//halt
		else if (command.substr(7, 3) == "111")
		{
			instruction++;
		}//noop
	}
	return(0);
}

void
printState(stateType *statePtr)
{
	int i;
	printf("\n@@@\nstate:\n");
	printf("\tpc %d\n", statePtr->pc);
	printf("\tmemory:\n");
	for (i = 0; i<statePtr->numMemory; i++) {
		printf("\t\tmem[ %d ] %d\n", i, statePtr->mem[i]);
	}
	printf("\tregisters:\n");
	for (i = 0; i<NUMREGS; i++) {
		printf("\t\treg[ %d ] %d\n", i, statePtr->reg[i]);
	}
	printf("end state\n");
}
int
convertNum(int num)
{
	/* convert a 16-bit number into a 32-bit Linux integer */
	if (num & (1 << 15)) {
		num -= (1 << 16);
	}
	return(num);
}
string 
processnum(int num)
{
	string temp="00000000000000000000000000000000";
	int index = 31;
	while (num)
	{
		if (num % 2 == 1)
			temp[index] = '1';
		index--;
		num /= 2;
	}
	return temp;
}
int 
regnum(string num)
{
	if (num == "000")
		return 0;
	else if (num == "001")
		return 1;
	else if (num == "010")
		return 2;
	else if (num == "011")
		return 3;
	else if (num == "100")
		return 4;
	else if (num == "101")
		return 5;
	else if (num == "110")
		return 6;
	else if (num == "111")
		return 7;
}
int
offsetnum(string num)
{
	int sum = 0;
	for (int i = 15; i >=0;i--)
	if (num[i] == '1')
		sum += pow(2.0, 15-i);
	return convertNum(sum);
}