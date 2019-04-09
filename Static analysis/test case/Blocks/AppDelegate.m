
//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

//



// blocks is likely to be a disaster for our analysis

// basically, blocks can be considered as function pointer.



// Blocks have two types of bindings: automatic and managed. Automatic bindings use memory on the stack, and managed bindings are created on the heap.





#import <UIKit/UIKit.h>

#import "AppDelegate.h"





int main(int argc, char * argv[]) {
    
    
    
    @autoreleasepool {
        
        
        
        void (^theBlock)() = ^{ printf("Hello Blocks!\n"); };
        
        theBlock();
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}







__text:0000000100006A74                 ADRP            X1, #___block_literal_global@PAGE

__text:0000000100006A78                 ADD             X1, X1, #___block_literal_global@PAGEOFF

__text:0000000100006A7C                 STUR            X0, [X29,#var_20]

__text:0000000100006A80                 MOV             X0, X1

__text:0000000100006A84                 BL              _objc_retainBlock

__text:0000000100006A88                 STUR            X0, [X29,#var_18]

__text:0000000100006A8C                 LDUR            X0, [X29,#var_18]

__text:0000000100006A90                 MOV             X1, X0

__text:0000000100006A94                 LDR             X0, [X0,#0x10]

__text:0000000100006A98                 STUR            X0, [X29,#var_28]

__text:0000000100006A9C                 MOV             X0, X1

__text:0000000100006AA0                 LDUR            X1, [X29,#var_28]


__text:0000000100006AA4                 BLR             X1







__const:0000000100008090 ___block_literal_global DCQ __NSConcreteGlobalBlock

__const:0000000100008090                                         ; DATA XREF: _main+1C↑o

__const:0000000100008090                                         ; _main+20↑o

__const:0000000100008098                 DCB    0

__const:0000000100008099                 DCB    0

__const:000000010000809A                 DCB    0

__const:000000010000809B                 DCB 0x50 ; P

__const:000000010000809C                 DCB    0

__const:000000010000809D                 DCB    0

__const:000000010000809E                 DCB    0

__const:000000010000809F                 DCB    0

__const:00000001000080A0                 DCQ ___main_block_invoke

__const:00000001000080A8                 DCQ ___block_descriptor_tmp





__text:0000000100006B54 ; Attributes: bp-based frame

__text:0000000100006B54

__text:0000000100006B54 ___main_block_invoke                    ; DATA XREF: __const:00000001000080A0↓o

__text:0000000100006B54

__text:0000000100006B54 var_14          = -0x14

__text:0000000100006B54 var_10          = -0x10

__text:0000000100006B54 var_8           = -8

__text:0000000100006B54 var_s0          =  0

__text:0000000100006B54

__text:0000000100006B54                 SUB             SP, SP, #0x30

__text:0000000100006B58                 STP             X29, X30, [SP,#0x20+var_s0]

__text:0000000100006B5C                 ADD             X29, SP, #0x20

__text:0000000100006B60                 STUR            X0, [X29,#var_8]

__text:0000000100006B64                 STR             X0, [SP,#0x20+var_10]

__text:0000000100006B68                 ADRP            X0, #aHelloBlocks@PAGE ; "Hello Blocks!\n"

__text:0000000100006B6C                 ADD             X0, X0, #aHelloBlocks@PAGEOFF ; "Hello Blocks!\n"

__text:0000000100006B70                 BL              _printf

__text:0000000100006B74                 STR             W0, [SP,#0x20+var_14]

__text:0000000100006B78                 LDP             X29, X30, [SP,#0x20+var_s0]

__text:0000000100006B7C                 ADD             SP, SP, #0x30

__text:0000000100006B80                 RET









struct __block_impl {
    
    void *isa;
    
    int Flags;
    
    int Reserved;
    
    void *FuncPtr;
    
};



static struct __main_block_desc_0 {
    
    size_t reserved;
    
    size_t Block_size;
    
    
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};



struct __main_block_impl_0 {
    
    struct __block_impl impl;
    
    struct __main_block_desc_0* Desc;
    
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int flags=0) {
        
        impl.isa = &_NSConcreteStackBlock;
        
        impl.Flags = flags;
        
        impl.FuncPtr = fp; +0x10 is the pointer to the blocks
        
        Desc = desc;
        
    }
    
    
};





void (*theBlock)() = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA));


((void (*)(__block_impl *))((__block_impl *)theBlock)->FuncPtr)((__block_impl *)theBlock);

