#!/usr/bin/env python
# -*- coding: utf-8 -*-
from objc import nil


# test procedure
# 1. get 

'''
https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/
"trackId":535886823

https://itunes.apple.com/search?term=productivity&country=us&media=software&limit=20
https://itunes.apple.com/search?term=报刊杂志&country=cn&media=software&limit=20


'''

import requests
import base64
import sys
import re
import json

reload(sys)
sys.setdefaultencoding('utf8')

#https://apps.apple.com/cn/genre/ios-%E5%9B%BE%E4%B9%A6/id6018
cats = [u"图书", u"商务", u"商品指南", u"教育", u"娱乐", u"财务", u"美食佳饮", u"游戏", u"健康健美", u"生活", u"报刊杂志", u"医疗", u"音乐", u"导航", u"新闻", u"摄影与录像", u"效率", u"参考", u"购物", u"社交", u"体育", u"贴纸", u"旅游", u"工具", u"天气"]


if __name__ == '__main__':
    
    print "-= start =- "    

    id_collection = set()
    
    for cat in cats:
        try:
            r = requests.get("https://itunes.apple.com/search?term={}&country=cn&media=software&limit=20".format(cat))
#            print r.text
            r_json = json.loads(r.text)
            for i in r_json["results"]:
#                 if i["trackId"] in id_collection:
#                     print "== %s ==" % i["trackId"]
                id_collection.add(i["trackId"])
        except:
            #print r
            continue    
    
    for i in id_collection:
        print i
    print "*** total %s categories, %s items ***" % (len(cats), len(id_collection))                        
    print "-= end =- "
