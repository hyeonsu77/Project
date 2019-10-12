#include <stdio.h>
#include <stdlib.h>
typedef struct NODE{
	int data;
	struct NODE* Rlink;
}Node; //Node로 정의한다. 

Node* Head = NULL; //전역변수  

int getSize(Node* head); //사이즈 함수 
Node* New(int d); //새로운 노드 생성 
void Add(Node** head, Node* node); //삽입함수 
void Delete(Node** head, int pos); //삭제함수 
void Print(Node* head); //출력함수 

int main()
{
	while(1)
	{
		int d;
		int choose, pos;
		int size = getSize(Head);
		
		printf("===================\n");
		printf("0. 종료\n");
		printf("1. 삽입\n");
		printf("2. 삭제\n");
		//printf("3. 전체 출력\n");
		printf("================");
		printf("size : [%d]\n",size); 
		
		printf("선택 : ");
		scanf("%d", &choose);
		
		switch(choose)
		{
			case 0:
				return 0;
			
			case 1:
				Add(&Head, New(d)); //1. 삽입
				break;
			
			case 2:
				printf("위치 : "); //2. 삭제
				scanf("%d",&pos);
				Delete(&Head,pos);
				break;
							
			default:
				printf("다시 입력\n");
				break;
		}
		printf("\n\n");		
	}
}

void Delete(Node**head, int pos)  //2. 삭제
{
	Node*temp = *head; //헤드의 값을 temp 임시변수에 저장 
	Node*previous = NULL; //피봇 변수 초기화 
	
	int i; 
	int size = getSize(*head); //사이즈 함수 호출 
	
	if(size==0 || size<pos)
	{
		printf("삭제할 노드 없음\n");
	}
	else if(pos==1)
	{
		previous = *head;
		*head = (*head)->Rlink;
		
		free(previous);	
	}
	else if(size==pos)
	{
		while(temp->Rlink != NULL)
		{
			previous = temp;
			temp = temp->Rlink;
		}
		previous->Rlink = NULL;
		
		free(temp);
	}
	else
	{
		for(i=1;i<pos;i++)
		{
			previous = temp;
			temp = temp ->Rlink;
		}
		previous->Rlink = temp->Rlink;
		
		free(temp);
	}
	Print(Head);
}

void Print(Node*head) //3. 전체 출력
{
	int i;
	int size = getSize(head);
	for(i=1;i<=size;i++)
	{
		///printf("[%d]\n",i);
		if(size == 1)
		{
			printf("%d", head->data);	
		}
		else if(i == size){
			printf("%d", head->data);
		}
		else{
		printf("%d->", head->data);	
		}
		head = head->Rlink;
	}
	 
}

void Add(Node** head, Node* node) //삽입 함수 
{
	Node* temp = *head; // 현재 헤드의 값을 temp 임시변수에 저장한다. 
	Node* start = *head; // sort를 하기 위해 헤드의 값을  start 변수에 저장. 
	if(*head == NULL) //노드가 하나도 없을경우 
	{
		*head = node; //헤드에다가 노드의 구조체를 넣어준다 
	}
	else
	{	
		while(temp->Rlink != NULL) // 노드의 끝을 찾는것. 
		{
			temp = temp->Rlink;	//temp 임시 변수에 노드를 이동 시킴. 
		}
		temp->Rlink = node; //새로운 노드를 삽입한다. 
	}
		
	Print(Head);
}
 
Node* New(int d) //새로운 노드 생성  
{	
	printf("데이터 : ");
	scanf("%d", &d);
	printf("\n");
	Node* node=(Node*)malloc(sizeof(Node)); //구조체 포인터 node 변수에 공간 할당 
	node->data = d; //node 가 가르키는 data 값에 입력한 값 삽입 

	node->Rlink = NULL; //node가 가르키는 Rlink 에 null값 끝을 알리기위해 
	return node;
}


int getSize(Node* head)
{
	int count=0;
	if(head == NULL)
		return 0;
	else
	{
		while(head->Rlink != NULL)
		{	
			count++;
			head = head->Rlink;	
		}
		return count+1;
	}
}