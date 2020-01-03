#!/usr/bin/env python
# -*- coding: utf-8 -*-

#https://github.com/AloneMonkey/frida-ios-dump

# to satisfy frida-dump
# sudo pip install -U cryptography==1.7.1
# sudo -H pip install paramiko==2.1.0

# https://github.com/libimobiledevice/ideviceinstaller

# test procedure
# 1. syn the account
# 2. ideviceinstaller -i path2app
# 3. frida dump
# 4. ideviceinstaller -U [appId]

'''
{ "path" : "9a/12/9a12b7840c8be35ad978b8278bae03850521fd93" }
{ "path" : "c4/65/c46514d5238750f692159a0391318f8b84c4cd10" }
{ "path" : "10/93/1093595feeae7c87c073794e34d5d8abed2067c4" }
{ "path" : "61/c7/61c73a5713ff2b5553dd6529bc00f86219a85316" }
{ "path" : "67/d8/67d87c28a0a34c706b2f322dc188077144aa8dff" }
{ "path" : "88/09/880996cc81843006df65c98459064f0f95dc29f6" }
{ "path" : "08/23/08230dfa2272da81455bfaa7516190bb8401fd30" }
{ "path" : "22/a2/22a23d7f4d36b39b712d0549fa59291ff8068c81" }
{ "path" : "f7/84/f784507f6c6a2cb1aba1e3e86a6ecc03ad15f20c" }
{ "path" : "a1/a8/a1a87c69a7285a25011b96b4694af0bd9deade73" }
{ "path" : "d6/3e/d63ef12ae974d2af5b5213f15cf569876808ed2c" }
{ "path" : "2c/15/2c15db0850653b02633205b3c903a8c75a09ee68" }
{ "path" : "fd/4a/fd4a441d7e6e3b17459fee140286b09f0b713472" }
{ "path" : "e1/b1/e1b16ca618bb6e93689aed4b1c7bb2e834246ee9" }
{ "path" : "d7/a2/d7a2af78609def62c03923f7ad2ad68e5d1013fb" }
{ "path" : "4f/6c/4f6c4096de3fc043f5b8f2f6cb411f2974ad0d73" }
{ "path" : "38/1c/381ce73c73a0a2d7f35e2e67f09c52aa0f4de5ea" }
{ "path" : "6b/1e/6b1e29edbbceba2c0302a1e114937a7f8cde6886" }
{ "path" : "d6/97/d6977c9261f8aec6ad24eb5f274e5a9aa330b27b" }
{ "path" : "d7/c6/d7c65a4309a00ec9beeb7c4bc83bb518fc683b39" }
{ "path" : "72/1e/721ec88b54a1cc45744bb9a7971df19e12fbe52b" }
{ "path" : "ae/d9/aed94ce1e62c1ec0356d36d14fb4a9bbae63d533" }
{ "path" : "17/09/17099dd88052f4465b0727be39cddc326f825386" }
{ "path" : "72/43/724386fb5779a81e7081a8396f5d1a77b2cc76cc" }
{ "path" : "b9/1a/b91a12ce7dc990f2cfb54df372669b9f8cba93c9" }
{ "path" : "e6/5c/e65c1c3ceea3530ec5c2d81ee5a344f33e1d047b" }
{ "path" : "b9/e6/b9e65b208f6a6d1a8f4a839ac1f26b7abe87fc7f" }
{ "path" : "59/6c/596cf2b7c37caec2c105305cf2a51b490b132b40" }
{ "path" : "98/15/98157792ced6507154ac0833c77b8358602bca2e" }
{ "path" : "e4/00/e400a96e77ba26b09812373f11810df1597549fe" }
{ "path" : "c1/0c/c10ca4fb52eec48b672436195d2b1844b13b9a79" }
{ "path" : "55/f3/55f329319b894ba9488a714cfa92e528344b9540" }
{ "path" : "d7/59/d759c4264d529c4ab6c53e32b398b7cd8a396e32" }
{ "path" : "f2/e2/f2e2c39b7a8b23f356623aafa48e2befbfde6c10" }
{ "path" : "aa/ba/aabafb4f68415510826bdb3e642152e7b2dcf5ea" }
{ "path" : "01/a6/01a6e341def86c4d9d9be9bdcbea4c80bdb4e6af" }
{ "path" : "fe/c9/fec9a5c4fd375952eb43d4468b7e91341c36ec2d" }
{ "path" : "ae/06/ae064b34a332a5f51238017f6ceeb16a40aafc76" }
{ "path" : "b7/c2/b7c21e648b70dae1e9cef2da778b1617d5919a5e" }
{ "path" : "97/fd/97fdfb0e9ebd00ca857f260a11bb0ce5da06d45a" }
{ "path" : "f4/d1/f4d1c5b7e638389ee286615aaa7c744a95fabc43" }
{ "path" : "1f/7e/1f7e0eb7eb916bec983b5e484f3ce67e73114abb" }


{ "path" : "/9f/1e/9f1ec3c9594ee9b597196e2f164653f964c9f01d.ipa" }
{ "path" : "/41/25/4125141ae065f2043e9997f91953d9390453adbc.ipa" }
{ "path" : "/0c/a1/0ca195b935f5f9dfd401686f5d0293e5df74b6e3.ipa" }
{ "path" : "/26/b7/26b7a16b84512670facdd99bb9f03989ff442859.ipa" }
{ "path" : "/be/22/be22c37d8ca70ca07c2fb9c811e743098819d91d.ipa" }
{ "path" : "/6c/82/6c82c2bc3eb3bfcd517772326db08760508b5abe.ipa" }
{ "path" : "/44/eb/44eb864cfbd3b4e66e359d0bd7c2573aa152c171.ipa" }
{ "path" : "/fe/f6/fef6b82d7b8d2ebdb47a865cf2ee355d708cd2c8.ipa" }
{ "path" : "/a4/20/a4206b45842f04f644f58c0c7a2afb2ef9db0fe0.ipa" }
{ "path" : "/b0/a1/b0a10c3f1ddae77c15983049a590e0c14512f037.ipa" }
{ "path" : "/ec/14/ec146735df9adb49eb5e4d95242da779bdd51fd0.ipa" }
{ "path" : "/8e/04/8e04b5f9ed8b2b410bdb459c985c6f6eadc44c82.ipa" }

'''

import sys, os
import zipfile
from biplist import readPlist
import datetime
from subprocess import Popen, PIPE
import numpy as np
import matplotlib.pyplot as plt
import matplotlib
import json

reload(sys)
sys.setdefaultencoding('utf8')

ipa_path = "./ipa_test"
cache_path = "./cache"

def get_FileSize(filePath):
    filePath = unicode(filePath, 'utf8')
    fsize = os.path.getsize(filePath)
    fsize = fsize/float(1024*1024)
    return round(fsize, 2)
    
class ipa_parse(object):
    ipa_file_path = None
    
    def __init__(self, ipa_file_path):
        '''
        Constructor
        '''
        self.ipa_file_path = ipa_file_path
    
    def get_bin_size(self):
        tmp = []
        zfile = zipfile.ZipFile(self.ipa_file_path)
        zip_name_list = zfile.namelist()
        for name in zip_name_list:
# ./test/手机淘宝.ipa
# Payload/Taobao4iPhone.app/Watch/Taobao4iPhone WatchOS App.app/Info.plist
# Payload/Taobao4iPhone.app/Info.plist
            if name.endswith(".app/Info.plist") == 1:
                tmp.append(name)
#                print name
                
        real_plist_file = tmp[0]
        for t in tmp:
            if len(real_plist_file) > len(t):
                real_plist_file = t
#        print real_plist_file

        with open(os.path.join(cache_path, "Info.plist"), "w") as fwh:
            fwh.write(zfile.read(real_plist_file))
        
        plist_info_list = readPlist(os.path.join(cache_path, "Info.plist"))
        if 'CFBundleExecutable' in plist_info_list:
#            print plist_info_list['CFBundleExecutable']
            executable_file = plist_info_list['CFBundleExecutable']
        else:
            return ""       
        os.remove(os.path.join(cache_path, "Info.plist"))

        for name in zip_name_list:
# ./test/手机淘宝.ipa
# Payload/Taobao4iPhone.app/Watch/Taobao4iPhone WatchOS App.app/Info.plist
# Payload/Taobao4iPhone.app/Info.plist
            if name.endswith(".app/" + executable_file) == 1:
#                print name
                break
                        
        retMe = len(zfile.read(name))
        retMe = retMe/float(1024*1024)
  
        return round(retMe, 2)
        
    def get_bundle_id(self):        
        tmp = []
        zfile = zipfile.ZipFile(self.ipa_file_path)
        zip_name_list = zfile.namelist()
        for name in zip_name_list:
# ./test/手机淘宝.ipa
# Payload/Taobao4iPhone.app/Watch/Taobao4iPhone WatchOS App.app/Info.plist
# Payload/Taobao4iPhone.app/Info.plist
            if name.endswith(".app/Info.plist") == 1:
                tmp.append(name)
                #print name
                
        real_plist_file = tmp[0]
        for t in tmp:
            if len(real_plist_file) > len(t):
                real_plist_file = t
        #print real_plist_file

        with open(os.path.join(cache_path, "Info.plist"), "w") as fwh:
            fwh.write(zfile.read(real_plist_file))
        
        retMe = readPlist(os.path.join(cache_path, "Info.plist"))['CFBundleIdentifier']
        os.remove(os.path.join(cache_path, "Info.plist"))
        return retMe


if __name__ == '__main__':
    
    time_overhead = {}
    
    print "-= start =- "    
    for dirpath, dirnames, ifilenames in os.walk(ipa_path): 
        for ifilename in ifilenames:
            ipa_file = os.path.join(dirpath, ifilename)
            if ipa_file.endswith(".ipa"):
                #print ipa_file
                try:
                    parser = ipa_parse(ipa_file)
                    
                    bundle_id = parser.get_bundle_id()
                    bin_size = parser.get_bin_size()
                    bundle_size = get_FileSize(ipa_file)
                    print "*** bundle id: %s, bundle file size: %sM, bin file size: %sM ***" % (bundle_id, bundle_size, bin_size)
                    
                    time1 = datetime.datetime.now()
                    p = Popen("/usr/local/bin/ideviceinstaller -i \"{}\"".format(ipa_file), stdout = PIPE, stderr = PIPE, shell = True)
                    stdout, stderr = p.communicate()   

                    time2 = datetime.datetime.now()
                    # start dumping
                    
                    p = Popen("python dump.py \"{}\"".format(bundle_id), stdout = PIPE, stderr = PIPE, shell = True)
                    stdout, stderr = p.communicate()   
                    time3 = datetime.datetime.now()
#                     print stdout
#                     print stderr
                    # end dumping
                    
#                     os.system("ideviceinstaller -i \"{}\"".format(ipa_file))
#                     os.system("ideviceinstaller -U \"{}\"".format(bundle_id))                    
                    p = Popen("/usr/local/bin/ideviceinstaller -U \"{}\"".format(bundle_id), stdout = PIPE, stderr = PIPE, shell = True)
                    stdout, stderr = p.communicate()   
                    
                    print '*** Time elapsed: %ss, install %ss, dump %ss ***' % ((time3 - time1).seconds, (time2 - time1).seconds, (time3 - time2).seconds)
                    
                    time_overhead[bundle_id] = [bundle_size, bin_size, (time3 - time1).seconds, (time2 - time1).seconds, (time3 - time2).seconds]
                    
                except Exception as e: 
                    print(e)
                    continue
    with open('6s.json', 'w') as f:
        json.dump(time_overhead, f)     
                
    print "-= end =- "
