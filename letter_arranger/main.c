#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>	// read/write/open



#define	BMP_HEADER_SIZE	sizeof(struct bmp_header)
#define	FILE_NAME	"./galmurim.bmp"
#define	OUT_FILE_NAME	"./output.txt"
#define	TBL_FILE_NAME	"./table.txt"

// 32 characters per Line
#define	FONT_X_OFFSET	18

#define VERSION		"1.02"

#pragma pack(push,1)
struct bmp_header {
	char bmp[3];
	unsigned char unused[11];
	unsigned int biSize;
	unsigned int biWidth;
	unsigned int biHeight;
	unsigned short biPlane;
	unsigned short biBitCount;
	unsigned int biCompression;
	unsigned int biSizeImage;
	unsigned int biXPelsPerMeter;
	unsigned int biYPelsPerMeter;
	unsigned int biCirUsed;
	unsigned int biClrImportant;
};
#pragma pack(pop)

struct testList{
	char *letter;
	unsigned char *noJong;
	int *repeatCnt;
};



unsigned char AtoI(unsigned char ch);
int UNICODEtoInt(char *ch);
int Table_mode(char *input_file, char *output_file);
int Anal_mode(char *input_file, char *output_file);
int Check_duplicate(char *letter, char *letters, int nMaxLetterSize, int nEnd);
//int unicode(char *font_value);
int utf8_to_unicode(char *uft8);
void ShowInfo(void);



int main(int argc, char** argv){
	int ret;
	int nArgc = 0;
	int nMode = 0;
	int i;
	char outputFileName[256] = OUT_FILE_NAME;
	char *inputFileName;

	if(argc < 2){
		ShowInfo();
		return 0;
	}

	// -a : script analysis mode
	// -t : make letter table mode
	// -o : output file name
	// -d : dictionary file name
	// -s : script file name
	for(i=1;i<argc;i++){
		if(strcmp(argv[i], "-a") == 0){
			if(i == argc -1){
				ShowInfo();
				return -EINVAL;
			}
			nMode = 'a';
			inputFileName = argv[i+1];
		}else if(strcmp(argv[i], "-t") == 0){
			if(i == argc -1){
				ShowInfo();
				return -EINVAL;
			}
			nMode = 't';
			inputFileName = argv[i+1];
		}else if(strcmp(argv[i], "-o") == 0){
			if(i == argc -1){
				ShowInfo();
				return -EINVAL;
			}
			memset(outputFileName, 0x00, 256);
			outputFileName[0] = '.';
			outputFileName[1] = '/';
			strcpy(&outputFileName[2], argv[i+1]);
		}
	}

	printf("output file name = %s\n", outputFileName);
	printf("input file name = %s\n", inputFileName);

	printf("mode = %d\n", nMode);

	// Check input file

	// Check mode
	// Make bitmap(8k) from table
	if(nMode == 't'){
		printf("make letter table mode.\n");
		ret = Table_mode(inputFileName, outputFileName);
	}else if(nMode == 'a'){
		printf("script analysis mode.\n");
		ret = Anal_mode(inputFileName, outputFileName);
	}

	return ret;
}



unsigned char AtoI(unsigned char ch){
	unsigned char result;

	switch(ch){
		case 'A':
		case 'a':
			result = 10;
			break;
		case 'B':
		case 'b':
			result = 11;
			break;
		case 'C':
		case 'c':
			result = 12;
			break;
		case 'D':
		case 'd':
			result = 13;
			break;
		case 'E':
		case 'e':
			result = 14;
			break;
		case 'F':
		case 'f':
			result = 15;
			break;
		default:
			result = ch - '0';
			break;
	}
	return result;
}



// It convert only 4 digit to int
int UNICODEtoInt(char *ch){
	int tmp, result = 0;
	unsigned char hex;

	hex = AtoI(ch[0]);
	result = hex << 12;
	hex = AtoI(ch[1]);
	result |= hex << 8;
	hex = AtoI(ch[2]);
	result |= hex << 4;
	hex = AtoI(ch[3]);
	result |= hex << 0;

	return result;
}



// 4K bytes letters counter
#define	MAX_LETTERS_SIZE	(4*1024*4)
int Table_mode(char *input_file, char *output_file){
	FILE *fd;
	struct stat st;
	int nFileSize = 0;
	unsigned char *pBuf;
	int nLine = 0;
	int i, j;
	int ret;
	char *input_file_path;
	char *letters;
	char oneLetter[4];
	int nLetters;
	unsigned char *noJong;
	struct testList testlist;
	unsigned short unicode;
	int a, b, c;
	FILE *fp;
	unsigned short *unicodes;
/*}
	char *letter;
	unsigned char *noJong;
	int *repeatCnt;
};*/

	// Make letters buff
	letters = (char*)malloc(sizeof(char) * MAX_LETTERS_SIZE);
	if(letters == NULL){
		printf("Memory not allocated. letters\n");
		return -ENOMEM;
	}
	memset(letters, 0, MAX_LETTERS_SIZE);

	noJong = (unsigned char*)malloc(sizeof(char) * (MAX_LETTERS_SIZE/4));
	if(noJong == NULL){
		printf("Memory not allocated. noJong\n");
		free(letters);
		return -ENOMEM;
	}
	memset(noJong, 0, MAX_LETTERS_SIZE/4);

	unicodes = (unsigned short*)malloc(sizeof(unsigned short) * (MAX_LETTERS_SIZE/4));
	if(unicodes == NULL){
		printf("Memory not allocated. noJong\n");
		free(noJong);
		free(letters);
		return -ENOMEM;
	}
	memset(unicodes, 0, MAX_LETTERS_SIZE/4*(sizeof(unsigned short)));

	// Check file exist
	input_file_path = (char*)malloc(sizeof(char) * 1024);
	if(input_file_path == NULL){
		printf("Memory not allocated. input_file_path\n");
		free(letters);
		return -ENOMEM;
	}
	input_file_path[0] = '\0';
	strcpy(input_file_path, "./");
	strcat(input_file_path, input_file);
	ret = access(input_file_path, F_OK);
	if(ret < 0){
		printf("File not found %d %s\n", ret, input_file_path);
		free(letters);
		free(input_file_path);
		return ret;
	}
	printf("file found : %s\n", input_file_path);

	// File size check
	stat(input_file_path, &st);
	nFileSize = st.st_size;

	// Open
	fd = fopen(input_file_path, "rb");
	free(input_file_path);
	if(fd == NULL){
		printf("File open failed!\n");
		return -EINVAL;
	}
	pBuf = (unsigned char*)malloc(sizeof(unsigned char) * nFileSize);
	if(pBuf == NULL){
		printf("Memory allocation failed.\n");
		fclose(fd);
		return -ENOMEM;
	}

	// Read
	fread(pBuf, 1, nFileSize, fd);

	// Check letters - Only hangul is valid
	nLetters = 0;
	for(i=0;i<nFileSize;i++){

		if(pBuf[i] & 0x80){	// UTF-8
			switch(pBuf[i] & 0xF0)
			{
				case 0xF0:
					oneLetter[0] = pBuf[i+0];
					oneLetter[1] = pBuf[i+1];
					oneLetter[2] = pBuf[i+2];
					oneLetter[3] = pBuf[i+3];
					i+=3;
					ret = Check_duplicate(oneLetter, letters, nLetters, MAX_LETTERS_SIZE);
					if(ret){	// Duplicated
						continue;
					}
					break;
				case 0xE0:
					oneLetter[0] = pBuf[i+0];
					oneLetter[1] = pBuf[i+1];
					oneLetter[2] = pBuf[i+2];
					oneLetter[3] = '\0';
					i+=2;
					ret = Check_duplicate(oneLetter, letters, nLetters, MAX_LETTERS_SIZE);
					if(ret){	// Duplicated
						continue;
					}
					unicode = utf8_to_unicode(oneLetter);
					unicodes[nLetters/4] = unicode;
					//unicode = (oneLetter[0] & 0x0F) << 12;
					//unicode |= (oneLetter[1] & 0x3F) << 6;
					//unicode |= (oneLetter[2] & 0x3F);
					//printf("%04x\n", unicode);
					//a = unicode & 0x03FF;
					a = unicode - 0xAC00;
					b = a / 21 / 28;
					c = (a - (b * 21 * 28))/28;
					if((a - (b * 21 * 28) - (c * 28)) == 0x00){
						noJong[nLetters/4] = 1;
					}
					break;
				case 0xC0:
					oneLetter[0] = pBuf[i+0];
					oneLetter[1] = pBuf[i+1];
					oneLetter[2] = '\0';
					oneLetter[3] = '\0';
					i++;
					ret = Check_duplicate(oneLetter, letters, nLetters, MAX_LETTERS_SIZE);
					if(ret){	// Duplicated
						continue;
					}
					break;
				default:
					printf("! Unexpected letter %02xh\n", pBuf[i]);
					continue;
					break;
			}
		}else{			// ASCII
			continue;
		}
		memcpy(&letters[nLetters], oneLetter, 4);
		nLetters += 4;
	}
#if 1
	// Sort by unicode
	for(i=0;i<nLetters;i+=4){
		for(j=4;j<nLetters-i;j+=4){
			// Swap
			if(unicodes[(j/4) -1] > unicodes[j/4]){
				// Swap count
				ret = unicodes[(j/4) -1];
				unicodes[(j/4) -1] = unicodes[j/4];
				unicodes[j/4] = ret;
				// Swap letter
				oneLetter[0] = letters[j+0];
				oneLetter[1] = letters[j+1];
				oneLetter[2] = letters[j+2];
				oneLetter[3] = letters[j+3];

				letters[j+0] = letters[j-4];
				letters[j+1] = letters[j-3];
				letters[j+2] = letters[j-2];
				letters[j+3] = letters[j-1];

				letters[j-4] = oneLetter[0];
				letters[j-3] = oneLetter[1];
				letters[j-2] = oneLetter[2];
				letters[j-1] = oneLetter[3];
				// Swap nojong
				ret = noJong[(j/4)-1];
				noJong[(j/4)-1] = noJong[j/4];
				noJong[j/4] = ret;
			}
		}
	}
#endif
	fp = fopen(output_file, "w");
	// Result lettes
	for(i=0;i<nLetters;i+=4){
#if 0
		if((letters[i] & 0x80) == 0x00){
			if(letters[i] < 0x20){
				fprintf(fp, "%02xh", letters[i+0]);
			}else if(letters[i] == 0x7F){
				fprintf(fp, "%02xh", letters[i+0]);
			}else{
				fprintf(fp, "%c", letters[i+0]);
			}
			fprintf(fp, ":%04xh", unicodes[i/4]);
			if(noJong[i/4]){
				fprintf(fp, " No");
			}
			fprintf(fp, "\n");
			//continue;
		}
#endif
		fprintf(fp, "%c", letters[i+0]);
		if(letters[i+1] != '\0'){
			fprintf(fp, "%c", letters[i+1]);
		}
		if(letters[i+2] != '\0'){
			fprintf(fp, "%c", letters[i+2]);
		}
		if(letters[i+3] != '\0'){
			fprintf(fp, "%c", letters[i+3]);
		}
		fprintf(fp, ":%04xh", unicodes[i/4]);
		if(noJong[i/4]){
			fprintf(fp, " No");
		}
		fprintf(fp, "\n");
	}
	fprintf(fp, "Total letters = %d", nLetters/4);
	fprintf(fp, "\n");
	ret = 0;
	for(i=0;i<nLetters;i+=4){
		if(noJong[i/4]){
			ret++;
		}
	}
	fprintf(fp, "Total no Jongsung = %d", ret);//// Chosung + Jungsung Only
	fprintf(fp, "\n");
	//printf("");//// Chosung + Jungsung + Jongsung
	fclose(fp);

	free(unicodes);
	free(letters);
	free(pBuf);
	fclose(fd);

	return ret;
}



int Anal_mode(char *input_file, char *output_file){
	FILE *fd;
	struct stat st;
	int nFileSize = 0;
	unsigned char *pBuf;
	int nLine = 0;
	int i, j;
	int ret;
	char *input_file_path;
	char *letters;
	char oneLetter[4];
	int nLetters;
	unsigned char *noJong;
	int *repeatCnt;
	struct testList testlist;
	unsigned short unicode;
	int a, b, c;
	FILE *fp;
/*}
	char *letter;
	unsigned char *noJong;
	int *repeatCnt;
};*/

	// Make letters buff
	letters = (char*)malloc(sizeof(char) * MAX_LETTERS_SIZE);
	if(letters == NULL){
		printf("Memory not allocated. letters\n");
		return -ENOMEM;
	}
	memset(letters, 0, MAX_LETTERS_SIZE);

	noJong = (unsigned char*)malloc(sizeof(char) * (MAX_LETTERS_SIZE/4));
	if(noJong == NULL){
		printf("Memory not allocated. noJong\n");
		free(letters);
		return -ENOMEM;
	}
	memset(noJong, 0, MAX_LETTERS_SIZE/4);

	repeatCnt = (int*)malloc(sizeof(int) * (MAX_LETTERS_SIZE/4));
	if(repeatCnt == NULL){
		printf("Memory not allocated. noJong\n");
		free(noJong);
		free(letters);
		return -ENOMEM;
	}
	memset(repeatCnt, 0, MAX_LETTERS_SIZE/4*(sizeof(int)));

	// Check file exist
	input_file_path = (char*)malloc(sizeof(char) * 1024);
	if(input_file_path == NULL){
		printf("Memory not allocated. input_file_path\n");
		free(letters);
		return -ENOMEM;
	}
	input_file_path[0] = '\0';
	strcpy(input_file_path, "./");
	strcat(input_file_path, input_file);
	ret = access(input_file_path, F_OK);
	if(ret < 0){
		printf("File not found %d %s\n", ret, input_file_path);
		free(letters);
		free(input_file_path);
		return ret;
	}
	printf("file found : %s\n", input_file_path);

	// File size check
	stat(input_file_path, &st);
	nFileSize = st.st_size;

	// Open
	fd = fopen(input_file_path, "rb");
	free(input_file_path);
	if(fd == NULL){
		printf("File open failed!\n");
		return -EINVAL;
	}
	pBuf = (unsigned char*)malloc(sizeof(unsigned char) * nFileSize);
	if(pBuf == NULL){
		printf("Memory allocation failed.\n");
		fclose(fd);
		return -ENOMEM;
	}

	fseek(fd, 0, SEEK_SET);
	memset(pBuf, 0x00, sizeof(unsigned char) * nFileSize);

	// Read
	fread(pBuf, 1, nFileSize, fd);

	// Check letters
	nLetters = 0;
	for(i=0;i<nFileSize;i++){

		if(pBuf[i] & 0x80){	// UTF-8
			switch(pBuf[i] & 0xF0)
			{
				case 0xF0:
					oneLetter[0] = pBuf[i+0];
					oneLetter[1] = pBuf[i+1];
					oneLetter[2] = pBuf[i+2];
					oneLetter[3] = pBuf[i+3];
					i+=3;
					ret = Check_duplicate(oneLetter, letters, nLetters, MAX_LETTERS_SIZE);
					if(ret){	// Duplicated
						repeatCnt[ret/4]++;
						continue;
					}
					break;
				case 0xE0:
					oneLetter[0] = pBuf[i+0];
					oneLetter[1] = pBuf[i+1];
					oneLetter[2] = pBuf[i+2];
					oneLetter[3] = '\0';

					i+=2;
					ret = Check_duplicate(oneLetter, letters, nLetters, MAX_LETTERS_SIZE);
					if(ret){	// Duplicated
						repeatCnt[ret/4]++;
						continue;
					}
					unicode = utf8_to_unicode(oneLetter);
					//unicode = (oneLetter[0] & 0x0F) << 12;
					//unicode |= (oneLetter[1] & 0x3F) << 6;
					//unicode |= (oneLetter[2] & 0x3F);
					//printf("%04x\n", unicode);
					//a = unicode & 0x03FF;
					a = unicode - 0xAC00;
					b = a / 21 / 28;
					c = (a - (b * 21 * 28))/28;
					if((a - (b * 21 * 28) - (c * 28)) == 0x00){
						noJong[nLetters/4] = 1;
					}
					break;
				case 0xC0:
					oneLetter[0] = pBuf[i+0];
					oneLetter[1] = pBuf[i+1];
					oneLetter[2] = '\0';
					oneLetter[3] = '\0';
					i++;
					ret = Check_duplicate(oneLetter, letters, nLetters, MAX_LETTERS_SIZE);
					if(ret){	// Duplicated
						repeatCnt[ret/4]++;
						continue;
					}
					break;
				default:
					printf("! Unexpected letter %02xh\n", pBuf[i]);
					continue;
					break;
			}
		}else{			// ASCII
			oneLetter[0] = pBuf[i+0];
			oneLetter[1] = '\0';
			oneLetter[2] = '\0';
			oneLetter[3] = '\0';
			ret = Check_duplicate(oneLetter, letters, nLetters, MAX_LETTERS_SIZE);
			if(ret){	// Duplicated
				repeatCnt[ret/4]++;
				continue;
			}
		}
		memcpy(&letters[nLetters], oneLetter, 4);
		nLetters += 4;
	}

	// Sort by upper
	for(i=0;i<nLetters;i+=4){
		for(j=4;j<nLetters;j+=4){
			// Swap
			if(repeatCnt[(j/4) -1] > repeatCnt[j/4]){
				// Swap count
				ret = repeatCnt[(j/4) -1];
				repeatCnt[(j/4) -1] = repeatCnt[j/4];
				repeatCnt[j/4] = ret;
				// Swap letter
				oneLetter[0] = letters[j+0];
				oneLetter[1] = letters[j+1];
				oneLetter[2] = letters[j+2];
				oneLetter[3] = letters[j+3];

				letters[j+0] = letters[j-4];
				letters[j+1] = letters[j-3];
				letters[j+2] = letters[j-2];
				letters[j+3] = letters[j-1];

				letters[j-4] = oneLetter[0];
				letters[j-3] = oneLetter[1];
				letters[j-2] = oneLetter[2];
				letters[j-1] = oneLetter[3];
				// Swap nojong
				ret = noJong[(j/4)-1];
				noJong[(j/4)-1] = noJong[j/4];
				noJong[j/4] = ret;
			}
		}
	}

	fp = fopen(output_file, "w");
	// Result lettes
	for(i=0;i<nLetters;i+=4){
		if((letters[i] & 0x80) == 0x00){	// ASCII
			if(letters[i] < 0x20){
				fprintf(fp, "%02xh", letters[i+0]);
			}else if(letters[i] == 0x7F){
				fprintf(fp, "%02xh", letters[i+0]);
			}else{
				fprintf(fp, "%c", letters[i+0]);
			}
			fprintf(fp, ":re%04d", repeatCnt[i/4]);
			if(noJong[i/4]){
				fprintf(fp, " No");
			}
			fprintf(fp, "\n");
			continue;
		}

		fprintf(fp, "%c", letters[i+0]);
		if(letters[i+1] != '\0'){
			fprintf(fp, "%c", letters[i+1]);
		}
		if(letters[i+2] != '\0'){
			fprintf(fp, "%c", letters[i+2]);	
		}
		if(letters[i+3] != '\0'){
			fprintf(fp, "%c", letters[i+3]);
		}
		fprintf(fp, ":re%04d", repeatCnt[i/4]);
		if(noJong[i/4]){
			fprintf(fp, " No");
		}
		fprintf(fp, "\n");
	}
	fprintf(fp, "Total letters = %d", nLetters/4);
	fprintf(fp, "\n");
	ret = 0;
	for(i=0;i<nLetters;i+=4){
		if(noJong[i/4]){
			ret++;
		}
	}
	fprintf(fp, "Total no Jongsung = %d", ret);//// Chosung + Jungsung Only
	fprintf(fp, "\n");
	//printf("");//// Chosung + Jungsung + Jongsung
	fclose(fp);

	free(repeatCnt);
	free(letters);
	free(pBuf);
	fclose(fd);

	return 0;
}



// if duplicated, return duplicated letter number(x4) +1
int Check_duplicate(char *letter, char *letters, int nMaxLetterSize, int nEND){
	int i;

	//for(i=0;i<nEND;i+=4){
	for(i=0;i<nMaxLetterSize;i+=4){
		if(strcmp(letter, &letters[i]) == 0){
			//printf("duplicated %02xh,%02xh,%02xh,%02xh\n", letter[0], letter[1], letter[2], letter[3]);
			return i+1;
		}
	}

	return 0;
}



//#include "font.h"


#if 0
int unicode(char *font_value){
	int refValue;
	unsigned char cho, jung, jong;
	int a, b, c;

	// Get input character
	if(font_value[0] == '\0' ||
		font_value[1] == '\0' ||
		font_value[2] == '\0' ||
		font_value[3] == '\0'){
		printf("data invalid.\n");
		return -EINVAL;
	}

	refValue = UNICODEtoInt(font_value);
	printf("%04xh = %d\n", refValue, refValue);

	// Seperate character
	c = refValue - 0xAC00;
	a = c / (21 * 28);
	c = c % (21 * 28);	// 588
	b = c / 28;
	c = c % 28;

	// Combine character
	

	return 0;
}
#endif



// utf-8 to unicode
int utf8_to_unicode(char *uft8){
	int unicode;

	unicode = (uft8[0] & 0x0F) << 12;
	unicode |= (uft8[1] & 0x3F) << 6;
	unicode |= (uft8[2] & 0x3F);

	return unicode;
}



void ShowInfo(void){
	printf("How to use.\n");
	printf(" It supprot UTF-8 format.\n");
	printf("1] script analysis mode.\n");
	printf(" > letter_arranger -a [input file(script) name].\n");
	printf("2] make letter table mode.\n");
	printf(" > letter_arranger -t [input file(script) name].\n");
	printf("ETC] -o : output file name.\n");
	printf("Date:20240315.\n");
	printf("Version:%s.\n", VERSION);
}
