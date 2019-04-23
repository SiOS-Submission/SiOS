#coding:utf8

from pymongo import MongoClient
import sys
import os
import re
import json
import numpy as np
import matplotlib.pyplot as plt


def main():

    file = open('res.json', 'r')
    info = json.load(file)
    c = 0
    for k in info.keys():
        if info[k] < 0.99:
            c += 1
            print("{}: {}".format(k, info[k]))
    print(c)
    
    #return;

    X = [0.90,0.91,0.92,0.93,0.94,0.95,0.96,0.97,0.98,0.99,1.0]
    
    Y = [0]*11
    for k in info.keys():
        Y[int(info[k]*100-90)] += 1
        
    fig = plt.figure()
    plt.bar(X,Y,0.001,color="green")
    plt.xlabel("Percentage of meaningful method in symbol table")
    plt.ylabel("# apps")
    plt.title("Meaningful symbol table")

    xray = 0.9
    for tmp in Y:
        plt.text(xray, tmp + 100, str(tmp), fontsize = 10, rotation = 45)
        xray = xray + 0.01
        #xray = xray + 0.001
      
    plt.show()  
    plt.savefig("barChart.jpg")
    # python3 obfuscate_static.py symbol symbol_table.json
    # python3 obfuscate_static.py string string_table.json

if __name__ == '__main__':
    main()