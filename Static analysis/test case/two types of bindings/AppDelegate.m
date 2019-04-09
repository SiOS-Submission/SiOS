//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

//



#import <UIKit/UIKit.h>

#import "AppDelegate.h"





int main(int argc, char * argv[]) {
    
    
    
    @autoreleasepool {
        
        
        
        int value = 6;
        
        int (^multiply_block)(int number) =  ^(int number) {return (value * number);};
        
        int result = multiply_block(7);
        
        printf("Result = %d\n", result);
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}




Automatic bindings use memory on the stack, I have no idea about how to construct call graph for automatic bindings now.



__text:0000000100006A28                 ADD             X1, SP, #0x80+var_48

__text:0000000100006A2C                 ADRP            X30, #___block_descriptor_tmp@PAGE

__text:0000000100006A30                 ADD             X30, X30, #___block_descriptor_tmp@PAGEOFF

__text:0000000100006A34                 ADRP            X8, #___main_block_invoke@PAGE

__text:0000000100006A38                 ADD             X8, X8, #___main_block_invoke@PAGEOFF

__text:0000000100006A3C                 MOV             W9, #0xC0000000

__text:0000000100006A40                 ADRP            X10, #__NSConcreteStackBlock_ptr@PAGE

__text:0000000100006A44                 LDR             X10, [X10,#__NSConcreteStackBlock_ptr@PAGEOFF]

__text:0000000100006A48                 MOV             W11, #6

__text:0000000100006A4C                 STUR            W11, [X29,#var_14]

__text:0000000100006A50                 STR             X10, [SP,#0x80+var_48]

__text:0000000100006A54                 STR             W9, [SP,#0x80+var_40]

__text:0000000100006A58                 STR             WZR, [SP,#0x80+var_3C]

__text:0000000100006A5C                 STR             X8, [SP,#0x80+var_38]

__text:0000000100006A60                 STR             X30, [SP,#0x80+var_30]

__text:0000000100006A64                 LDUR            W9, [X29,#var_14]

__text:0000000100006A68                 STR             W9, [SP,#0x80+var_28]

__text:0000000100006A6C                 STR             X0, [SP,#0x80+var_58]

__text:0000000100006A70                 MOV             X0, X1

__text:0000000100006A74                 BL              _objc_retainBlock

__text:0000000100006A78                 MOV             W1, #7

__text:0000000100006A7C                 STUR            X0, [X29,#var_20]

__text:0000000100006A80                 LDUR            X8, [X29,#var_20]

__text:0000000100006A84                 MOV             X0, X8

__text:0000000100006A88                 LDR             X8, [X8,#0x10]

__text:0000000100006A8C                 BLR             X8

__text:0000000100006A90                 STR             W0, [SP,#0x80+var_4C]

__text:0000000100006A94                 LDR             W9, [SP,#0x80+var_4C]

__text:0000000100006A98                 MOV             X8, X9

__text:0000000100006A9C                 MOV             X10, SP

__text:0000000100006AA0                 STR             X8, [X10,#0x80+var_80]

__text:0000000100006AA4                 ADRP            X0, #aResultD@PAGE ; "Result = %d\n"

__text:0000000100006AA8                 ADD             X0, X0, #aResultD@PAGEOFF ; "Result = %d\n"



__text:0000000100006AAC                 BL              _printf







__text:0000000100006B50 ; =============== S U B R O U T I N E =======================================

__text:0000000100006B50

__text:0000000100006B50

__text:0000000100006B50 ___main_block_invoke                    ; DATA XREF: _main+28↑o

__text:0000000100006B50                                         ; _main+2C↑o

__text:0000000100006B50

__text:0000000100006B50 var_18          = -0x18

__text:0000000100006B50 var_C           = -0xC

__text:0000000100006B50 var_8           = -8

__text:0000000100006B50

__text:0000000100006B50                 SUB             SP, SP, #0x20

__text:0000000100006B54                 STR             X0, [SP,#0x20+var_8]

__text:0000000100006B58                 MOV             X8, X0

__text:0000000100006B5C                 STR             W1, [SP,#0x20+var_C]

__text:0000000100006B60                 STR             X8, [SP,#0x20+var_18]

__text:0000000100006B64                 LDR             W1, [X0,#0x20]

__text:0000000100006B68                 LDR             W9, [SP,#0x20+var_C]

__text:0000000100006B6C                 MADD            W0, W1, W9, WZR

__text:0000000100006B70                 ADD             SP, SP, #0x20

__text:0000000100006B74                 RET


__text:0000000100006B74 ; End of function ___main_block_invoke





//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

//



#import <UIKit/UIKit.h>

#import "AppDelegate.h"





int main(int argc, char * argv[]) {
    
    
    
    @autoreleasepool {
        
        
        
        //int value = 6;
        
        int (^multiply_block)(int number) =  ^(int number) {return (6 * number);};
        
        int result = multiply_block(7);
        
        printf("Result = %d\n", result);
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}




managed bindings are created on the heap



__text:0000000100006A58                 BL              _objc_autoreleasePoolPush

__text:0000000100006A5C                 ADRP            X1, #___block_literal_global@PAGE

__text:0000000100006A60                 ADD             X1, X1, #___block_literal_global@PAGEOFF

__text:0000000100006A64                 STR             X0, [SP,#0x50+var_28]

__text:0000000100006A68                 MOV             X0, X1

__text:0000000100006A6C                 BL              _objc_retainBlock

__text:0000000100006A70                 MOV             W1, #7

__text:0000000100006A74                 STUR            X0, [X29,#var_18]

__text:0000000100006A78                 LDUR            X0, [X29,#var_18]

__text:0000000100006A7C                 MOV             X30, X0

__text:0000000100006A80                 LDR             X0, [X0,#0x10]

__text:0000000100006A84                 STR             X0, [SP,#0x50+var_30]

__text:0000000100006A88                 MOV             X0, X30

__text:0000000100006A8C                 LDR             X30, [SP,#0x50+var_30]

__text:0000000100006A90                 BLR             X30

__text:0000000100006A94                 STUR            W0, [X29,#var_1C]

__text:0000000100006A98                 LDUR            W0, [X29,#var_1C]

__text:0000000100006A9C                 MOV             X30, X0

__text:0000000100006AA0                 MOV             X8, SP

__text:0000000100006AA4                 STR             X30, [X8,#0x50+var_50]

__text:0000000100006AA8                 ADRP            X0, #aResultD@PAGE ; "Result = %d\n"

__text:0000000100006AAC                 ADD             X0, X0, #aResultD@PAGEOFF ; "Result = %d\n"


__text:0000000100006AB0                 BL              _printf





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

__const:00000001000080A8 ; __const       ends




//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

//



#import <UIKit/UIKit.h>

#import "AppDelegate.h"



typedef void (^MKSampleVoidBlockRef)(void);

typedef void (^MKSampleStringBlockRef)(NSString *);

typedef double (^MKSampleMultiplyBlockRef)(void);

typedef double (^MKSampleMultiply2BlockRef)(double c, double d);





int main(int argc, char * argv[]) {
    
    
    
    @autoreleasepool {
        
        
        
        NSString *hello = @"Block 0";
        
        
        
        MKSampleVoidBlockRef myBlock = ^{ NSLog(@"Hello %@!", hello); };
        
        myBlock();
        
        
        
        double a = 10, b = 20;
        
        MKSampleMultiplyBlockRef multiply = ^(void){ return a * b; };
        
        NSLog(@"%f", multiply());
        
        
        
        a = 20;
        
        b = 50;
        
        NSLog(@"%f", multiply());
        
        
        
        
        
        MKSampleVoidBlockRef myBlock1 = ^(void){ NSLog(@"Hello Block 1!"); };
        
        myBlock1();
        
        
        
        MKSampleStringBlockRef myStringBlock = ^(NSString *string){ NSLog(@"Hello %@!", string); };
        
        myStringBlock(@"World");
        
        
        
        MKSampleMultiply2BlockRef multiply2 = ^(double c, double d) { return c * d; };
        
        NSLog(@"%f, %f", multiply2(4, 5), multiply2(5, 2));
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}





__text:0000000100006630                 SUB             SP, SP, #0x110

__text:0000000100006634                 STP             X28, X27, [SP,#0x100+var_10]

__text:0000000100006638                 STP             X29, X30, [SP,#0x100+var_s0]

__text:000000010000663C                 ADD             X29, SP, #0x100

__text:0000000100006640                 STUR            WZR, [X29,#var_14]

__text:0000000100006644                 STUR            W0, [X29,#var_18]

__text:0000000100006648                 STUR            X1, [X29,#var_20]

__text:000000010000664C                 BL              _objc_autoreleasePoolPush

__text:0000000100006650                 ADRP            X1, #cfstr_Block0@PAGE ; "Block 0"

__text:0000000100006654                 ADD             X1, X1, #cfstr_Block0@PAGEOFF ; "Block 0"

__text:0000000100006658                 STR             X0, [SP,#0x100+var_C0]

__text:000000010000665C                 MOV             X0, X1

__text:0000000100006660                 BL              _objc_retain

__text:0000000100006664                 ADRP            X1, #___block_descriptor_tmp@PAGE

__text:0000000100006668                 ADD             X1, X1, #___block_descriptor_tmp@PAGEOFF

__text:000000010000666C                 ADRP            X30, #___main_block_invoke@PAGE

__text:0000000100006670                 ADD             X30, X30, #___main_block_invoke@PAGEOFF

__text:0000000100006674                 MOV             W8, #0xC2000000

__text:0000000100006678                 ADRP            X9, #__NSConcreteStackBlock_ptr@PAGE

__text:000000010000667C                 LDR             X9, [X9,#__NSConcreteStackBlock_ptr@PAGEOFF]

__text:0000000100006680                 SUB             X10, X29, #-var_58

__text:0000000100006684                 STUR            X0, [X29,#var_28]

__text:0000000100006688                 ADD             X10, X10, #0x20

__text:000000010000668C                 STUR            X9, [X29,#var_58]

__text:0000000100006690                 STUR            W8, [X29,#var_50]

__text:0000000100006694                 STUR            WZR, [X29,#var_4C]

__text:0000000100006698                 STUR            X30, [X29,#var_48]

__text:000000010000669C                 STUR            X1, [X29,#var_40]

__text:00000001000066A0                 LDUR            X9, [X29,#var_28]

__text:00000001000066A4                 MOV             X0, X9

__text:00000001000066A8                 STR             X10, [SP,#0x100+var_C8]

__text:00000001000066AC                 BL              _objc_retain

__text:00000001000066B0                 SUB             X9, X29, #-var_58

__text:00000001000066B4                 STUR            X0, [X29,#var_38]

__text:00000001000066B8                 MOV             X0, X9

__text:00000001000066BC                 BL              _objc_retainBlock

__text:00000001000066C0                 STUR            X0, [X29,#var_30]

__text:00000001000066C4                 LDUR            X9, [X29,#var_30]

__text:00000001000066C8                 MOV             X0, X9

__text:00000001000066CC                 LDR             X9, [X9,#0x10]

__text:00000001000066D0                 BLR             X9

__text:00000001000066D4                 ADD             X9, SP, #0x100+var_A0

__text:00000001000066D8                 ADRP            X10, #___block_descriptor_tmp.6@PAGE

__text:00000001000066DC                 ADD             X10, X10, #___block_descriptor_tmp.6@PAGEOFF

__text:00000001000066E0                 ADRP            X0, #___main_block_invoke.4@PAGE

__text:00000001000066E4                 ADD             X0, X0, #___main_block_invoke.4@PAGEOFF

__text:00000001000066E8                 MOV             W8, #0xC0000000

__text:00000001000066EC                 ADRP            X1, #__NSConcreteStackBlock_ptr@PAGE

__text:00000001000066F0                 LDR             X1, [X1,#__NSConcreteStackBlock_ptr@PAGEOFF]

__text:00000001000066F4                 FMOV            D0, #20.0

__text:00000001000066F8                 FMOV            D1, #10.0

__text:00000001000066FC                 STUR            D1, [X29,#var_60]

__text:0000000100006700                 STUR            D0, [X29,#var_68]

__text:0000000100006704                 STR             X1, [SP,#0x100+var_A0]

__text:0000000100006708                 STR             W8, [SP,#0x100+var_98]

__text:000000010000670C                 STR             WZR, [SP,#0x100+var_94]

__text:0000000100006710                 STR             X0, [SP,#0x100+var_90]

__text:0000000100006714                 STR             X10, [SP,#0x100+var_88]

__text:0000000100006718                 LDUR            D0, [X29,#var_60]

__text:000000010000671C                 STR             D0, [SP,#0x100+var_80]

__text:0000000100006720                 LDUR            D0, [X29,#var_68]

__text:0000000100006724                 STR             D0, [SP,#0x100+var_78]

__text:0000000100006728                 MOV             X0, X9

__text:000000010000672C                 BL              _objc_retainBlock

__text:0000000100006730                 STUR            X0, [X29,#var_70]

__text:0000000100006734                 LDUR            X9, [X29,#var_70]

__text:0000000100006738                 MOV             X0, X9

__text:000000010000673C                 LDR             X9, [X9,#0x10]

__text:0000000100006740                 BLR             X9

__text:0000000100006744                 MOV             X9, SP

__text:0000000100006748                 STR             D0, [X9,#0x100+var_100]

__text:000000010000674C                 ADRP            X0, #cfstr_F@PAGE ; "%f"

__text:0000000100006750                 ADD             X0, X0, #cfstr_F@PAGEOFF ; "%f"

__text:0000000100006754                 BL              _NSLog

__text:0000000100006758                 ADRP            X9, #qword_100007F88@PAGE

__text:000000010000675C                 LDR             D0, [X9,#qword_100007F88@PAGEOFF]

__text:0000000100006760                 FMOV            D1, #20.0

__text:0000000100006764                 STUR            D1, [X29,#var_60]

__text:0000000100006768                 STUR            D0, [X29,#var_68]

__text:000000010000676C                 LDUR            X9, [X29,#var_70]

__text:0000000100006770                 MOV             X0, X9

__text:0000000100006774                 LDR             X9, [X9,#0x10]

__text:0000000100006778                 BLR             X9

__text:000000010000677C                 MOV             X9, SP

__text:0000000100006780                 STR             D0, [X9,#0x100+var_100]

__text:0000000100006784                 ADRP            X0, #cfstr_F@PAGE ; "%f"

__text:0000000100006788                 ADD             X0, X0, #cfstr_F@PAGEOFF ; "%f"

__text:000000010000678C                 BL              _NSLog

__text:0000000100006790                 ADRP            X9, #___block_literal_global@PAGE

__text:0000000100006794                 ADD             X9, X9, #___block_literal_global@PAGEOFF

__text:0000000100006798                 MOV             X0, X9

__text:000000010000679C                 BL              _objc_retainBlock

__text:00000001000067A0                 STR             X0, [SP,#0x100+var_A8]

__text:00000001000067A4                 LDR             X9, [SP,#0x100+var_A8]

__text:00000001000067A8                 MOV             X0, X9

__text:00000001000067AC                 LDR             X9, [X9,#0x10]

__text:00000001000067B0                 BLR             X9

__text:00000001000067B4                 ADRP            X9, #___block_literal_global.14@PAGE

__text:00000001000067B8                 ADD             X9, X9, #___block_literal_global.14@PAGEOFF

__text:00000001000067BC                 MOV             X0, X9

__text:00000001000067C0                 BL              _objc_retainBlock

__text:00000001000067C4                 ADRP            X9, #cfstr_World@PAGE ; "World"

__text:00000001000067C8                 ADD             X9, X9, #cfstr_World@PAGEOFF ; "World"

__text:00000001000067CC                 STR             X0, [SP,#0x100+var_B0]

__text:00000001000067D0                 LDR             X10, [SP,#0x100+var_B0]

__text:00000001000067D4                 MOV             X0, X10

__text:00000001000067D8                 LDR             X10, [X10,#0x10]

__text:00000001000067DC                 MOV             X1, X9

__text:00000001000067E0                 BLR             X10

__text:00000001000067E4                 ADRP            X9, #___block_literal_global.19@PAGE

__text:00000001000067E8                 ADD             X9, X9, #___block_literal_global.19@PAGEOFF

__text:00000001000067EC                 MOV             X0, X9

__text:00000001000067F0                 BL              _objc_retainBlock

__text:00000001000067F4                 FMOV            D0, #4.0

__text:00000001000067F8                 FMOV            D1, #5.0

__text:00000001000067FC                 STR             X0, [SP,#0x100+var_B8]

__text:0000000100006800                 LDR             X9, [SP,#0x100+var_B8]

__text:0000000100006804                 MOV             X0, X9

__text:0000000100006808                 LDR             X9, [X9,#0x10]

__text:000000010000680C                 BLR             X9

__text:0000000100006810                 FMOV            D1, #5.0

__text:0000000100006814                 FMOV            D2, #2.0

__text:0000000100006818                 LDR             X9, [SP,#0x100+var_B8]

__text:000000010000681C                 MOV             X0, X9

__text:0000000100006820                 LDR             X9, [X9,#0x10]

__text:0000000100006824                 STR             D0, [SP,#0x100+var_D0]

__text:0000000100006828                 MOV             V0.16B, V1.16B

__text:000000010000682C                 MOV             V1.16B, V2.16B

__text:0000000100006830                 BLR             X9

__text:0000000100006834                 MOV             X9, SP

__text:0000000100006838                 STR             D0, [X9,#0x100+var_F8]

__text:000000010000683C                 LDR             D0, [SP,#0x100+var_D0]

__text:0000000100006840                 STR             D0, [X9,#0x100+var_100]

__text:0000000100006844                 ADRP            X0, #cfstr_FF@PAGE ; "%f, %f"

__text:0000000100006848                 ADD             X0, X0, #cfstr_FF@PAGEOFF ; "%f, %f"


__text:000000010000684C                 BL              _NSLog




basically, if the block reference a local variable, then it will be compiled as `Automatic bindings`,

else, if is compiled as `managed bindings`.



for `Automatic bindings`, the pointer point to implementation directly, so, I connect the `caller` and `callee` directly.



for `managed bindings`, I go to the `__block_impl ` structure to get the implementation.



