# -*- coding: utf-8 -*-

import idaapi, idc, idautils, ida_auto
import re

import re
import ida_ua
    
ida_auto.autoWait()

# reference 
# + ref: https://www.hex-rays.com/products/ida/support/idapython_docs/
# + https://www.hex-rays.com/products/ida/support/idadoc/162.shtml
# + http://magiclantern.wikia.com/wiki/IDAPython/intro
# + https://www.fireeye.com/blog/threat-research/2017/03/introduction_to_reve.html
# https://github.com/zynamics/objc-helper-plugin-ida <- for ios, but the output of ida pro has changed tremendous, this script can not run anymore
# https://github.com/fireeye/flare-ida <- for x86
 
def build_call_hierarchy(my_ea, gap, last_code_block):
                    
    return

def get_name_ea():
    return

def _info(ea, info):
    DEBUG = True
    if DEBUG:
        print ea, info
        
    return

    
def get_name(scan_frm, scan_to, start_place):
    
    _info(hex(scan_frm), "start scanning: " + start_place)
    #print hex(scan_frm), "start scanning: " + start_place
    # track the operand is not likely to be reasonable, so, i parse name of the operands 
    
    checking_place = start_place
    poluted_reg_flag = False                 # if source are `may' polluted reg by function call, set the flag 2 True
    
    ea_cur = scan_frm
    ea_to = scan_to
    #print hex(ea)
    
    while ea_cur != idc.BADADDR and ea_cur != ea_to:
        ea_cur = idc.PrevHead(ea_cur, ea_to)
        #print "visiting:", hex(ea_cur), idc.GetDisasm(ea_cur)
        if idaapi.is_call_insn(ea_cur) and idc.GetOpnd(ea_cur, 0) not in ['_objc_retainAutoreleasedReturnValue']:
        
            if poluted_reg_flag == True:        # break if there is a call and the checking place is `X0 - X3', for call may pollute the `X0 - X3' reg
                       
                _info(hex(ea_cur), checking_place + " may pollute, return")
                return None                                             # i will make a radical predict for all undecided classname (all class contains the same selector will be called)
        
        if idc.GetMnem(ea_cur) in ['LDR', 'MOV', 'LDUR', 'ADD']:                   # more inst??
            src_op = 1
            dest_op = 0
        elif idc.GetMnem(ea_cur) in ['STR', 'STUR']:
            src_op = 0
            dest_op = 1
        else:
            continue
        
        
        # idc.GetOpType(ea_cur, dest_op) == idaapi.o_reg and 
        operands = re.match(".*\s+(.+), ([^;]+)(;\w+)*", idc.GetDisasm(ea_cur))
        
        if operands.group(dest_op + 1) == checking_place:
            
            #print hex(ea_cur)
    
            if idc.GetOpType(ea_cur, src_op) == idc.o_reg:
                #print "o_reg"
                
                # __text:0000000100006A00                 ADD             X8, X8, #selRef_class@PAGEOFF
                if idc.GetMnem(ea_cur) == 'ADD':
                    try:
                        name = re.match(".*#.*Ref_(\w+)@PAGEOFF", idc.GetDisasm(ea_cur)).group(1)
                        return name    
                    except:
                        return None                      

                # TODO:  __text:00000001000069C4                 ADD             X1, X1, #cfstr_Xx@PAGEOFF ; "xx"
                
                # Direct reg-reg assignment
                _info(hex(ea_cur), checking_place + ' <-- ' + operands.group(src_op + 1))
                checking_place = operands.group(src_op + 1)
                
                src_reg_val = idc.GetOperandValue(ea_cur, src_op) 
                
                if src_reg_val >= 129 and src_reg_val <= 132:
                    poluted_reg_flag = True
                else:
                    poluted_reg_flag = False    
                    
                #print cur_place

            elif idc.GetOpType(ea_cur, src_op) == idc.o_displ:
                #print "idc.o_displ"
                '''
                __text:000000010000752C                 LDR             X0, [X28,#classRef_UIView@PAGEOFF] ; void *
                __text:0000000100007530                 ADRP            X8, #selRef_alloc@PAGE
                __text:0000000100007534                 LDR             X24, [X8,#selRef_alloc@PAGEOFF]
                __text:0000000100007538                 STR             X24, [SP,#0x100+var_A0]
                __text:000000010000753C                 MOV             X1, X24 ; char *
                __text:0000000100007540                 BL              _objc_msgSend
                
                [UIView alloc], there is no implementation in the binary at all, point to the impementation in framework
                '''
                
                '''
                __text:00000001000076EC                 LDR             X8, [X19,X27]
                __text:00000001000076F0                 CBNZ            X8, loc_100007AA4
                __text:00000001000076F4                 ADRP            X8, #classRef_UILabel@PAGE
                __text:00000001000076F8                 LDR             X0, [X8,#classRef_UILabel@PAGEOFF] ; void *
                __text:00000001000076FC                 LDR             X1, [SP,#0x100+var_A0] ; char *
                
                value of X1 comes from stack, it's a [Base Reg + Index Reg + Displacement] mode
                
                LDR             X0, [X27,#classRef_ESInterface@PAGEOFF] ; void *
                STR             X26, [SP,#0x100+var_A8]
                
                
                the below 2 blocks are the same for a selector assignment
                                
                __text:00000001000069D8                 ADRP            X8, #selRef_setFillColor_@PAGE
                __text:00000001000069DC                 ADD             X8, X8, #selRef_setFillColor_@PAGEOFF
                __text:00000001000069E0                 LDUR            X0, [X29,#var_20]
                __text:00000001000069E4                 LDR             X1, [X8] ; "setFillColor:"
                __text:00000001000069E8                 MOV             X2, X9
                __text:00000001000069EC                 BL              _objc_msgSend                
                
                __text:00000001000069A4                 ADRP            X0, #selRef_setBounds_@PAGE
                __text:00000001000069A8                 LDR             X0, [X0,#selRef_setBounds_@PAGEOFF]
                __text:00000001000069AC                 LDUR            X1, [X29,#var_40+8]
                __text:00000001000069B0                 LDUR            X30, [X29,#var_40]
                __text:00000001000069B4                 STR             X0, [SP,#0x90+var_50]
                __text:00000001000069B8                 MOV             X0, X8  ; void *
                __text:00000001000069BC                 LDR             X8, [SP,#0x90+var_50]
                __text:00000001000069C0                 STR             X1, [SP,#0x90+var_58]
                __text:00000001000069C4                 MOV             X1, X8  ; char *
                __text:00000001000069C8                 MOV             X2, X30
                __text:00000001000069CC                 LDR             X3, [SP,#0x90+var_58]
                __text:00000001000069D0                 BL              _objc_msgSend

                __text:00000001000069FC                 ADRP            X8, #selRef_class@PAGE
                __text:0000000100006A00                 ADD             X8, X8, #selRef_class@PAGEOFF
                __text:0000000100006A04                 ADRP            X0, #classRef_AppDelegate@PAGE
                __text:0000000100006A08                 ADD             X0, X0, #classRef_AppDelegate@PAGEOFF
                __text:0000000100006A0C                 LDUR            W9, [X29,#var_28]
                __text:0000000100006A10                 LDUR            X1, [X29,#var_30]
                __text:0000000100006A14                 LDR             X0, [X0] ; _OBJC_CLASS_$_AppDelegate ; void *
                __text:0000000100006A18                 LDR             X8, [X8] ; "class"
                __text:0000000100006A1C                 STR             X1, [SP,#0x90+var_60]
                __text:0000000100006A20                 MOV             X1, X8  ; char *
                __text:0000000100006A24                 STR             W9, [SP,#0x90+var_64]
                __text:0000000100006A28                 BL              _objc_msgSend

                '''
                poluted_reg_flag = False 
                try:
                    name = re.match(".*#.*Ref_(\w+)@PAGEOFF", idc.GetDisasm(ea_cur)).group(1)
                    return name              
                except:
                    #print idc.GetString(idc.GetOperandValue(ea_cur, 1), -1, idc.ASCSTR_C) 
                    _info(hex(ea_cur), checking_place + ' <-- ' + operands.group(src_op + 1))
                    checking_place = operands.group(src_op + 1)
                    '''
                    __text:0000000100006A00                 ADD             X8, X8, #selRef_class@PAGEOFF
                    ...
                    __text:0000000100006A18                 LDR             X8, [X8] ; "class"                    
                    '''
                    oprand = idc.GetOpnd(ea_cur, 1)
                    if len(oprand) <= 5 and oprand.startswith('[') and oprand.endswith(']'):
                        checking_place = oprand[1: len(oprand) - 1]
                        #print checking_place
            elif idc.GetOpType(ea_cur, src_op) == idc.o_phrase:             # can find nothing at all
                #print "idc.o_phrase"
                _info(hex(ea_cur), checking_place + ' <-- ' + operands.group(src_op + 1))
                checking_place = operands.group(src_op + 1)                
            elif idc.GetOpType(ea_cur, src_op) == ida_ua.o_imm:
                return None    
            else:
                                
                # elif idc.GetOpType(ea_cur, src_op) == idc.o_mem:
                #    print "o_mem"
                
                print hex(ea_cur), idc.GetDisasm(ea_cur), "<----------unknown type operand", 
                # return                
                exit(0)
#            ea_cur = idc.GetOperandValue(ea_cur, dest_op)            
    if checking_place == "X0":
        # X0 point to `self'
        # -[ESUISendCell createSubviewsAndinitLayout]
        try:
            self_name = re.match("-\[(\w+) \w+", idc.get_func_name(ea_cur)).group(1)
            return self_name
        except:
            print '%08x: Unable to solve `self`' % ea_cur
            return None
    else:
        _info(hex(scan_frm), "reaching the start pos of the func")

    return None

TOTAL_CALL = 0
RESOLVED_CALL = 0

def patch_call():

  
    global TOTAL_CALL
    global RESOLVED_CALL
    
    ea = idc.LocByName('_objc_msgSend')
    if ea == idc.BADADDR or ea == 0:
        return
    
    debug_checker = 0x7FFFFFFF
    debug_cur = 0
    
    for xref in idautils.XrefsTo(ea, idaapi.XREF_ALL):
        TOTAL_CALL += 1
        #print hex(xref.frm)
        ea_to = idc.GetFunctionAttr(xref.frm, idc.FUNCATTR_START)
        ea_cur = xref.frm
        
        if not ea_cur or ea_cur == idc.BADADDR:
            continue

        if not ea_to or ea_to == idc.BADADDR:
            continue
        
        _info("****** starting pos: ", hex(ea_cur))
        class_name = get_name(ea_cur, ea_to, 'X0')
        selector_name = get_name(ea_cur, ea_to, 'X1')

        print "[", class_name, selector_name, "]" 
        
        if selector_name == "new":          # patch this inst -> mov X0, X0, TODO: point to init instead
            #print "new"
            idc.PatchDword(ea_cur, 0xAA0003E0)
            idc.MakeCode(ea_cur)
        if selector_name == "init":          # patch this inst -> mov X0, X0, TODO: point to init implementation
            #print "new"
            idc.PatchDword(ea_cur, 0xAA0003E0)
            idc.MakeCode(ea_cur)

        if selector_name == "alloc":          # patch this inst -> mov X0, X0, the return value is the same object
            #print "new"
            idc.PatchDword(ea_cur, 0xAA0003E0)
            idc.MakeCode(ea_cur)

                        
        if class_name == None or selector_name == None:
            debug_cur += 1
            if debug_cur >= debug_checker:
            #if selector_name == "start:":
                print "total call", TOTAL_CALL, "solved call", RESOLVED_CALL
                break
        else:    
            RESOLVED_CALL += 1 
        

               
        # patch_msg_send(ea_cur, ea_to)

    
    '''
    ea_cur = 0x100010bb0L
    
    ea_to = idc.GetFunctionAttr(ea_cur, idc.FUNCATTR_START)
    print "starting pos", hex(ea_cur)

    # class param in `X0', 129
    # selector param in `X1', 130
        
    class_name = get_name(ea_cur, ea_to, "X0")
    selector_name = get_name(ea_cur, ea_to, "X1")

    print "[", class_name, selector_name, "]"    
    return
    '''

def main():
    
    #print hex(idc.LocByName('_objc_msgSend'))
    '''
    ea_cur = 0x0000000100006900
    print hex(idc.GetOperandValue(ea_cur, 1))
    ea_cur = 0x0000000100006974
    print hex(idc.GetOperandValue(ea_cur, 1))
    '''
    
    #return
    #print idc.GetOpType(ea_cur, 1) 
    #print idc.GetOpnd(ea_cur, 1)
    # print hex(idc.GetOperandValue(ea_cur, 2))
    # return

    patch_call()
    
    '''
    ea_cur = idc.LocByName("_OBJC_CLASS_$_" + "Circle")
    ea_cur += 0x20
    ea_cur = idc.Qword(ea_cur)
    print hex(ea_cur)
    ea_cur += 0x20
    ea_cur = idc.Qword(ea_cur)
    ea_cur += 8
        
    print hex(ea_cur)
    '''
    
    return

if __name__ == '__main__':
    main()
