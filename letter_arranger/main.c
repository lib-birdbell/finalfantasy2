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

// 32 characters per Line
#define	FONT_X_OFFSET	18

#define VERSION		"1.00"

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
int ConvertMode(int argc, char **argv);
int anal_mode(char *font_value);
int Check_duplicate(char *letter, char *letters, int nMaxLetterSize, int nEnd);
int unicode(char *font_value);
int utf8_to_unicode(char *uft8);



int main(int argc, char** argv){
	int ret;

	if(argc < 2){
		printf("How to use.\n");
		printf(" [input file name].\n");
		printf("It supprot UTF-8 format.\n");
		printf("Date:20240308.\n");
		printf("Version:%s.\n", VERSION);
		return 0;
	}

	// Check mode
	if(strcmp(argv[1], "-o") == 0){
		printf("analyze and out mode.\n");
		if(argc < 4){
			printf("How to use.\n");
			printf("-o option + [out file name] + [input file name].\n");
			return 0;
		}
		//font_check_mode(argv[2]); out file name
	}else{
		printf("analyze mode.\n");
		if(argc < 2){
			printf("How to use.\n");
			printf("need [input file name].\n");
			return 0;
		}
		ret = anal_mode(argv[1]);
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



int ConvertMode(int argc, char **argv){
	int fd;
	unsigned char *pBuf;
	unsigned char *pBMP;
	int nFileSize = 0;
	unsigned int *pColorArr;
	unsigned int *pColorCnt;
	unsigned int tempColor;
	int nColorCnt = 0;
	int i, j;
	int x, y;
	struct stat st;
	struct bmp_header *bmp_h;
	int width, height;
	int ret;
	unsigned int refValue;
	unsigned int convValue;

	if(strcmp(argv[1], "-c")){
		printf("Not support %s. Only support -c. \n", argv[1]);
		printf("How to use.\n");
		printf("color_seperator -c [find value] [convert value]\n");
		printf("value is decimal.(HEX will be support next version)");
		return -EINVAL;
	}
	refValue = atoi(argv[2]);
	convValue = atoi(argv[3]);
	printf("refValue=%08x, convValue=%08x\n", refValue, convValue);

	fd = open(FILE_NAME, O_RDWR);

	stat(FILE_NAME, &st);

	nFileSize = st.st_size;

	pBuf = (unsigned char*)malloc(sizeof(unsigned char) * nFileSize);
	pColorArr = (unsigned int*)malloc(sizeof(unsigned int) * nFileSize);
	pColorCnt = (unsigned int*)malloc(sizeof(unsigned int) * nFileSize);
	
	read(fd, pBuf, nFileSize);

	bmp_h = (struct bmp_header*)pBuf;

	printf("bmp_h file size=%d\n", bmp_h->biSizeImage);
	printf("bmp_h width=%d\n", bmp_h->biWidth);
	printf("bmp_h height=%d\n", bmp_h->biHeight);
	width = bmp_h->biWidth;
	height = bmp_h->biHeight;

	nFileSize = bmp_h->biSizeImage;

	for(y=0;y<height;y++){
		pBMP = &pBuf[BMP_HEADER_SIZE+(y*((width*3)+((width*3)%4)))];
		for(x=0;x<(width*3);x+=3){
			tempColor = pBMP[x+0];
			tempColor |= (pBMP[x+1] << 8);
			tempColor |= (pBMP[x+2] << 16);

			if(tempColor == refValue){
				pBMP[x+0] = (convValue)&0xFF;
				pBMP[x+1] = (convValue>>8)&0xFF;
				pBMP[x+2] = (convValue>>16)&0xFF;
				nColorCnt++;
			}
		}
	}

	lseek(fd, 0, SEEK_SET);
	ret = write(fd, pBuf, nFileSize);
	printf("write ret=%d\n", ret);
	if(nColorCnt){
		printf("%d pixel converted from %08xh to %08xh.\n", nColorCnt, refValue, convValue);
	}

	close(fd);

	free(pColorCnt);
	free(pColorArr);
	free(pBuf);

	return ret;
}



// 4K bytes letters counter
#define	MAX_LETTERS_SIZE	(4*1024*4)
int anal_mode(char *input_file){
	int fd;
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
	fd = open(input_file_path, O_RDWR);
	free(input_file_path);
	if(fd < 0){
		printf("File open failed %d\n", fd);
		return fd;
	}
	pBuf = (unsigned char*)malloc(sizeof(unsigned char) * nFileSize);
	if(pBuf == NULL){
		printf("Memory allocation failed.\n");
		close(fd);
		return -ENOMEM;
	}

	// Read
	read(fd, pBuf, nFileSize);

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
		for(j=4;j<nLetters-i;j+=4){
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

	fp = fopen("./output.txt", "w");
	// Result lettes
	for(i=0;i<nLetters;i+=4){
		if((letters[i] & 0x80) == 0x00){
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

	free(letters);
	free(pBuf);
	close(fd);

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



// 
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



// utf-8 to unicode
int utf8_to_unicode(char *uft8){
	int unicode;

	unicode = (uft8[0] & 0x0F) << 12;
	unicode |= (uft8[1] & 0x3F) << 6;
	unicode |= (uft8[2] & 0x3F);

	return unicode;
}
