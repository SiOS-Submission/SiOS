# -*- coding: utf-8 -*-

import idaapi, idc, idautils, ida_auto
import re
import os.path
import ida_ua
# import pickle
import simplejson as json

ida_path=get_idb_path()
print ida_path
folder_path=os.path.dirname(os.path.dirname(os.path.dirname(ida_path)))
with open(folder_path+'\detourinfo.dat','r') as f:
    log_list=[]
    offset=''
    is_1st=True
    for l in f.readlines():
        r=re.search('\s*\d*\s*\S*\s*0x[\da-f]{16}\s\S*\s\+\s\d*',l)
        if r and is_1st:
            # print (r.group())
            t = r.group().split()
            t.remove('+')
            log_list.append(t)
        if l.startswith('['):
            # print (l)
            offset=l[6:24]
        if '\t)'in l:
            is_1st=False
    # print (offset)
    # print (log_list)

def hex2int(hex_str):
    return int(hex_str[2:],16)

# def lstr2int(lstr):
#     return int(lstr[:-1])

fun_range_list=[]
for i in log_list:
    addr=hex2int(i[2])-hex2int(offset)
    # print (hex(addr),addr)
    print hex(addr),i[1],i[3]
    ea = idc.Jump(addr)
    if ea == idc.BADADDR or ea == 0:
        print "BADADDR"
        continue
    ea = addr

    start = idc.GetFunctionAttr(ea, FUNCATTR_START)
    end = idc.GetFunctionAttr(ea, FUNCATTR_END)
    # add_range=[SegStart(ea),SegEnd(ea)]

    add_range=[start,end]
    # if add_range not in fun_range_list:
    fun_range_list.append(add_range)
    i.append(add_range)
    # print hex(add_range[0]),hex(add_range[1])
    # func = idaapi.get_func(addr)
    # funcname = GetFunctionName(func.startEA)
    # for funcea in Functions(SegStart(ea), SegEnd(ea)):
    #     name = GetFunctionName(funcea)
    #     print name
    # print SegName()
    # print (addr)

# print fun_range_list
for i in fun_range_list:
    print hex(i[0]),hex(i[1])

# print log_list

# DEBUG
# fun_range_list=[[int(0x0000001002A95AC),int(0x0000001002A9624)]]
print '#####COMMENTS#####'
# with open(folder_path+'\cmt_strs_rated.txt','w') as fr:
with open(folder_path+'\cmt_strs.json','w') as f:
    l=len(fun_range_list)
    # hardcode
    # l=11
    cmt_list=[]
    for index,pairs in enumerate(fun_range_list):
        # print pairs
        # print int(pairs[0]),int(pairs[1])
        for i in range(int(pairs[0]),int(pairs[1]),4):
            asms=filter(None,GetDisasm(i).split(';'))
            if len(asms)>=2:
                cmt=Comment(i)
                as_cmt=asms[-1].lstrip()
                if asms[-1].lstrip()!=cmt:
                    # print hex(i),asms,cmt
                    print hex(i),l-index,as_cmt
                    cmt_list.append([l-index,as_cmt])
                    # f.write(str(l-index)+'\t'+as_cmt+'\n')
                    # # obsolete
                    # f.write(as_cmt+' ')
                    # for j in range(l-index):
                    #      fr.write(as_cmt+' ')
    # print cmt_list
    json.dump(cmt_list, f)
    # #non-empty block algorism
    # block_index=list(set([row[0] for row in cmt_list]))
    # # print block_index
    # for cmt in cmt_list:
    #     r = block_index.index(cmt[0])+1
    #     print r,cmt[1]
    #     # f.write(cmt[1]+' ')#no multiplier
    #     for i in range(r):
    #         f.write(cmt[1]+' ')#w multiplier
    #         # cmt=RptCmt(i)
    #         # if cmt:
    #         #     print hex(i),cmt
