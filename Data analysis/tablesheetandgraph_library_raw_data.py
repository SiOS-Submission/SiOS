# coding:utf-8

from pymongo import MongoClient
import sys
import os
import time
import re
import json
import numpy as np
#import matplotlib.pyplot as plt
import datetime

conn = MongoClient('127.0.0.1', 27017)
db = conn.ios_metedata

ipa_basic_set = db.basic_info_0521
ipa_symbol_table = db.symbol_table_0521
ipa_string_table = db.strings_0521

# ipa_basic_set = db.chs_basic_info
# ipa_symbol_table = db.chs_symbol_table
# ipa_string_table = db.chs_strings

# ipa_basic_set = db.us_basic_info
# ipa_symbol_table = db.us_symbol_table
# ipa_string_table = db.us_strings

def dump_file(filename, rst):
    with open(filename, 'w') as f_dump:
        json.dump(rst, f_dump)

                                                                                               
library_result = {}   
def scan4sig(hash, category, string_table, symbol_table):
    
    library = []
    
    # , 
    # system library
    res = re.search(" _bind\n", symbol_table)
    if res:
        library.append("_bind")

    res = re.search(" _res_9_nquery\n", symbol_table)
    if res:
        library.append("_res_9_nquery")

    res = re.search(" _CFSocketSetAddress\n", symbol_table)
    if res:
        library.append("_CFSocketSetAddress")
    
    res1 = re.search(" _OBJC_CLASS_\$_GKLocalPlayer\n", symbol_table)
    res2 = re.search("localPlayer", string_table)
    res3 = re.search("registerListener:", string_table)
    if (res1 and res2 and res3):
        library.append("Game Kit (1)")                

    res1 = re.search(" _OBJC_CLASS_\$_GKMatchmaker\n", symbol_table)
    res2 = re.search("sharedMatchmaker", string_table)
    res3 = re.search("setInviteHandler:", string_table)
    if (res1 and res2 and res3):
        library.append("Game Kit (2)")  

    res = re.search(" _OBJC_CLASS_\$_MCSession\n", symbol_table)
    if res:
        library.append("Multipeer Connectivity")
            
    # third-party library
    res = re.search("Chromecast", string_table)
    if res:
        library.append("Google Cast")        

    res = re.search("SiphonServer", string_table)
    if res:
        library.append("SmartDeviceLink")  

    res = re.search("Portable SDK for UPnP devices", string_table)
    if res:
        library.append("pupnp")  

    res = re.search("SmartView", string_table)
    if res:
        library.append("SmartView")  

    res = re.search("Start MQTT broker", string_table)
    if res:
        library.append("MQTT")  

#     res1 = re.search("Started HTTP Server on port", string_table, re.IGNORECASE)
#     res2 = re.search("Started HTTP server on port", string_table, re.IGNORECASE)
#     res3 = re.search("Started HTTP server on ip", string_table, re.IGNORECASE)
#     if (res1 or res2 or res3):
#         library.append("CocoaHTTPServer")  
    res1 = re.search("CocoaHTTPServer", string_table)
    res2 = re.search("setDocumentRoot:", string_table)
    if (res1 and res2):
        library.append("CocoaHTTPServer")  

    res = re.search("GCDWebServer", string_table)
    if res:
        library.append("GCDWebServer")  

    res = re.search("pure-ftpd (SERVER)", string_table)
    if res:
        library.append("Pure-FTPd")  

    res = re.search("SSDPDiscoveryProvider", string_table)
    if res:
        library.append("Connect SDK Core (iOS)")  

    res1 = re.search("CDVWKWebViewEngine", string_table)
    res2 = re.search("GCDWebServer", string_table)
    if res1 and res2:
        library.append("Ionic's Webview")  

    res = re.search("UnityEngine.iOS", string_table)
    if res:
        library.append("UnityEngine.iOS")  

    res = re.search("Torque 3D", string_table)
    if res:
        library.append("Torque 3D")  

    res1 = re.search("TJHTTPServer", string_table)
    res2 = re.search("setDocumentRoot:", string_table)
    if (res1 and res2):
        library.append("Tapjoy-CocoaHTTPServer-Extension")  
        
#     res = re.search("Tapjoy", string_table)
#     if res:
#         library.append("Tapjoy")  
                            
    res = re.search("TextureStreaming", string_table)
    if res:
        library.append("Unreal Engine 4")  
        
    res = re.search("ProudNet", string_table)
    if res:
        library.append("ProudNet")  
        
    res = re.search("dial-multiscreen-org", string_table)
    if res:
        library.append("DIAL") 
        
    res = re.search("__PJSIP_VERSION__", string_table)
    if res:
        library.append("PJSIP") 

    res = re.search("WebRTC", string_table)
    if res:
        library.append("WebRTC") 
                
    res = re.search("MobileIMSDK", string_table)
    if res:
        library.append("MobileIMSDK") 
        
    res = re.search("HappyDNS", string_table)
    if res:
        library.append("Happy DNS") 
        
    res1 = re.search("boost", string_table)
    res2 = re.search("asio", string_table)
    res3 = re.search("io_service", string_table)
    if (res1 and res2 and res3):
        library.append("boost::asio::io_service")  

    res = re.search("http://www.plutinosoft.com/", string_table)
    if res:
        library.append("Platinum UPnP") 
        
    res = re.search("fkuehne", string_table)
    if res:
        library.append("upnpx") 
                
    res = re.search("PDRCoreHttpDaemon", string_table)
    if res:
        library.append("PDRCoreHttpDaemon") 
        
    res = re.search("PSLStreaming", string_table)
    if res:
        library.append("inke SDK") 

    res = re.search("TencentVideoHttpProxy", string_table)
    if res:
        library.append("TencentVideoHttpProxy") 

    res = re.search("LocalSocketServer@native@tcms", string_table)
    if res:
        library.append("wangxin.taobao") 

    res = re.search("Mongoose Server is running on", string_table)
    if res:
        library.append("MongooseDaemon") 

    res = re.search("LeTVCDEService", string_table)
    if res:
        library.append("LeTVCDE") 

    res = re.search("libupnp", string_table)
    if res:
        library.append("libupnp") 

    res = re.search("Audiobus", string_table)
    if res:
        library.append("Audiobus SDK") 

    res = re.search("WSPXMtunnelManager", string_table)
    if res:
        library.append("MAASDK") 

    res = re.search("Funshion", string_table)
    if res:
        library.append("FunTV") 

    res = re.search("grpc.socket_mutator", string_table)
    if res:
        library.append("gRPC") 

    res = re.search("YunFanNet", string_table)
    if res:
        library.append("yfcloud") 

    res1 = re.search("GCDAsyncSocket", string_table)
    res2 = re.search("AsyncUDPSocket", string_table)
    if (res1 or res2):
        library.append("CocoaAsyncSocket")  

    res = re.search("GCDTelnetServer", string_table)
    if res:
        library.append("GCDTelnetServer") 
                
                                                                                                                                                                                                                                                            
    if len(library) != 0:
        library_result[hash] = [category, library]
    
    return

counter = 0
def go():
    starttime = datetime.datetime.now()
    global counter
    docs = ipa_basic_set.find({}, no_cursor_timeout = True) 
    for doc in docs:
        counter += 1
        if counter % 100 == 0:
            endtime = datetime.datetime.now()
            print "counter: " + str(counter) + ", elapsed: " + str((endtime - starttime).seconds )
        string_table = ""
        symbol_table = ""
        docs_string = ipa_string_table.find(
            {'Hash': doc['Hash']},
            {'Value': 1}
        )        
        for ele in docs_string:
            string_table += ele['Value']

        docs_symbol = ipa_symbol_table.find(
            {'Hash': doc['Hash']},
            {'Value': 1}
        )        
        for ele in docs_symbol:
            symbol_table += ele['Value']

        scan4sig(doc['Hash'], doc['Category'], string_table, symbol_table)
    
    for i in library_result.values():
        print i
    dump_file("library_raw_data.json", library_result)
          
    return

if __name__ == '__main__':
    reload(sys)
    sys.setdefaultencoding('utf8')
    #main()
    go()