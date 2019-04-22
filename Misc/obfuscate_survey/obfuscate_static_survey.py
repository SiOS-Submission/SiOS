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

    file = open('symbol_table.json', 'r', encoding='utf-8')
    info = json.load(file)
    c = 0
    for k in info.keys():
        if info[k] < 0.9:
            c += 1
            print("{}: {}".format(k, info[k]))
    print(c)
    
    # python3 obfuscate_static.py symbol symbol_table.json
    # python3 obfuscate_static.py string string_table.json

if __name__ == '__main__':
    main()