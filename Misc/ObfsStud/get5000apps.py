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

    c = 0
    for t in ipa_basic_tb.find():
        print t["Path"].encode("utf8")
        os.system("cp " + '"' + t["Path"].encode("utf8")[0:5] + t["Path"].encode("utf8")[9:] + '"' + " /data/ipa_clawer/exchange/5000/" + t["BundleIdentifier"].encode("utf8") + ".ipa")
        c += 1
        if c == 5000:
            break
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
