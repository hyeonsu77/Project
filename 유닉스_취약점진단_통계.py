#Hyeon.su
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc
from matplotlib import style

font_name = font_manager.FontProperties(fname="c:/Windows/Fonts/malgun.ttf").get_name()
rc('font', family=font_name)
style.use('ggplot')

total = 73 #전체 진단 항목 건수
total_total = 73 #전체 진단 항목 건수

total_hap = 0 # 총 취약 건수
total_file_security = 0 #파일 및 디렉터리 관리 항목
total_service_security = 0 #서비스 관리 항목
total_user_security = 0 #계정 관리 항목
total_log_security = 0 #로그 관리 항목
total_patch_security = 0 #패치 관리 항목
total_qt_num = 0 #부분 취약 항목 -> 권장 사항만 체크

st = '[취약]'
qt = '권장'

number = int(input('총 몇대의 서버를 진단 하셨습니까? : '))


for num in range(0,number):
    f = open('C:/Users/okopo/Desktop/서버진단결과/script'+str(num)+'.txt', 'r') #취약점 진단 스크립트 결과

    hap = 0
    file_security = 0
    service_security = 0
    user_security = 0
    log_security = 0
    patch_security = 0
    qt_num = 0
    total = 73

    lines = f.readlines()
    for index in lines:
        if st in index:
            if 'c1' in index:
                user_security = user_security + 1
                total_service_security = total_file_security + 1
                total_hap = total_hap + 1
                hap = hap + 1
                print(index)
            if 'c2' in index:
                file_security = file_security + 1
                total_file_security = total_file_security + 1
                total_hap = total_hap + 1
                hap = hap + 1
                print(index)
            if 'c3' in index:
                service_security = service_security + 1
                total_service_security = total_service_security + 1
                total_hap = total_hap + 1
                hap = hap + 1
                print(index)
            if 'c4' in index:
                patch_security = patch_security + 1
                total_patch_security = total_patch_security + 1
                total_hap = total_hap + 1
                hap = hap + 1
                print(index)
            if 'c5' in index:
                log_security = log_security + 1
                total_log_security = total_log_security + 1
                total_hap = total_hap + 1
                hap = hap + 1
                print(index)
        if qt in index:
            qt_num = qt_num + 1
            total_qt_num = total_qt_num + 1
            print('권장 갯수 : %d'%qt_num)

    print('파일 및 디렉터리 관리 %d' %file_security)
    print('서비스 관리 %d'%service_security)
    print('패치 관리 %d' %patch_security)
    print('로그 관리 %d'%log_security)
    print('계정 관리 %d'%user_security)

    #서버 개별 결과
    total = total - service_security - service_security - patch_security - qt_num - file_security - log_security #양호 갯수 구하기
    colors = ['yellowgreen', 'red', 'lightcoral', 'lightskyblue','lightcoral','yellow','lightblue']
    labels = ['2.파일 및 디렉터리 관리 [' + str(file_security) + '건]', '3.서비스 관리 [' + str(service_security) + '건]','5.패치 관리 [' + str(patch_security) + '건]', '4.로그 관리 [' + str(log_security) + '건]','1.계정관리 [' + str(user_security) + '건]', '부분 취약[' + str(qt_num) + '건]', '양호 [' + str(total) + '건]']
    ratio = [file_security, service_security, patch_security, 3, 2, qt_num, total]
    explode = (0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.0)
    plt.title('주요정보통신기반시설 유닉스 취약점 진단 [개별] 서버 결과 ', fontsize=20)
    plt.pie(ratio, explode=explode, labels=labels, colors=colors, autopct='%1.1f%%', shadow=True, startangle=73)
    plt.show()

#서버 전체 통합 결과
colors = ['yellowgreen', 'red', 'lightcoral', 'lightskyblue','lightcoral','yellow','lightblue']
labels = ['2.파일 및 디렉터리 관리 [' + str(total_file_security) + '건]', '3.서비스 관리 [' + str(total_service_security) + '건]',
          '5.패치 관리 [' + str(total_patch_security) + '건]', '4.로그 관리 [' + str(total_log_security) + '건]',
          '1.계정관리 [' + str(total_user_security) + '건]', '부분 취약[' + str(total_qt_num) + '건]', '양호 [' + str(total) + '건]']
ratio = [total_file_security, total_service_security, total_patch_security, 3, 2, total_qt_num, total_total]
explode = (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
plt.title('주요정보통신기반시설 유닉스 취약점 진단 [전체] 서버 결과 ', fontsize=20)
plt.pie(ratio, explode=explode, labels=labels, colors=colors, autopct='%1.1f%%', shadow=True, startangle=73*number)
plt.show()