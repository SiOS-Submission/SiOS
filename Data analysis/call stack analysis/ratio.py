import Levenshtein
import simplejson as json
from pathlib import Path
import itertools

# app1='NOW'
# app2='Fresh EBT'
# print (Path().absolute())
# path='E:\Desktop\ida\\'
path = str(Path().absolute())+'\\'
filename='\cmt_strs.json'
# filename_rated='\cmt_strs_rated.txt'

# temp,should load everything only once
# with open(r''+path+app1+filename,'r')as f1:
#     d1 = json.load(f1)
# with open(r''+path+app2+filename,'r')as f2:
#     d2 = json.load(f2)

def readfile(app_name):
    with open(r''+path+app_name+filename,'r')as f:
        return json.load(f)

def cal(num):
    return int(pow(num,2)/10)

def gen_str(cmt_list,max):
    str = ''
    d=max-cmt_list[0][0]
    for cmt in cmt_list:
        # l=cal((d+cmt[0]))
        l=(d+cmt[0])
        # print (l)
        for i in range (l):
        # print (d+cmt[0],cmt[1])
            str=str+cmt[1]+' '
    return str

def gen_str_raw(cmt_list):
    str=''
    for cmt in cmt_list:
        str=str+cmt[1]+' '
    return str

def compare_list(list1,list2):
    max_index=max(list1[0][0],list2[0][0])
    str1=gen_str_raw(list1)
    str2=gen_str_raw(list2)
    str1m=gen_str(list1,max_index)
    str2m=gen_str(list2,max_index)
    # print (str1)
    # print (str2)
    print ('ratio raw: '+str((Levenshtein.ratio(str1,str2))))
    # print (str1m)
    # print (str2m)
    print ('ratio multiplied: '+str((Levenshtein.ratio(str1m,str2m))))
    return

namelist=['QQBrowser','bbtime','Fresh EBT','wzlApp','libby','NOW',
          'Taobao','Tmall','Covet','Dancing Line','QQSports','KuaiBao']
dict_all={}
for i in namelist:
    l=readfile(i)
    dict_all[i]=l
# print (dict_all)
ls = itertools.combinations(namelist, 2)
for l in ls:
    print(l)
    compare_list(dict_all[l[0]],dict_all[l[1]])
# compare_list(d1,d2)
# print (max_index)
# print (Levenshtein.ratio(l1,l2))
