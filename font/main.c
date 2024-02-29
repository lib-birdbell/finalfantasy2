#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>



#define	BMP_HEADER_SIZE	sizeof(struct bmp_header)
#define	FILE_NAME	"./galmurim.bmp"

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



int ConvertMode(int argc, char **argv);



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

	if(argc < 3){
		printf("How to use.\n");
		return 0;
	}
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
