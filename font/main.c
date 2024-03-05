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



unsigned char AtoI(unsigned char ch);
int UNICODEtoInt(char *ch);
int ConvertMode(int argc, char **argv);
int font_check_mode(char *font_value);
int unicode(char *font_value);
int make_bin(char *begin, char *end);



int main(int argc, char** argv){
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

	if(argc < 2){
		printf("How to use.\n");
		return 0;
	}

	// Check mode
	if(strcmp(argv[1], "-c") == 0){
		printf("font check mode.\n");
		if(argc < 3){
			printf("How to use.\n");
			printf("-c option + [font number].\n");
			return 0;
		}
		font_check_mode(argv[2]);
	}else if(strcmp(argv[1], "-u") == 0){
		printf("unicode mode.\n");
		if(argc < 3){
			printf("How to use.\n");
			printf("-u option + [unicode AC00-D7A3].\n");
			return 0;
		}
		unicode(argv[2]);
	}else if(strcmp(argv[1], "-o") == 0){
		printf("output mode.\n");
		if(argc < 4){
			printf("How to use.\n");
			printf("-o option + [begin] = [end].\n");
			return 0;
		}
		make_bin(argv[2], argv[3]);
	}

	return 0;

	// Make font binary
#if 0
	if(argc >= 4){
		ret = ConvertMode(argc, argv);

		return ret;
	}
#endif

	// File open
	fd = open(FILE_NAME, O_RDWR);

	stat(FILE_NAME, &st);

	nFileSize = st.st_size;

	pBuf = (unsigned char*)malloc(sizeof(unsigned char) * nFileSize);
	//pColorArr = (unsigned int*)malloc(sizeof(unsigned int) * nFileSize);
	//pColorCnt = (unsigned int*)malloc(sizeof(unsigned int) * nFileSize);
	
	// Read file
	read(fd, pBuf, nFileSize);

	// Check info
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

			if(nColorCnt){
				for(i=0;i<nColorCnt;i++){
					if(tempColor == pColorArr[i]){
						pColorCnt[i]++;
						break;
					}
				}
				// First find
				if(i==nColorCnt){
					//printf("find x=%d, y=%d\n", x, y);
					pColorCnt[nColorCnt] = 1;
					pColorArr[nColorCnt++] = tempColor;
				}
			}else{
				pColorCnt[nColorCnt] = 1;
				pColorArr[nColorCnt++] = tempColor;
			}
		}
	}
	
#if 1
	// Sort lower
	for(i=0;i<nColorCnt;i++){
		for(j=1;j<nColorCnt-i;j++){
			// Swap
			if(pColorCnt[j-1] > pColorCnt[j]){
				tempColor = pColorArr[j];
				pColorArr[j] = pColorArr[j-1];
				pColorArr[j-1] = tempColor;
				tempColor = pColorCnt[j];
				pColorCnt[j] = pColorCnt[j-1];
				pColorCnt[j-1] = tempColor;
			}
		}
	}
	
	for(i=0;i<nColorCnt;i++){
		printf("%02d:%08xh->%06d\n", i, pColorArr[i], pColorCnt[i]);
	}
#endif

	close(fd);

	free(pColorCnt);
	free(pColorArr);
	free(pBuf);

	return 0;
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



int font_check_mode(char *font_value){
	int fd;
	struct stat st;
	int nFileSize = 0;
	unsigned char *pBuf;
	struct bmp_header *bmp_h;
	int width, height;
	unsigned char *pChar;
	int nLine = 0;
	int refValue;
	int i, j;
	unsigned char tmp[2];
	unsigned short tmp16;
	int nFontPos;
	int nXpos, nYpos;
	int div, mod;
	int count8;

	stat(FILE_NAME, &st);
	nFileSize = st.st_size;

	// Open
	fd = open(FILE_NAME, O_RDWR);
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

	bmp_h = (struct bmp_header*)pBuf;

	printf("bmp_h file size=%d\n", bmp_h->biSizeImage);
	printf("bmp_h width=%d\n", bmp_h->biWidth);
	printf("bmp_h height=%d\n", bmp_h->biHeight);
	width = bmp_h->biWidth;
	height = bmp_h->biHeight;

	nFileSize = bmp_h->biSizeImage;

	// Get real line width
	nLine = width;
	while(nLine %32){
		nLine++;
	}

	nLine = nLine/8;
	printf("bmp 1 line(real) = %d\n", nLine);
	refValue = atoi(font_value);

	pChar = &pBuf[0x3E];
#define	CALC	(nLine*height -(nLine*(i+1+2)) -(nLine*nYpos*18))
	nXpos = (refValue%32);
	nYpos = (refValue/32);
	//nFontPos = refValue / 32;
	//nFontPos += refValue % 32;
	printf("nXpos=%d, nYpos=%d\n", nXpos, nYpos);
	printf("nLine x nYpos x 18 = %d\n", nLine * nYpos * 18);
	for(i=0;i<8;i++){
		tmp[0] = pChar[CALC];
		//printf("%d\n", CALC);
	}

	for(i=0;i<8;i++){
		div = (nXpos * 18) / 8;
		mod = (nXpos * 18) % 8;
		tmp[0] = pChar[CALC + div];
		tmp[1] = pChar[CALC + div +1];
		//printf("pos=%d, mod=%d, %02xh%02xh\n", (nLine*height - (nLine*(i+1+2)) -(nLine*nYpos*18)) + div, mod, tmp[0], tmp[1]);
		tmp16 = (tmp[0] << 8) | (tmp[1]);

		count8=8;
		for(j=15;j>=0;j--){
			if(mod+2){
				mod--;
				continue;
			}
			if((tmp16 >> j) & 0x01){
				printf("  ");
			}else{
				printf("==");
			}
			count8--;
			if(count8 == 0){
				break;
			}
		}
		printf("\n");
	}

	free(pBuf);
	close(fd);

	return 0;
}



#include "font.h"



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



int make_bin(char *begin, char *end){
	int fd;
	struct stat st;
	int nFileSize = 0;
	unsigned char *pBuf, *pFont;
	struct bmp_header *bmp_h;
	int width, height;
	unsigned char *pChar;
	int nLine = 0;
	int beginVal, endVal;
	int i, j;
	unsigned char tmp[2];
	unsigned short tmp16;
	int nFontPos;
	int nXpos, nYpos;
	int div, mod;
	int count8;
	int refValue;
	int nCount;
	unsigned char tmpFont;

	stat(FILE_NAME, &st);
	nFileSize = st.st_size;

	// Open
	fd = open(FILE_NAME, O_RDWR);
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

	bmp_h = (struct bmp_header*)pBuf;

	printf("bmp_h file size=%d\n", bmp_h->biSizeImage);
	printf("bmp_h width=%d\n", bmp_h->biWidth);
	printf("bmp_h height=%d\n", bmp_h->biHeight);
	width = bmp_h->biWidth;
	height = bmp_h->biHeight;

	nFileSize = bmp_h->biSizeImage;

	// Get real line width
	nLine = width;
	while(nLine %32){
		nLine++;
	}

	nLine = nLine/8;
	printf("bmp 1 line(real) = %d\n", nLine);
	beginVal = atoi(begin);
	endVal = atoi(end);
	refValue = beginVal;
	if(endVal <= beginVal){
		printf("INVALID value. end must bigger than begin.");
		close(fd);
		free(pBuf);
		return -EINVAL;
	}
	pFont = (unsigned char*)malloc(sizeof(unsigned char) * (endVal-beginVal) * 8);
	if(pFont == NULL){
		printf("Memory allocation failed. (pFont)\n");
		close(fd);
		free(pBuf);
		return -ENOMEM;
	}
	nCount = 0;

	pChar = &pBuf[0x3E];
#define	CALC	(nLine*height -(nLine*(i+1+2)) -(nLine*nYpos*18))
	nXpos = (refValue%32);
	nYpos = (refValue/32);

	while(refValue != endVal){
		tmpFont = 0;
	for(i=0;i<8;i++){
		div = (nXpos * 18) / 8;
		mod = (nXpos * 18) % 8;
		tmp[0] = pChar[CALC + div];
		tmp[1] = pChar[CALC + div +1];
		tmp16 = (tmp[0] << 8) | (tmp[1]);

		count8=8;
		for(j=15;j>=0;j--){
			if(mod+2){
				mod--;
				continue;
			}
			if((tmp16 >> j) & 0x01){
				tmpFont |= 0;
				tmpFont << 1;
			}else{
				tmpFont |= 1;
				tmpFont << 1;
			}
			count8--;
			if(count8 == 0){
				break;
			}
		}
		pFont[nCount++] = tmpFont;
	}
		refValue++;
		printf("nCount=%d(refValue=%d/%d\n", nCount, refValue, endVal);
	}// End of while

	free(pBuf);
	close(fd);

	// Create file
	fd = open("./galmurim.bin", O_RDWR | O_CREAT);
	write(fd, pFont, (endVal-beginVal)*8);

	close(fd);


	return 0;
}
