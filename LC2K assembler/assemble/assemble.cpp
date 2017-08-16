/* Assembler code fragment for LC-2K */
#define  _CRT_SECURE_NO_WARNINGS
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include<math.h>
#include <stack>
#define MAXLINELENGTH 1000

int readAndParse(FILE *, char *, char *, char *, char *, char *);
int isNumber(char *);
char* registernum(char*);
char* dectobin(int,int);
void bintohex(FILE *, FILE *);
char* bintohex(char*);
void bintodec(FILE *, FILE *);
int bintodec(char*);


int
main(int argc, char *argv[])
{
	char *inFileString, *outFileString,*tempFileString;
	FILE *inFilePtr, *outFilePtr,*tempFilePtr;
	char label[MAXLINELENGTH], opcode[MAXLINELENGTH],
		arg0[MAXLINELENGTH], arg1[MAXLINELENGTH], arg2[MAXLINELENGTH];
	
	int programcontrol = 0;
	if (argc != 3) {
		printf("error: usage: %s <assembly-code-file> <machine-code-file>\n",
			argv[0]);
		exit(1);
	}
	inFileString = argv[1];
	outFileString =argv[2];

	tempFileString = "binary.txt";
	inFilePtr = fopen(inFileString, "r");
	if (inFilePtr == NULL) {
		printf("error in opening %s\n", inFileString);
		exit(1);
	}

	tempFilePtr = fopen(tempFileString, "w");
	if (tempFilePtr == NULL) {
		printf("error in opening %s\n", tempFileString);
		exit(1);
	}

	/* here is an example for how to use readAndParse to read a line from
	inFilePtr */
	if (!readAndParse(inFilePtr, label, opcode, arg0, arg1, arg2)) {
		/* reached end of file */
	}


	while (!feof(inFilePtr))
	{
		programcontrol++;
		/* this is how to rewind the file ptr so that you start reading from the
		beginning of the file
		rewind(inFilePtr);*/

		/* after doing a readAndParse, you may want to do the following to test the opcode */
		if (!strcmp(opcode, "add")) {
			/* do whatever you need to do for opcode "add" */
			fprintf(tempFilePtr, "%s", "0000000000");
			fprintf(tempFilePtr, "%s", registernum(arg0));
			fprintf(tempFilePtr, "%s", registernum(arg1));
			fprintf(tempFilePtr, "%s", "0000000000000");
			fprintf(tempFilePtr, "%s\n", registernum(arg2));
		}
		else if (!strcmp(opcode, "nand")) {
			/* do whatever you need to do for opcode "nand" */
			fprintf(tempFilePtr, "%s", "0000000001");
			fprintf(tempFilePtr, "%s", registernum(arg0));
			fprintf(tempFilePtr, "%s", registernum(arg1));
			fprintf(tempFilePtr, "%s", "0000000000000");
			fprintf(tempFilePtr, "%s\n", registernum(arg2));
		}
		else if (!strcmp(opcode, "lw")){
			/* do whatever you need to do for opcode "lw" */
			fprintf(tempFilePtr, "%s", "0000000010");
			fprintf(tempFilePtr, "%s", registernum(arg0));
			fprintf(tempFilePtr, "%s", registernum(arg1));
			if (isNumber(arg2)){
				int num;
				sscanf(arg2, "%d", &num);
				if (num <= 32767 && num >= -32768){
					char* result = dectobin(num, 16);
					fprintf(tempFilePtr, "%s\n", result);
				}
				else
				{
					printf("%s", "OffsetFields that don't fit in 16 bits");
					exit(1);
				}
			}
			else
			{
				rewind(inFilePtr);
				char temp[MAXLINELENGTH];
				strcpy(temp, arg2);
				bool check = false;
				int labelnum = 0;
				int commandnum = 0;
				while (!feof(inFilePtr))
				{
					if (!readAndParse(inFilePtr, label, opcode, arg0, arg1, arg2)) {
						/* reached end of file */
					}
					if (!strcmp(temp, label) && !check)
					{
						labelnum = commandnum;
						check = true;
					}
					else if (!strcmp(temp, label) && check)
					{
						printf("%s", "Duplicate labels are dected!");
						exit(1);
					}
					commandnum++;
				}
				if (!check)
				{
					printf("%s", "Undefined labels are dected!");
					exit(1);
				}

				rewind(inFilePtr);
				for (int i = 0; i < programcontrol; i++)
				if (!readAndParse(inFilePtr, label, opcode, arg0, arg1, arg2)) {
					/* reached end of file */
				}

				char* result = dectobin(labelnum, 16);
				fprintf(tempFilePtr, "%s\n", result);
			}
		}
		else if (!strcmp(opcode, "sw")){
			/* do whatever you need to do for opcode "sw" */
			fprintf(tempFilePtr, "%s", "0000000011");
			fprintf(tempFilePtr, "%s", registernum(arg0));
			fprintf(tempFilePtr, "%s", registernum(arg1));
			if (isNumber(arg2)){
				int num;
				sscanf(arg2, "%d", &num);
				if (num <= 32767 && num >= -32768){
					char* result = dectobin(num, 16);
					fprintf(tempFilePtr, "%s\n", result);
				}
				else
				{
					printf("%s", "OffsetFields that don't fit in 16 bits");
					exit(1);
				}
			}
			else
			{
				rewind(inFilePtr);
				char temp[MAXLINELENGTH];
				strcpy(temp, arg2);
				bool check = false;
				int labelnum = 0;
				int commandnum = 0;
				while (!feof(inFilePtr))
				{
					if (!readAndParse(inFilePtr, label, opcode, arg0, arg1, arg2)) {
						/* reached end of file */
					}
					if (!strcmp(temp, label) && !check)
					{
						labelnum = commandnum;
						check = true;
					}
					else if (!strcmp(temp, label) && check)
					{
						printf("%s", "Duplicate labels are dected!");
						exit(1);
					}
					commandnum++;
				}
				if (!check)
				{
					printf("%s", "Undefined labels are dected!");
					exit(1);
				}

				rewind(inFilePtr);
				for (int i = 0; i < programcontrol; i++)
				if (!readAndParse(inFilePtr, label, opcode, arg0, arg1, arg2)) {
					/* reached end of file */
				}

				char* result = dectobin(labelnum, 16);
				fprintf(tempFilePtr, "%s\n", result);
			}
		}
		else if (!strcmp(opcode, "beq")){
			/* do whatever you need to do for opcode "beq" */
			fprintf(tempFilePtr, "%s", "0000000100");
			fprintf(tempFilePtr, "%s", registernum(arg0));
			fprintf(tempFilePtr, "%s", registernum(arg1));
			if (isNumber(arg2)){
				int num;
				sscanf(arg2, "%d", &num);
				if (num <= 32767 && num >= -32768){
					char* result = dectobin(num, 16);
					fprintf(tempFilePtr, "%s\n", result);
				}
				else
				{
					printf("%s", "OffsetFields that don't fit in 16 bits");
					exit(1);
				}
			}
			else
			{
				rewind(inFilePtr);
				char temp[MAXLINELENGTH];
				strcpy(temp, arg2);
				bool check = false;
				int labelnum = 0;
				int commandnum = 0;
				while (!feof(inFilePtr))
				{
					if (!readAndParse(inFilePtr, label, opcode, arg0, arg1, arg2)) {
						/* reached end of file */
					}
					if (!strcmp(temp, label) && !check)
					{
						labelnum = commandnum;
						check = true;
					}
					else if (!strcmp(temp, label) && check)
					{
						printf("%s", "Duplicate labels are dected!");
						exit(1);
					}
					commandnum++;
				}
				if (!check)
				{
					printf("%s", "Undefined labels are dected!");
					exit(1);
				}

				rewind(inFilePtr);
				for (int i = 0; i < programcontrol; i++)
				if (!readAndParse(inFilePtr, label, opcode, arg0, arg1, arg2)) {
					/* reached end of file */
				}

				char* result = dectobin(labelnum-programcontrol, 16);
				fprintf(tempFilePtr, "%s\n", result);
			}
		}
		else if (!strcmp(opcode, "jalr")) {
			/* do whatever you need to do for opcode "jalr" */
			fprintf(tempFilePtr, "%s", "0000000101");
			fprintf(tempFilePtr, "%s", registernum(arg0));
			fprintf(tempFilePtr, "%s", registernum(arg1));
			fprintf(tempFilePtr, "%s\n", "00000000000000000");
		}
		else if (!strcmp(opcode, "halt")) {
			/* do whatever you need to do for opcode "halt" */
			fprintf(tempFilePtr, "%s\n", "00000001100000000000000000000000");
		}
		else if (!strcmp(opcode, "noop")) {
			/* do whatever you need to do for opcode "noop" */
			fprintf(tempFilePtr, "%s\n", "00000001110000000000000000000000");
		}	
		else if (!strcmp(opcode, ".fill")) {
			/* do whatever you need to do for direction ".fill" */
			if (isNumber(arg0))
			{
				int num;
				sscanf(arg0, "%d", &num);
				char* result = dectobin(num, 32);
				fprintf(tempFilePtr, "%s\n",result);
			}
			else
			{
				rewind(inFilePtr);
				char temp[MAXLINELENGTH];
				strcpy(temp, arg0);
				bool check = false;
				int labelnum = 0;
				int commandnum = 0;
				while (!feof(inFilePtr))
				{
					if (!readAndParse(inFilePtr, label, opcode, arg0, arg1, arg2)) {
						/* reached end of file */
					}
					if (!strcmp(temp, label) && !check)
					{
						labelnum = commandnum;
						check = true;
					}
					else if (!strcmp(temp, label) && check)
					{
						printf("%s", "Duplicate labels are dected!");
						exit(1);
					}
					commandnum++;
				}
				if (!check)
				{
					printf("%s", "Undefined labels are dected!");
					exit(1);
				}

				rewind(inFilePtr);
				for (int i = 0; i < programcontrol; i++)
				if (!readAndParse(inFilePtr, label, opcode, arg0, arg1, arg2)) {
					/* reached end of file */
				}

				char* result = dectobin(labelnum, 32);
				fprintf(tempFilePtr, "%s\n", result);
			}
		}
		else{
			printf("%s", "Unrecognized opcodes are detected!");
			printf("%s", "The unrecognized opcode is ");
			printf("%s", opcode);
			exit(1);
		}
		if (!readAndParse(inFilePtr, label, opcode, arg0, arg1, arg2)) {
			/* reached end of file */
		}
	}
	fclose(inFilePtr);
	fclose(tempFilePtr);

	tempFilePtr = fopen(tempFileString, "r");
	if (tempFilePtr == NULL) {
		printf("error in opening %s\n", tempFileString);
		exit(1);
	}
	outFilePtr = fopen(outFileString, "w");
	if (outFilePtr == NULL) {
		printf("error in opening %s\n", outFileString);
		exit(1);
	}
	bintohex(tempFilePtr, outFilePtr);
	fclose(tempFilePtr);
	fclose(outFilePtr);
	return(0);
}

/*
* Read and parse a line of the assembly-language file.  Fields are returned
* in label, opcode, arg0, arg1, arg2 (these strings must have memory already
* allocated to them).
*
* Return values:
*     0 if reached end of file
*     1 if all went well
*
* exit(1) if line is too long.
*/
void 
bintohex(FILE *in, FILE *out){
	char line[MAXLINELENGTH];
	char *ptr = line;
	if (fgets(line, MAXLINELENGTH, in) == NULL) {
		/* reached end of file */
		exit(0);
	}
	/* check for line too long (by looking for a \n) */
	if (strchr(line, '\n') == NULL) {
		/* line too long */
		printf("error: line too long\n");
		exit(1);
	}
	char a[MAXLINELENGTH], b[MAXLINELENGTH], c[MAXLINELENGTH], d[MAXLINELENGTH], e[MAXLINELENGTH], f[MAXLINELENGTH], g[MAXLINELENGTH], h[MAXLINELENGTH];
	sscanf(ptr, "%4s%4s%4s%4s%4s%4s%4s%4s", a, b, c, d, e, f, g, h);
	fprintf(out,"0x%s%s%s%s%s%s%s%s\n", bintohex(a), bintohex(b), bintohex(c), bintohex(d),
		bintohex(e), bintohex(f), bintohex(g), bintohex(h));
	while (!feof(in))
	{
		line[0] = a[0] = b[0] = c[0] = d[0] = e[0] = f[0] = g[0] = h[0];
		ptr = line;
		if (fgets(line, MAXLINELENGTH, in) == NULL) {
			/* reached end of file */
			exit(0);
		}
		/* check for line too long (by looking for a \n) */
		if (strchr(line, '\n') == NULL) {
			/* line too long */
			printf("error: line too long\n");
			exit(1);
		}
		sscanf(ptr, "%4s%4s%4s%4s%4s%4s%4s%4s", a, b, c, d, e, f, g, h);
		fprintf(out, "0x%s%s%s%s%s%s%s%s\n", bintohex(a), bintohex(b), bintohex(c), bintohex(d),
			bintohex(e), bintohex(f), bintohex(g), bintohex(h));
	}
}
void
bintodec(FILE *in, FILE *out){
	char line[MAXLINELENGTH];
	char *ptr = line;
	if (fgets(line, MAXLINELENGTH, in) == NULL) {
		/* reached end of file */
		exit(0);
	}
	/* check for line too long (by looking for a \n) */
	if (strchr(line, '\n') == NULL) {
		/* line too long */
		printf("error: line too long\n");
		exit(1);
	}
	
	fprintf(out, "%d\n", bintodec(ptr));
	while (!feof(in))
	{
		line[0] = '\0';
		ptr = line;
		if (fgets(line, MAXLINELENGTH, in) == NULL) {
			/* reached end of file */
			exit(0);
		}
		/* check for line too long (by looking for a \n) */
		if (strchr(line, '\n') == NULL) {
			/* line too long */
			printf("error: line too long\n");
			exit(1);
		}
		fprintf(out, "%d\n", bintodec(ptr));
	}
}
int 
readAndParse(FILE *inFilePtr, char *label, char *opcode, char *arg0,
char *arg1, char *arg2)
{
	char line[MAXLINELENGTH];
	char *ptr = line;

	/* delete prior values */
	label[0] = opcode[0] = arg0[0] = arg1[0] = arg2[0] = '\0';

	/* read the line from the assembly-language file */
	if (fgets(line, MAXLINELENGTH, inFilePtr) ==NULL) {
		/* reached end of file */
		return(0);
	}

	/* check for line too long (by looking for a \n) */
	if (strchr(line, '\n') == NULL) {
		/* line too long */
		printf("error: line too long\n");
		exit(1);
	}

	/* is there a label? */
	ptr = line;
	if (sscanf(ptr, "%[^\t\n ]", label)) {
		/* successfully read label; advance pointer over the label */
		ptr += strlen(label);
	}

	/*
	* Parse the rest of the line.  Would be nice to have real regular
	* expressions, but scanf will suffice.
	*/
	sscanf(ptr, "%*[\t\n ]%[^\t\n ]%*[\t\n ]%[^\t\n ]%*[\t\n ]%[^\t\n ]%*[\t\n ]%[^\t\n ]",
		opcode, arg0, arg1, arg2);
	return(1);
}

int
isNumber(char *string)
{
	/* return 1 if string is a number */
	int i;
	return((sscanf(string, "%d", &i)) == 1);
}
char*
registernum(char* num)
{
	switch (*num)
	{
	case '0':return "000"; break;
	case '1':return "001"; break;
	case '2':return "010"; break;
	case '3':return "011"; break;
	case '4':return "100"; break;
	case '5':return "101"; break;
	case '6':return "110"; break;
	case '7':return "111"; break;
	}
}
char*
dectobin(int num,int size)
{
	char temp[33] = "";
	char *tempreturn = new char[33];
	std::stack<char*> s;
	if (num >= 0)
	{
		while (num != 0)
		{
			if (num % 2 == 0)
				s.push("0");
			else
				s.push("1");
			num /= 2;
		}
		int tempszie = size - s.size();
		char* zero = "0";
		for (int i = 0; i < tempszie; i++)
			strcat(temp, zero);
		while (!s.empty())
		{
			strcat(temp, s.top());
			s.pop();
		}
		strcpy(tempreturn, temp);
	}
	else
	{
		int absnum = -1 * num;
		while (absnum != 0)
		{
			if (absnum % 2 == 0)
				s.push("0");
			else
				s.push("1");
			absnum /= 2;
		}
		int tempszie = size - s.size();
		char* zero = "0";
		for (int i = 0; i < tempszie; i++)
			strcat(temp, zero);
		while (!s.empty())
		{
			strcat(temp, s.top());
			s.pop();
		}
		int index = 0;
		for (int i = 32; i >= 0; i--)
		if (temp[i] == '1')
		{
			index = i;
			break;
		}
		for (int i = index - 1; i >= 0;i--)
		if (temp[i] == '1')
			temp[i] = '0';
		else
			temp[i] = '1';
		strcpy(tempreturn, temp);
	}
	return tempreturn;
}
char*
bintohex(char* hex)
{
	if (!strcmp(hex, "0000"))
		return "0";
	else if (!strcmp(hex, "0001"))
		return "1";
	if (!strcmp(hex, "0010"))
		return "2";
	if (!strcmp(hex, "0011"))
		return "3";
	if (!strcmp(hex, "0100"))
		return "4";
	if (!strcmp(hex, "0101"))
		return "5";
	if (!strcmp(hex, "0110"))
		return "6";
	if (!strcmp(hex, "0111"))
		return "7";
	if (!strcmp(hex, "1000"))
		return "8";
	if (!strcmp(hex, "1001"))
		return "9";
	if (!strcmp(hex, "1010"))
		return "a";
	if (!strcmp(hex, "1011"))
		return "b";
	if (!strcmp(hex, "1100"))
		return "c";
	if (!strcmp(hex, "1101"))
		return "d";
	if (!strcmp(hex, "1110"))
		return "e";
	if (!strcmp(hex, "1111"))
		return "f";
}
int
bintodec(char *num)
{
	int sum = 0;
	for (int i = 0; i < 32; i++)
		sum += (num[i] - '0')*pow(2.0, 32 - i - 1);
	return sum;
}
