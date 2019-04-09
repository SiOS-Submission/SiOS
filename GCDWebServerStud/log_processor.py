#coding:utf8

import io

with io.open("./log.txt", encoding='UTF-8') as f:
    lines = f.read().splitlines()
    # print (lines)
    print (str(len(lines))+' items in total')
names=['DefaultHandlerForMethod', 'DefaultHandlerForMethod_async', 'HandlerForMethod', 'HandlerForMethod_reg', 'startWithOptions', 'BindToLocalhost', 'isObfuscated', 'GCDWebServer', 'GCDWebDAVServer', 'GCDWebUploader']
dict =  { i : set() for i in names + ['isEmpty','isInherited'] }
# print (names,dict)
for i in lines:
    l=i.replace(';','').split(' ')
    isEmpty=True
    for index,j in enumerate (l[1:]):
        # print (index,j,dict[names[index]])
        if j.split(':')[1]=='1':
            isEmpty=False
            # print (isEmpty)
            dict[names[index]].add(l[0])
            if j.split(':')[0]!=names[index]:
                dict['isInherited'].add(l[0])
        # print (isEmpty)
    if isEmpty:
        dict['isEmpty'].add(l[0])
    # print(l)
# print (dict)
for k,v in dict.items():
    print("\n#####{}: have {} items #####".format(k,str(len(v))))
    print (v)

print 715 - len(dict["GCDWebServer"] | dict["GCDWebDAVServer"] | dict["GCDWebUploader"])

bind_to_local_host = dict["BindToLocalhost"]
print bind_to_local_host

isEmpty = dict["isEmpty"]
print isEmpty
print len(isEmpty)

bind_to_local_host_and_isEmpty = bind_to_local_host | isEmpty
print len(bind_to_local_host_and_isEmpty)

print len(bind_to_local_host_and_isEmpty & dict["isInherited"])

DefaultHandlerForMethod = dict["DefaultHandlerForMethod"] | dict["DefaultHandlerForMethod_async"]
print len(DefaultHandlerForMethod - bind_to_local_host)

HandlerForMethod = dict["HandlerForMethod"] | dict["HandlerForMethod_reg"]
print len(HandlerForMethod - bind_to_local_host)

print len((DefaultHandlerForMethod - bind_to_local_host) | (HandlerForMethod - bind_to_local_host))

gcd_web_server = dict["GCDWebServer"]
gcd_web_server_and_not_handler = gcd_web_server - DefaultHandlerForMethod - HandlerForMethod - bind_to_local_host
print len(gcd_web_server_and_not_handler)

gcd_web_uploader = dict["GCDWebUploader"]
print len(gcd_web_uploader - bind_to_local_host)

gcd_web_dav_server = dict["GCDWebDAVServer"]
print len(gcd_web_dav_server - bind_to_local_host)

print len(gcd_web_server_and_not_handler | (gcd_web_uploader - bind_to_local_host) | (gcd_web_dav_server - bind_to_local_host))
