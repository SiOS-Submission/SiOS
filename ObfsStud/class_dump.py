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

'''
work on my Mac box
'''

ipa_path = "/Volumes/Elements/ipa/5000"
ipa_path_done = "/Volumes/Elements/obfs/class-dump"
cache_path = "/Volumes/Elements/obfs/cache"
bin_path = "/Volumes/Elements/obfs/bin"


class ipa_parse(object):
    ipa_file_path = None
    
    def __init__(self, ipa_file_path):
        '''
        Constructor
        '''
        self.ipa_file_path = ipa_file_path
        
    def gen_binary(self):        
        tmp = []
        zfile = zipfile.ZipFile(self.ipa_file_path)
        zip_name_list = zfile.namelist()
        for name in zip_name_list:
# ./test/手机淘宝.ipa
# Payload/Taobao4iPhone.app/Watch/Taobao4iPhone WatchOS App.app/Info.plist
# Payload/Taobao4iPhone.app/Info.plist
            if name.endswith(".app/Info.plist") == 1:
                tmp.append(name)
                print name
                
        real_plist_file = tmp[0]
        for t in tmp:
            if len(real_plist_file) > len(t):
                real_plist_file = t
        print real_plist_file

        with open(os.path.join(cache_path, "Info.plist"), "w") as fwh:
            fwh.write(zfile.read(real_plist_file))
        
        plist_info_list = readPlist(os.path.join(cache_path, "Info.plist"))
        if 'CFBundleExecutable' in plist_info_list:
            print plist_info_list['CFBundleExecutable']
            executable_file = plist_info_list['CFBundleExecutable']
        else:
            return ""

        # to real_plist_file with bundle path
        executable_path = real_plist_file[:len(real_plist_file) - 10] + executable_file
        print executable_path

        new_executable_path = os.path.join(bin_path, plist_info_list['CFBundleIdentifier'])
        with open(new_executable_path, "w") as fwh:
            fwh.write(zfile.read(executable_path))
        
        os.remove(os.path.join(cache_path, "Info.plist"))

        zfile.close()
        return plist_info_list['CFBundleIdentifier']
    
def main():
    pool = multiprocessing.Pool(processes = 10)

    for dirpath, dirnames, ifilenames in os.walk(ipa_path): 
        for ifilename in ifilenames:
            ipa_file = os.path.join(dirpath, ifilename)
            if ipa_file.endswith(".ipa"):
                print ipa_file
                try:
                    parser = ipa_parse(ipa_file)
                    binfile = parser.gen_binary()
                    print ">>" + binfile
                    
                    os.system("/Users/demo/Desktop/toolbox/class-dump-3.5/class-dump " + "\'" + os.path.join(bin_path, binfile) + "' > " + "\'" + os.path.join(ipa_path_done, binfile) + ".txt\'")
                    os.remove(os.path.join(bin_path, binfile))
                                        
                except Exception as e: 
                    print(e)
                    continue
    pool.close()
    pool.join()
            
    return

if __name__ == '__main__':
    main()
