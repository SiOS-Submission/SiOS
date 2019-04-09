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

ipa_path = "/Volumes/Elements/GCDWebServerStud/gcdwebserver_ipa_fresh"
ipa_path_done = "/Volumes/Elements/GCDWebServerStud/gcdwebserver_ipa_done"
cache_path = "/Volumes/Elements/GCDWebServerStud/cache"
bin_path = "/Volumes/Elements/GCDWebServerStud/bin"

def ida_parse_process(binary_file, mv_src, mv_des):  
    p = Popen("\"/Applications/IDA Pro 7.0/ida.app/Contents/MacOS/ida64\" -B \"{}\"".format(binary_file), stdout = PIPE, stderr = PIPE, shell = True)
    stdout, stderr = p.communicate()    
    os.system("mv " + mv_src + " " + mv_des)

#http://python.jobbole.com/82045/
#multiple process

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
        # overlapping may happen when using ida, so, i make new folder to hold the binary
        new_executable_path = os.path.join(bin_path, plist_info_list['CFBundleIdentifier'])
        print new_executable_path
        os.system("mkdir " + new_executable_path)

        with open(os.path.join(new_executable_path, plist_info_list['CFBundleIdentifier']), "w") as fwh:
            fwh.write(zfile.read(executable_path))
        
        os.remove(os.path.join(cache_path, "Info.plist"))

        zfile.close()
        return os.path.join(new_executable_path, plist_info_list['CFBundleIdentifier'])
    
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
                    
                    print ipa_file
                    print ipa_path_done
                    pool.apply_async(ida_parse_process, args=(binfile, ipa_file, ipa_path_done))
#                     os.system("\"/Applications/IDA Pro 7.0/ida.app/Contents/MacOS/ida64\" -B \"{}\"".format(binfile))
                except Exception as e: 
                    print(e)
                    continue
    pool.close()
    pool.join()
            
    return

if __name__ == '__main__':
    main()
