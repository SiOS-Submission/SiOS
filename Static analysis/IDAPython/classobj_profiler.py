# -*- coding: utf-8 -*-


from idaapi import *  
from idc import *   
import re
    
autoWait()


# - the Mach-O file is a mixture of objective-c and native c, so this script is somewhat complex
# - start traversing from the native bsd, then the bsd wrapper.
# - use backward slicing tech is reasonable
# - 4 native c


# + ref: https://www.hex-rays.com/products/ida/support/idapython_docs/
# + https://www.hex-rays.com/products/ida/support/idadoc/162.shtml
Obj_Prefix = "_OBJC_CLASS_$_"
_class_t_size = 0x28

addr_traverse_tag = {}          # addr, class name
exit_flag = False

rels = []

def get_trigger(root):
    retme = set() 
    
    
    return

def get_root():
    fst = set()
    cnd = set()
    for i in rels:
        fst.add(i[0])
        cnd.add(i[1])
        
    # u1 - (u1 inter u2) 
    return fst - (fst & cnd)
   

def dbg_(lit_gap, dbg_message):
    dbg = True
    if dbg == True:
        print lit_gap, dbg_message
    return

def info_(lit_gap, info_message):
#    global step
#    if step > 88000 and step < 89000:
    
    info = False
    if info == True:
        print lit_gap, info_message
    return


#step = 0
# 4 64 bit only
# for each iteration, go 1 step further

# oops, i totally have no idea to verify these code
# change `section_name' to `get_segm_attr' maybe more reasonable
 
def build_class_ref_hierarchy(my_ea, gap, last_code_block):
    global addr_traverse_tag
    global exit_flag
    global step
    
#    step += 1
    
    if exit_flag == True:
        return
    #if gap == 4:
    #    return
    ngap = gap + 1
    lit_gap = ""
    for i in range(0, ngap):
        lit_gap += "---"
    lit_gap += ">"

    info_(lit_gap, "entering: " + hex(my_ea))        
    if addr_traverse_tag.has_key(my_ea):
        info_(lit_gap, "has been visited")
        return
    else:
       addr_traverse_tag[my_ea] = 0
                         
    section_name = get_segm_name(my_ea)                 # mach-o name the segment name as section actually
    
    if section_name == "__objc_classlist":              # no reference to this section.
        info_(lit_gap, "__objc_classlist")
        code_refs = XrefsTo(my_ea, 0)                   
        #print type(code_refs)
        #exit_flag = True
        #if len(list(code_refs)) == 0:
        #    print lit_gap, hex(my_ea), get_name(my_ea)  
        for code_ref in code_refs:
            dbg_info(lit_gap, hex(code_ref.frm))            
            build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block)

    elif section_name == "__objc_nlclslist":              # no reference to this section too.
        info_(lit_gap, "__objc_nlclslist")
        code_refs = XrefsTo(my_ea, 0)                   
        #if len(list(code_refs)) == 0:
        #    print lit_gap, hex(my_ea), get_name(my_ea)  
        for code_ref in code_refs:
            dbg_info(lit_gap, hex(code_ref.frm))            
            build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block)

    elif section_name == "__objc_catlist":              # no reference to this section too.
        info_(lit_gap, "__objc_catlist")
        code_refs = XrefsTo(my_ea, 0)                   
        #if len(list(code_refs)) == 0:
        #    print lit_gap, hex(my_ea), get_name(my_ea)  
        for code_ref in code_refs:
            dbg_info(lit_gap, hex(code_ref.frm))            
            build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block)
   
    elif section_name == "__objc_nlcatlist":              # no reference to this section too.
        info_(lit_gap, "__objc_nlcatlist")
        code_refs = XrefsTo(my_ea, 0)                   
        #if len(list(code_refs)) == 0:
        #    print lit_gap, hex(my_ea), get_name(my_ea)  
        for code_ref in code_refs:
            dbg_info(lit_gap, hex(code_ref.frm))            
            build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block)

    elif section_name == "__objc_protolist":              # no reference to this section too.
        info_(lit_gap, "__objc_protolist")
        code_refs = XrefsTo(my_ea, 0)                   
        #if len(list(code_refs)) == 0:
        #    print lit_gap, hex(my_ea), get_name(my_ea)  
        for code_ref in code_refs:
            dbg_info(lit_gap, hex(code_ref.frm))            
            build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block)
                                                       
    elif section_name == "__objc_classrefs":
        info_(lit_gap, "__objc_classrefs")
        
        class_obj_name_pre = get_name(my_ea)
        class_obj_name = re.search(r'classRef_(.*)', class_obj_name_pre, re.M|re.I).group(1)
        
        if class_obj_name != last_code_block:
            rel = [class_obj_name, last_code_block]
            if (rel in rels) == False:
                rels.append(rel)
                info_(lit_gap, rel)  
                
        code_refs = XrefsTo(my_ea, 0)                   
        #if len(list(code_refs)) == 0:
        #    print lit_gap, hex(my_ea), get_name(my_ea)  
        for code_ref in code_refs:
            info_(lit_gap, "start visiting: " + hex(code_ref.frm))            
            build_class_ref_hierarchy(code_ref.frm, ngap, class_obj_name)
            
    elif section_name == "__objc_superrefs":            # TODO: if this is a super class..                  
        info_(lit_gap, "__objc_superrefs")

        class_obj_name_pre = get_name(my_ea)
        class_obj_name = re.search(r'classRef_(.*)', class_obj_name_pre, re.M|re.I).group(1)

        if class_obj_name != last_code_block:        
            rel = [class_obj_name, last_code_block]
            if (rel in rels) == False:
                rels.append(rel)
                info_(lit_gap, rel)  
                    
        code_refs = XrefsTo(my_ea, 0)                   # likely to be code
        #if len(list(code_refs)) == 0:
        #    print lit_gap, hex(my_ea), get_name(my_ea)  
        for code_ref in code_refs:
            info_(lit_gap, "start visiting: " + hex(code_ref.frm))            
            build_class_ref_hierarchy(code_ref.frm, ngap, class_obj_name)
                                     
    elif section_name == "__objc_data":                 # class definition
        info_(lit_gap, "__objc_data")
        #if (my_ea - get_segm_start(my_ea)) % _class_t_size == 0:
        if get_name(my_ea).startswith("_OBJC_CLASS_") == True:
            info_(lit_gap, "class obj")        
            class_obj_refs = XrefsTo(my_ea, 0)
            #if len(list(class_obj_refs)) == 0:
            #    print "***", hex(my_ea), get_name(my_ea) 
            class_obj_name_pre = get_name(my_ea)
            class_obj_name = re.search(r'_OBJC_CLASS_\$_(.*)', class_obj_name_pre, re.M|re.I).group(1)
            
            if class_obj_name != last_code_block:
                rel = [class_obj_name, last_code_block]
                if (rel in rels) == False:
                    rels.append(rel)
                    info_(lit_gap, rel)  
                                       
            for class_obj_ref in class_obj_refs:
                info_(lit_gap, "start visiting: " + hex(class_obj_ref.frm))                  
                build_class_ref_hierarchy(class_obj_ref.frm, ngap, class_obj_name)   
          
        elif get_name(my_ea).startswith("_OBJC_METACLASS_") == True:
            info_(lit_gap, "metaclass obj") 
            class_obj_refs = XrefsTo(my_ea, 0)
            #if len(list(class_obj_refs)) == 0:
            #    print "***", hex(my_ea), get_name(my_ea) 
            class_obj_name_pre = get_name(my_ea)
            class_obj_name = re.search(r'_OBJC_METACLASS_\$_(.*)', class_obj_name_pre, re.M|re.I).group(1)
            
            if class_obj_name != last_code_block:
                rel = [class_obj_name, last_code_block]
                if (rel in rels) == False:
                    rels.append(rel)
                    info_(lit_gap, rel)  
                                       
            for class_obj_ref in class_obj_refs:
                info_(lit_gap, "start visiting: " + hex(class_obj_ref.frm))                  
                build_class_ref_hierarchy(class_obj_ref.frm, ngap, class_obj_name)   
                
        else:
            dbg_(lit_gap, "exception" + hex((my_ea - get_segm_start(my_ea)) % 0x28))
            exit_flag = True
         
    elif section_name == "__text":          # TODO: deal with iteration
        info_(lit_gap, "__text")        
        mthdname = get_func_name(my_ea)
        #print mthdname
    
        if mthdname.startswith("+[") or mthdname.startswith("-["):

            clsname = re.search(r'(.*)\[(.*) (.*)', mthdname, re.M|re.I)
            #print clsname.group(2)
            info_(lit_gap, Obj_Prefix + clsname.group(2))
            #if clsname.group(2) == 'X5ImageAttachment':
                
            if clsname.group(2) != last_code_block:                 # there are self reference
                rel = [clsname.group(2), last_code_block]
                if (rel in rels) == False:
                    rels.append(rel)
                    info_(lit_gap, rel)  
                
            addr = get_name_ea_simple(Obj_Prefix + clsname.group(2))
            if addr != BADADDR:
                info_(lit_gap, "start visiting: " + hex(addr))    
                build_class_ref_hierarchy(addr, ngap, clsname.group(2))
            else:
                dbg_(lit_gap, mthdname + "hit")
                exit_flag = True
        else:
            addr = get_func_attr(my_ea, FUNCATTR_START);
            #print "code ref"
            code_refs = XrefsTo(addr, 0)                   # likely to be code
            #if len(list(code_refs)) == 0:
            #    print "***", hex(my_ea)
            rel = [mthdname, last_code_block]
            if (rel in rels) == False:
                rels.append(rel)
                info_(lit_gap, rel)  
                            
            for code_ref in code_refs:
                info_(lit_gap, "start visiting: " + hex(addr))    
                build_class_ref_hierarchy(code_ref.frm, ngap, mthdname)          
    
    elif section_name == "__const":                         # this may be a block, the ida output does not follow the official description. verify this block later
        # we found vtable, block in this section, in fact, data in this section is very complex, so i step backward to find the first reference.
        # sub_101BAFAD8
        
        '''
        vtable   
        __const:0000000102C20AD0 ; `vtable for'midas::iap::MidasIAPGetIpListCGIParamsConstructor
        __const:0000000102C20AD0 _ZTVN5midas3iap37MidasIAPGetIpListCGIParamsConstructorE DCQ 0
        __const:0000000102C20AD0                                         ; DATA XREF: sub_101C17714+3C↑o
        __const:0000000102C20AD0                                         ; sub_101C17714+40↑o
        __const:0000000102C20AD0                                         ; offset to this
        __const:0000000102C20AD8                 DCQ _ZTIN5midas3iap37MidasIAPGetIpListCGIParamsConstructorE ; `typeinfo for'midas::iap::MidasIAPGetIpListCGIParamsConstructor
        __const:0000000102C20AE0                 DCQ sub_101BAF7D4
        __const:0000000102C20AE8                 DCQ sub_101BAF940
        __const:0000000102C20AF0                 DCQ sub_101BAFAAC
        __const:0000000102C20AF8                 DCQ sub_101BAFAB8
        __const:0000000102C20B00                 DCQ sub_101BAFAC0
        __const:0000000102C20B08                 DCQ sub_101BAFAC8
        __const:0000000102C20B10                 DCQ sub_101C177EC
        __const:0000000102C20B18                 DCQ sub_101C177F0
        __const:0000000102C20B20                 DCQ nullsub_1046
        __const:0000000102C20B28                 DCQ sub_101C17828
        __const:0000000102C20B30                 DCQ sub_101C17B84
        __const:0000000102C20B38                 DCQ sub_101BAFAD8
        __const:0000000102C20B40                 DCQ sub_101BB07F0
        __const:0000000102C20B48                 ALIGN 0x10
        '''
                
        '''     
        block   
        __const:0000000102C20928 off_102C20928   DCQ __NSConcreteGlobalBlock
        __const:0000000102C20928                                         ; DATA XREF: +[MidasIAPBusinessNetModule sharedInstance]+2C↑o
        __const:0000000102C20928                                         ; +[MidasIAPBusinessNetModule sharedInstance]+30↑o
        __const:0000000102C20930                 DCB    0
        __const:0000000102C20931                 DCB    0
        __const:0000000102C20932                 DCB    0
        __const:0000000102C20933                 DCB 0x50 ; P
        __const:0000000102C20934                 DCB    0
        __const:0000000102C20935                 DCB    0
        __const:0000000102C20936                 DCB    0
        __const:0000000102C20937                 DCB    0
        __const:0000000102C20938                 DCQ sub_101C150DC
        __const:0000000102C20940                 DCQ unk_102C20908
        __const:0000000102C20948 unk_102C20948   DCB    0                ; DATA XREF: -[MidasIAPBusinessNetModule addTask:]+6C↑o
        __const:0000000102C20948                                         ; -[MidasIAPBusinessNetModule addTask:]+70↑o
        __const:0000000102C20949                 DCB    0
        __const:0000000102C2094A                 DCB    0
        __const:0000000102C2094B                 DCB    0
        __const:0000000102C2094C                 DCB    0
        __const:0000000102C2094D                 DCB    0
        __const:0000000102C2094E                 DCB    0
        __const:0000000102C2094F                 DCB    0
        __const:0000000102C20950                 DCB 0x30 ; 0
        '''
        
        '''
        addr = my_ea - 0x10

        blks = XrefsFrom(addr)
        for blk in blks:
            if get_name(blk.to) == "__NSConcreteGlobalBlock":
                code_refs = XrefsTo(addr, 0)                 # likely to be code
                #if len(list(code_refs)) == 0:
                #    print "***", hex(my_ea)
                for code_ref in code_refs:
                    info_(lit_gap, "start visiting: " + hex(code_ref.frm))    
                    build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block)       
            else:
                dbg_(lit_gap, "unknown const data: " + hex(my_ea))
                exit_flag = True
                #print get_name(my_ea)
                #print "STOP: ", step                
        '''
        min_ea = my_ea - 0x100
        addr = my_ea
        code_refs = XrefsTo(addr, 0) # init
        
        while addr > min_ea:
            code_refs = XrefsTo(addr, 0)
            if sum(1 for x in code_refs) != 0:
                break
            addr = prev_head(addr, min_ea)

        code_refs = XrefsTo(addr, 0)        
        if my_ea - addr == 0x10:                                                # maybe __NSConcreteGlobalBlock
            p2 = Qword(addr)
            if p2 != idc.BADADDR and p2 != 0:
                if get_name(p2) == "__NSConcreteGlobalBlock":                    # double check
                    for code_ref in code_refs:                            
                        info_(lit_gap, "start visiting: " + hex(code_ref.frm))    
                        build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block)                         
                    return

        code_refs = XrefsTo(addr, 0)                                      
        if get_cmt(addr, 0) == "offset to this":    # vtable                             
            #print "vtable", hex(addr)
            for code_ref in code_refs:
                info_(lit_gap, "start visiting: " + hex(code_ref.frm))    
                build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block)                         
            return                 
        
        
    elif section_name == "__objc_const":        # method or field, a subset of classobj
        #return
        min_ea = my_ea - 0x100
        addr = my_ea
        code_refs = XrefsTo(addr, 0) # init
        
        while addr > min_ea:
            code_refs = XrefsTo(addr, 0)
            if sum(1 for x in code_refs) != 0:
                break
            addr = prev_head(addr, min_ea)

        code_refs = XrefsTo(addr, 0)
        for code_ref in code_refs:
            info_(lit_gap, "start visiting: " + hex(code_ref.frm)) 
            build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block)  
    

    elif section_name == "__data":
        #return
        min_ea = my_ea - 0x100
        addr = my_ea
        code_refs = XrefsTo(addr, 0) # init
        
        while addr > min_ea:
            code_refs = XrefsTo(addr, 0)
            if sum(1 for x in code_refs) != 0:
                break
            addr = prev_head(addr, min_ea)
            
        code_refs = XrefsTo(addr, 0) # init
        for code_ref in code_refs:
            info_(lit_gap, "start visiting: " + hex(code_ref.frm)) 
            build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block) 
                   
    elif section_name == "UNDEF":               # 1. category implementation, do nothing, remove this branch to verify later
                                                # 2. import table reside in this section
        info_(lit_gap, "UNDEF")
        if get_segm_attr(my_ea, SEGATTR_TYPE) == 1:  # Externs, library
            code_refs = XrefsTo(my_ea, 0)                   
            #if len(list(code_refs)) == 0:
            #    print "***", hex(my_ea)
            for code_ref in code_refs:
                info_(lit_gap, "start visiting: " + hex(code_ref.frm)) 
                build_class_ref_hierarchy(code_ref.frm, ngap, last_code_block)                               
    
    elif section_name == "__mod_init_func":
        return
    else:      
        dbg_(lit_gap, "unknown section: " + section_name + ": " + hex(my_ea))        
        exit_flag = True
        #qsleep(100000000)       
                
    return


def main():
    #names = Names()
    #for name in names:
    #    print name
    #print type(name)
    
    #my_ea = 0x102B898E8
    #addr = my_ea - 0x10
    
    #blks = XrefsFrom(addr)
    #for blk in blks:
    #    print get_name(blk.to)     
    
    #my_ea = 0x101BE64A0
    #print get_name(my_ea)
    #my_ea = 0x100012DC8
    #my_ea = 0x100012A30
    #print get_segm_attr(my_ea, SEGATTR_TYPE)
    
    #my_ea = 0x102C1F580
    #print get_type(my_ea)
    #addrcmt = get_extra_cmt(0x102C1F580, 1)
    #0x102c1f570L
    
    
    '''
    NSNetService_Class_Name = "NSNetService"
    NSNetService_sig = Obj_Prefix + NSNetService_Class_Name     # defined as data in name windows
    print NSNetService_sig 
    addr = get_name_ea_simple(NSNetService_sig)
    build_class_ref_hierarchy(addr, 0, NSNetService_Class_Name)
    '''
    
    HTTPServer_Class_Name = "HTTPServer"

    #HTTPServer_Class_Name = "AUTCPServer"
    
    HTTPServer_sig = Obj_Prefix + HTTPServer_Class_Name     # defined as data in name windows
    print HTTPServer_sig  
    addr = get_name_ea_simple(HTTPServer_sig)
    build_class_ref_hierarchy(addr, 0, HTTPServer_Class_Name)
    
    
    SECTION_DEBUG = False
    
    with open("/Users/demo/Desktop/vetting_ios_app_local_server/tmp/res.txt", 'w') as fwh:
        fwh.write("------- rel list -------\n")
        print len(rels)
        fwh.write(str(len(rels)))
        fwh.write('\n')
    
        for i in rels:
            if SECTION_DEBUG == False:
                print i
            fwh.write(str(i))
            fwh.write("\n")
        
        roots = get_root()
        fwh.write("------- root list -------\n")
        print len(roots)
        fwh.write(str(len(roots)))
        fwh.write('\n')
        for i in roots:
            if SECTION_DEBUG == False:        
                if i.startswith("sub_") == False:
                    print Obj_Prefix + i
                else:
                    print i
        
            fwh.write(str(i))
            fwh.write("\n")
    
    # root -> delegate (which mthd?) -> other objc
        for root in roots:
            if root.startswith("sub_") == False:
                triggers = get_trigger(root)
                        
    
    '''
    if addr != BADADDR:  
        print HTTPServer_sig + " (class object) found at: " + str(hex(addr))
        start_addr = 0
        
        class_obj_refs = XrefsTo(addr, 0)
        for class_obj_ref in class_obj_refs:
            print "find reference from", hex(class_obj_ref.frm), "(", class_obj_ref.type, XrefTypeName(class_obj_ref.type), ")", 'to', hex(class_obj_ref.to)
            print get_name(class_obj_ref.frm)
            print get_segm_name(class_obj_ref.frm)
            #  print get_type(class_obj_ref.frm)
            #print get_func_name(my_ea)
            #print get_segm_name(my_ea)
            build_class_ref_hierarchy(class_obj_ref.frm)   
    '''            
    # if the loc in __objc_data section, it's likely to be a meta class object enclosing in another class object
    return

if __name__ == '__main__':
    main()
