#coding:utf8

from pymongo import MongoClient
import sys
import os
import re
import json
import numpy as np
from nostril import nonsense
#import matplotlib.pyplot as plt

def main():

    res = {}
    
    cdump_path = "/media/tong/Elements/obfs/class-dump"
    file_gen = "res.json"
    cnt = 0
    
    for dirpath, dirnames, ifilenames in os.walk(cdump_path):
        for ifilename in ifilenames:
            file_path = os.path.abspath(os.path.join(dirpath, ifilename))
            # test from file
            try:
                with open(file_path) as frh:                    
                    c_nonsense = 0
                    c_real = 0
                    c_total = 0
                    for s in frh.readlines():
                        s = s.strip()
                        
                        if s.startswith("-") == False and s.startswith("+") == False :
                            continue
                                    
                        try:
                            if nonsense(s):
                                c_nonsense += 1
                                #print(s)
                    #               print(s)
                            else:
                                #print(s)
                                c_real += 1
                            c_total += 1  
                        except:
                            pass    
                #    print(c_total)       
                    if c_nonsense + c_real == 0:
                        continue
                    else:
                        res[ifilename] = float(c_real) / (c_nonsense + c_real)
                        cnt += 1
                        print("{}: {} {}".format(cnt, ifilename, res[ifilename]))
            except:
                continue            
    js_fwh = open(file_gen, 'w', encoding='utf-8')
    json.dump(res, js_fwh)
                
if __name__ == '__main__':
    main()