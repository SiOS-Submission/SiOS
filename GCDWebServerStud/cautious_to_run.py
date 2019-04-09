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

ipa_db_path = "/Volumes/Elements/GCDWebServerStud/bin/"

def main():

    for dirpaths, dirnames, ifilenames in os.walk(ipa_db_path): 
        for ifilename in ifilenames:
            ipa_db_file = os.path.join(dirpaths, ifilename)
            if ipa_db_file.endswith(".i64") != True:
                print ipa_db_file
                os.system("rm \"{}\"".format(ipa_db_file))
                #time.sleep(1)
                #print ipa_db_file
                #print dirpath[len(ipa_db_path):]
#                print("\"/Applications/IDA Pro 7.0/ida.app/Contents/MacOS/ida64\" -A -S\"{} {}\" {}".format(script_path, ifilename[:len(ifilename) - 4], ipa_db_file))
    return

if __name__ == '__main__':
    main()
