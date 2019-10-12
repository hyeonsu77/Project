import openpyxl
f = open("C:/Users/okopo/Desktop/서버진단결과/script10.txt", 'r') #스크립트 결과
lines = f.readlines()
st3 = 'CN-'
str_ = []
num = 1
for index in lines:
    if st3 in index:
        str_.append(index)
wb = openpyxl.load_workbook('C:/Users/okopo/Desktop/서버진단결과/test4.xlsx')
sheet1 = wb.active
for i in str_:
    num = num + 1
    print(i)
    sheet1.cell(num,7,i)
    wb.save('C:/Users/okopo/Desktop/서버진단결과/test4.xlsx')