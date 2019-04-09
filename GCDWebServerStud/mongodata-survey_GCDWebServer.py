#coding:utf8

from pymongo import MongoClient
import sys
import os
import re
import json


conn = MongoClient('192.168.10.143', 27017)
db = conn.ios_metedata
ipa_basic_tb = db.basic_info_0521
ipa_symbol_tb = db.symbol_table_0521
ipa_string_tb = db.strings_0521

#     pipe = [
#         {'$match': {'hash': hashsum}},
#         {'$group': {'_id': '$path', 'num': {'$sum': 1}}},
#     ]
#     res = list(db.sdk.aggregate(pipeline=pipe))
    
def overlapping_test():
    
    print ipa_basic_tb.count()
    print len(ipa_basic_tb.distinct("BundleIdentifier"))
    return

def main():
    overlapping_test()
    
# find GCDWebServer:  _OBJC_CLASS_$_GCDWebServer\n
    bundle_gcdwebserver_set = set()

    for i in ipa_string_tb.find({"Value": {"$regex":"GCDWebServer"}}):
        bundle_gcdwebserver_set.add(ipa_basic_tb.find_one({"Hash": i["Hash"]})["BundleIdentifier"])
    print len(bundle_gcdwebserver_set)
    print bundle_gcdwebserver_set
    
    
# find CDVWKWebViewEngine
    bundle_ionic_web_view_set = set()

    for i in ipa_string_tb.find({"Value": {"$regex":"CDVWKWebViewEngine"}}):
        bundle_ionic_web_view_set.add(ipa_basic_tb.find_one({"Hash": i["Hash"]})["BundleIdentifier"])
    print len(bundle_ionic_web_view_set)
    print bundle_ionic_web_view_set

# find ADCWebViewModule
    bundle_adc_web_view_set = set()

    for i in ipa_string_tb.find({"Value": {"$regex":"ADCWebViewModule"}}):
        bundle_adc_web_view_set.add(ipa_basic_tb.find_one({"Hash": i["Hash"]})["BundleIdentifier"])
    print len(bundle_adc_web_view_set)
    print bundle_adc_web_view_set
    
# result: GCDWebServer && !CDVWKWebViewEngine
    bundle_gcdwebserver_and_not_ionic_web_view_set = bundle_gcdwebserver_set - bundle_ionic_web_view_set - bundle_adc_web_view_set
    print len(bundle_gcdwebserver_set - bundle_ionic_web_view_set - bundle_adc_web_view_set)
    print bundle_gcdwebserver_and_not_ionic_web_view_set

    for b in bundle_gcdwebserver_and_not_ionic_web_view_set:
        t = ipa_basic_tb.find_one({"BundleIdentifier":b})
        print t["Path"].encode("utf8")
        os.system("cp " + '"' + t["Path"].encode("utf8")[0:5] + t["Path"].encode("utf8")[9:] + '"' + " /data/ipa_clawer/exchange/ipa/" + b.encode("utf8") + ".ipa")
# find: GCDWebServer && !CDVWKWebViewEngine && BindToLocalhost
#     bundle_gcdwebserver_and_not_ionic_web_view_set_not_bindtolocal = set()
#     for b in bundle_gcdwebserver_and_not_ionic_web_view_set:
#         if ipa_string_tb.find({"BundleIdentifier": b, "Value": {"$regex":"BindToLocalhost"}}).count() == 0:
#             bundle_gcdwebserver_and_not_ionic_web_view_set_not_bindtolocal.add(b)
# 
#     print len(bundle_gcdwebserver_and_not_ionic_web_view_set_not_bindtolocal)
#     print bundle_gcdwebserver_and_not_ionic_web_view_set_not_bindtolocal            

#     print len(bundle_ionic_web_view_set - bundle_gcdwebserver_set)
#     print bundle_ionic_web_view_set - bundle_gcdwebserver_set
    
    return

if __name__ == '__main__':
    main()
