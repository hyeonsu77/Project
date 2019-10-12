#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
//RSA 알고리즘 프로그램  2019.08.21 _ 김현수
void Encrption(int **C, int **M, int n , int e) //M^e  mod n
{
	int i;
	int temp;
	int plus;
	e = 3;
	printf("N값 : %d\n",n);
	for(i=0;i<sizeof(M);i++)
	{
		//plus = (unsigned long long)(pow((double)*(*M+i) , (double)e)) % n; 
		temp = *(*M+i) % n;
		
		plus = (int)pow((double)temp , (double)e) % n; //M%n ^ e %n
		
		printf("암호화 되기전  숫자 : %d\n",(int)*(*M+i));
		if(plus > 127)
		{
			plus = plus % 127;
		}
		
	    *(*C+i)	= (int)*(*M+i) + plus; 
		
		if(*(*C+i) > 127)
		{
			*(*C+i) = *(*C+i) % 127;
		}
		
		printf("\nplus : %d\n",plus);
		printf("암호화 전 평문 : %c\n",*(*M+i));
		printf("암호화 후 암호문 : %c\n",*(*C+i));
		printf("암호화 전 숫자 : %d\n",*(*M+i));
		printf("암호화 후 숫자 : %d\n",*(*C+i));
	}
	printf("암호화 전 평문 : %s\n",*M);
	printf("암호화 후 암호문 : ");
	for(i=0;i<10;i++)
	{
		printf("%s",*(*C+i));	
	}
	printf("\nM 의 동적 할당 크기%d\n",sizeof(M));
	printf("\nC 의 동적 할당 크기%d\n",sizeof(C));
}

Private_key(int e,int op,int* d) //(e * d) mod Φ(n) = 1
{
	int i;
	int result;
	for(i=0;i<777777777777777777;i++)
	{
		result = ((i%op) * (e%op)) % op;
		if(result==1)
		{
			break;
		}
		printf("check [%d]\n",i);
	}
	*d = i;
	printf("[private key] : %d",*d);
}


int Public_key(int ep) // 오일러 파이보다 작으면서 오일러 파이와 서로소 인 임의의 수 (공개키) 
{
	int i,j,k;
	int randum=0; //랜덤수  
	int temp = ep;
	temp = temp - 1;
	
	srand((unsigned)time(NULL)); 
	
	int cp; // 서로소인 임의의 수
	int count = 0; // 힙 영역에 있는 메모리 주소에 접근하기 위해 
	int* mathematics = (int*)malloc(sizeof(int) * ep - 1); // 동적 할당 과 사이즈의 이유 -> 약수의 크기를 배열에 할당해야 하는데 동적이기 때문이다, 또한 약수의 최대값은 -1 의 크기 이다 
	int* cpminus;
	
	if(mathematics == NULL){
		printf("동적 할당 실패!");
		exit(1); 
	}
	
	else{
		for(i=1;i<=ep;i++) // '오일러 파이' 의 약수 구하기  155
		{
			if(ep % i == 0)
			{
				(*(mathematics + count)) = i; //포인터 표기법 으로 4byte씩 증가 하면서 저장해야 한다. (어쩔수없이) 
				printf("ep의 %d약수 : %d \n",ep,(*(mathematics+count)));
				count++;
			}
		}
		
		do{			
			count = 0; //카운트 초기화 
			randum = rand() % 500 + 1;
			int* tmp = (int*)malloc(sizeof(int) * randum);		
			
			for(k=1;k<=randum;k++) // '임의의 수' 약수 구하기 
			{
				if(randum % k == 0)
				{
					(*(tmp + count)) = k;
					printf("randum %d의약수 : %d\n ",randum,(*(tmp+count)));
					count++;
				}
			}	
			
			count = 0;
			
			for(i=0;i<ep;i++) //서로소 판별 반복문 
			{
				count = 0;
				
				for(j=0;j<randum;j++)
				{
					if(*(mathematics+i) == *(tmp+j))
					{
						count++;
						if(*(mathematics+i) == 1 || *(tmp+j) == 1)
						{
							count--;
						} 
					}
					if(count == 1)
					{
						break;
					}
				}
				if(count == 1)
				{
					break;
				}
			}
			free(tmp);
		}while(count != 0); //count가 0이라면 서로소 인것
		 
		printf("[randum: %d ep: %d]\n",randum,ep);
	}
	cp = randum;
	printf("[Enctyption key : %d]\n",cp);
	free(mathematics); //오일러 파이 함수 동적 할당 해제 
	return cp;
}


int Euler_Pie(int p, int q) //오일러 파이 구하는 함수 
{
	int ep = (p - 1) * (q - 1);
	return ep;
}


int Prime_product(int p, int q) // 두 소수의 곱 함수 
{
	printf("p * q : %d\n",p*q);
	return p*q;
}

void Over_lap(int* p , int* q , int* arr) // p , q 중복 제거 함수 
{
	int i,j;
	srand(time(NULL)); 
	i = rand() % 53;
	j = rand() % 53;
	*p = arr[i];
	*q = arr[j];
	while(*p == *q)
	{
		*p = rand() % 53;
	}
	printf("p : %d\n",*p);
	printf("q : %d\n",*q);
}

int main()
{
	int p,q; //소수 
	int e,d; //공개키 , 개인키 
	int n; // p,q 곱 
	int op; //오일러 파이 
	int* C = (int*)malloc(sizeof(char) * 100);
	char* M = (char*)malloc(sizeof(char) * 100);	
	 
	int arr[] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, //1 ~ 256 까지의 소수 
	             43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 
				 101, 103, 107, 109, 113, 127, 131, 137, 139, 149,
				 151, 157, 163, 167, 173, 179, 181, 191, 193, 197,
				 199, 211, 223, 227, 229, 233, 239, 241, 251}; 
	printf("암호화 할 숫자 를 입력하세요 : ");
	scanf("%s",M);
	
	Over_lap(&p,&q,arr); //소수의 중복 제거   - > p != q
	n = Prime_product(p,q); //소수의 곱  - > p * q 
	op = Euler_Pie(p,q); // 오일러 파이        - > Φ(n)
	e = Public_key(n); //공개키               - > Φ(n)  < (Φ(n) \ b) = 1
	printf("\n소수의 곱 n : %d\n",n);
	Encrption(&C,&M,n,e); //암호화 ->  
	free(C);
	free(M);
	return 0;
}