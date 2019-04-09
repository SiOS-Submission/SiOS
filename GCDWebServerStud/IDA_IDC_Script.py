#coding:utf8

import sys
import os
import re
import json
import zipfile
import string
from biplist import readPlist
from subprocess import Popen, PIPE
import multiprocessing
import time

#ipa_db_path = "/Volumes/Elements/GCDWebServerStud/bin/" # add the last slash...
ipa_db_path = "/Users/demo/Desktop/bin/" # add the last slash...
#ipa_db_path = "/Users/demo/Desktop/vetting_ios_app_local_server/code/poc/GCDWebServerStud/testcase/" # add the last slash...
script_path = "/Users/demo/Desktop/vetting_ios_app_local_server/code/poc/GCDWebServerStud/GCDWebServer_Analysis.idc"

def main():

    for dirpath, dirnames, ifilenames in os.walk(ipa_db_path): 
        for ifilename in ifilenames:
            ipa_db_file = os.path.join(dirpath, ifilename)
            if ipa_db_file.endswith(".i64"):
                #time.sleep(1)
                print ipa_db_file
                #print dirpath[len(ipa_db_path):]
#                print("\"/Applications/IDA Pro 7.0/ida.app/Contents/MacOS/ida64\" -A -S\"{} {}\" {}".format(script_path, ifilename[:len(ifilename) - 4], ipa_db_file))
                try:
                    print("\"/Applications/IDA Pro 7.0/ida.app/Contents/MacOS/ida64\" -A -S\"{} {}\" \"{}\"".format(script_path, dirpath[len(ipa_db_path):], ipa_db_file)) 
                    os.system("\"/Applications/IDA Pro 7.0/ida.app/Contents/MacOS/ida64\" -A -S\"{} {}\" \"{}\"".format(script_path, dirpath[len(ipa_db_path):], ipa_db_file)) 
#                     os.system("\"/Applications/IDA Pro 7.0/ida.app/Contents/MacOS/ida64\" -B \"{}\"".format(binfile))
                except Exception as e: 
                    print(e)
                    continue
            
    return

if __name__ == '__main__':
    main()
