#coding:utf8

from pymongo import MongoClient
import sys
import os
import re
import json
import numpy as np
from nostril import nonsense
#import matplotlib.pyplot as plt


conn = MongoClient('192.168.10.143', 27017)
db = conn.ios_metedata
ipa_basic_set = db.basic_info_0521
ipa_symbol_table = db.symbol_table_0521
ipa_string_table = db.strings_0521


def is_obfuscate(table, h):
    try:
        if table == "string":
            strs = ipa_string_table.find_one({'Hash': h})["Value"].split("\n")
        elif table == "symbol": 
            strs = ipa_symbol_table.find_one({'Hash': h})["Value"].split("\n")
    except:
        return 0
    
    c_nonsense = 0
    c_real = 0
    c_total = 0
    for s in strs:
        try:
            #print(s)
        #print(ipa_string_table.find_one({'Hash': h})["Value"])
            if nonsense(s):
               c_nonsense += 1
#               print(s)
            else:
               c_real += 1
            c_total += 1   
        except:
            pass    
#    print(c_total)       
    if c_nonsense + c_real == 0:
        return 0
    else:
        return float(c_real) / (c_nonsense + c_real)

def main():
    ipa_data = []
    cnt = 0
    
    res = {}
    for ipa in ipa_basic_set.find():
        thre = is_obfuscate(sys.argv[1], ipa['Hash'])
        if thre == 0:
            continue
        cnt += 1
        print("{}: {} {}".format(cnt, ipa['Hash'], thre))
        res[ipa['Hash']] = thre
        if cnt == 10000:
            break

    js_fwh = open(sys.argv[2], 'w', encoding='utf-8')
    json.dump(res, js_fwh)

# file = open('1.json','r',encoding='utf-8')
# info = json.load(file)
# print(info)

# python3 obfuscate_static.py symbol symbol_table.json
# python3 obfuscate_static.py string string_table.json

if __name__ == '__main__':
    main()