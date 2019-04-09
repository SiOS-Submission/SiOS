//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

//



#import <UIKit/UIKit.h>

#import "AppDelegate.h"



@interface Foo : NSObject {
    
    __strong NSOperationQueue *_operationQueue;
    
}

-(void)foox;

@end



@implementation Foo



-(void)foox

{
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"My Block Operation");
        
    }];
    
    
    
    _operationQueue = [[NSOperationQueue alloc] init];
    
    _operationQueue.maxConcurrentOperationCount = 5;
    
    [_operationQueue addOperation:blockOperation];
    
    [_operationQueue addOperation:[self operationWithData:@"My Sample Data"]];
    
    [_operationQueue addOperationWithBlock:^{
        
        NSLog(@"Inline Operation with Block");
        
    }];
    
    [blockOperation addExecutionBlock:^{
        
        NSLog(@"Adding execution block to existing block");
        
    }];
    
}



- (NSOperation *)operationWithData:(id)data

{
    
    return [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(myWorkerMethod:) object:data];
    
}



// This is the method that does the actual work

- (void)myWorkerMethod:(id)data

{
    
    NSLog(@"My Worker Method %@", data);
    
}



@end



int main(int argc, char * argv[]) {
    
    
    
    @autoreleasepool {
        
        
        
        Foo *myfoo = [Foo new];
        
        [myfoo foox];
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}







__text:000000010000657C ; =============== S U B R O U T I N E =======================================

__text:000000010000657C

__text:000000010000657C ; Attributes: bp-based frame

__text:000000010000657C

__text:000000010000657C ; void __cdecl -[Foo foox](Foo *self, SEL)

__text:000000010000657C __Foo_foox_                             ; DATA XREF: __objc_const:0000000100008E30↓o

__text:000000010000657C

__text:000000010000657C var_28          = -0x28

__text:000000010000657C var_20          = -0x20

__text:000000010000657C var_18          = -0x18

__text:000000010000657C var_10          = -0x10

__text:000000010000657C var_8           = -8

__text:000000010000657C var_s0          =  0

__text:000000010000657C

__text:000000010000657C                 SUB             SP, SP, #0x40

__text:0000000100006580                 STP             X29, X30, [SP,#0x30+var_s0]

__text:0000000100006584                 ADD             X29, SP, #0x30

__text:0000000100006588                 ADRP            X8, #___block_literal_global@PAGE

__text:000000010000658C                 ADD             X8, X8, #___block_literal_global@PAGEOFF

__text:0000000100006590                 ADRP            X9, #selRef_blockOperationWithBlock_@PAGE

__text:0000000100006594                 ADD             X9, X9, #selRef_blockOperationWithBlock_@PAGEOFF

__text:0000000100006598                 ADRP            X10, #classRef_NSBlockOperation@PAGE

__text:000000010000659C                 ADD             X10, X10, #classRef_NSBlockOperation@PAGEOFF

__text:00000001000065A0                 STUR            X0, [X29,#var_8]

__text:00000001000065A4                 STUR            X1, [X29,#var_10]

__text:00000001000065A8                 LDR             X10, [X10] ; _OBJC_CLASS_$_NSBlockOperation

__text:00000001000065AC                 LDR             X1, [X9] ; "blockOperationWithBlock:"

__text:00000001000065B0                 MOV             X0, X10 ; void *

__text:00000001000065B4                 MOV             X2, X8

__text:00000001000065B8                 BL              _objc_msgSend

__text:00000001000065BC                 MOV             X29, X29

__text:00000001000065C0                 BL              _objc_retainAutoreleasedReturnValue

__text:00000001000065C4                 ADRP            X8, #selRef_alloc@PAGE

__text:00000001000065C8                 ADD             X8, X8, #selRef_alloc@PAGEOFF

__text:00000001000065CC                 ADRP            X9, #classRef_NSOperationQueue@PAGE

__text:00000001000065D0                 ADD             X9, X9, #classRef_NSOperationQueue@PAGEOFF

__text:00000001000065D4                 STR             X0, [SP,#0x30+var_18]

__text:00000001000065D8                 LDR             X9, [X9] ; _OBJC_CLASS_$_NSOperationQueue

__text:00000001000065DC                 LDR             X1, [X8] ; "alloc"

__text:00000001000065E0                 MOV             X0, X9  ; void *

__text:00000001000065E4                 BL              _objc_msgSend

__text:00000001000065E8                 ADRP            X8, #selRef_init@PAGE

__text:00000001000065EC                 ADD             X8, X8, #selRef_init@PAGEOFF

__text:00000001000065F0                 LDR             X1, [X8] ; "init"

__text:00000001000065F4                 BL              _objc_msgSend

__text:00000001000065F8                 ADRP            X8, #_OBJC_IVAR_$_Foo._operationQueue@PAGE ; NSOperationQueue *_operationQueue;

__text:00000001000065FC                 ADD             X8, X8, #_OBJC_IVAR_$_Foo._operationQueue@PAGEOFF ; NSOperationQueue *_operationQueue;

__text:0000000100006600                 LDUR            X9, [X29,#var_8]

__text:0000000100006604                 LDRSW           X8, [X8] ; NSOperationQueue *_operationQueue;

__text:0000000100006608                 ADD             X8, X9, X8

__text:000000010000660C                 LDR             X9, [X8]

__text:0000000100006610                 STR             X0, [X8]

__text:0000000100006614                 MOV             X0, X9

__text:0000000100006618                 BL              _objc_release

__text:000000010000661C                 MOV             X2, #5

__text:0000000100006620                 ADRP            X8, #selRef_setMaxConcurrentOperationCount_@PAGE

__text:0000000100006624                 ADD             X8, X8, #selRef_setMaxConcurrentOperationCount_@PAGEOFF

__text:0000000100006628                 ADRP            X9, #_OBJC_IVAR_$_Foo._operationQueue@PAGE ; NSOperationQueue *_operationQueue;

__text:000000010000662C                 ADD             X9, X9, #_OBJC_IVAR_$_Foo._operationQueue@PAGEOFF ; NSOperationQueue *_operationQueue;

__text:0000000100006630                 LDUR            X10, [X29,#var_8]

__text:0000000100006634                 LDRSW           X9, [X9] ; NSOperationQueue *_operationQueue;

__text:0000000100006638                 ADD             X9, X10, X9

__text:000000010000663C                 LDR             X9, [X9]

__text:0000000100006640                 LDR             X1, [X8] ; "setMaxConcurrentOperationCount:"

__text:0000000100006644                 MOV             X0, X9  ; void *

__text:0000000100006648                 BL              _objc_msgSend

__text:000000010000664C                 ADRP            X8, #selRef_addOperation_@PAGE

__text:0000000100006650                 ADD             X8, X8, #selRef_addOperation_@PAGEOFF

__text:0000000100006654                 ADRP            X9, #_OBJC_IVAR_$_Foo._operationQueue@PAGE ; NSOperationQueue *_operationQueue;

__text:0000000100006658                 ADD             X9, X9, #_OBJC_IVAR_$_Foo._operationQueue@PAGEOFF ; NSOperationQueue *_operationQueue;

__text:000000010000665C                 LDUR            X10, [X29,#var_8]

__text:0000000100006660                 LDRSW           X9, [X9] ; NSOperationQueue *_operationQueue;

__text:0000000100006664                 ADD             X9, X10, X9

__text:0000000100006668                 LDR             X9, [X9]

__text:000000010000666C                 LDR             X10, [SP,#0x30+var_18]

__text:0000000100006670                 LDR             X1, [X8] ; "addOperation:"

__text:0000000100006674                 MOV             X0, X9  ; void *

__text:0000000100006678                 MOV             X2, X10

__text:000000010000667C                 BL              _objc_msgSend

__text:0000000100006680                 ADRP            X8, #cfstr_MySampleData@PAGE ; "My Sample Data"

__text:0000000100006684                 ADD             X8, X8, #cfstr_MySampleData@PAGEOFF ; "My Sample Data"

__text:0000000100006688                 ADRP            X9, #selRef_operationWithData_@PAGE

__text:000000010000668C                 ADD             X9, X9, #selRef_operationWithData_@PAGEOFF

__text:0000000100006690                 ADRP            X10, #_OBJC_IVAR_$_Foo._operationQueue@PAGE ; NSOperationQueue *_operationQueue;

__text:0000000100006694                 ADD             X10, X10, #_OBJC_IVAR_$_Foo._operationQueue@PAGEOFF ; NSOperationQueue *_operationQueue;

__text:0000000100006698                 LDUR            X0, [X29,#var_8]

__text:000000010000669C                 LDRSW           X10, [X10] ; NSOperationQueue *_operationQueue;

__text:00000001000066A0                 ADD             X10, X0, X10

__text:00000001000066A4                 LDR             X10, [X10]

__text:00000001000066A8                 LDUR            X0, [X29,#var_8]

__text:00000001000066AC                 LDR             X1, [X9] ; "operationWithData:"

__text:00000001000066B0                 MOV             X2, X8

__text:00000001000066B4                 STR             X10, [SP,#0x30+var_20]

__text:00000001000066B8                 BL              _objc_msgSend

__text:00000001000066BC                 MOV             X29, X29

__text:00000001000066C0                 BL              _objc_retainAutoreleasedReturnValue

__text:00000001000066C4                 ADRP            X8, #selRef_addOperation_@PAGE

__text:00000001000066C8                 ADD             X8, X8, #selRef_addOperation_@PAGEOFF

__text:00000001000066CC                 LDR             X1, [X8] ; "addOperation:"

__text:00000001000066D0                 LDR             X8, [SP,#0x30+var_20]

__text:00000001000066D4                 STR             X0, [SP,#0x30+var_28]

__text:00000001000066D8                 MOV             X0, X8  ; void *

__text:00000001000066DC                 LDR             X2, [SP,#0x30+var_28]

__text:00000001000066E0                 BL              _objc_msgSend

__text:00000001000066E4                 LDR             X0, [SP,#0x30+var_28]

__text:00000001000066E8                 BL              _objc_release

__text:00000001000066EC                 ADRP            X8, #___block_literal_global.18@PAGE

__text:00000001000066F0                 ADD             X8, X8, #___block_literal_global.18@PAGEOFF

__text:00000001000066F4                 ADRP            X9, #selRef_addOperationWithBlock_@PAGE

__text:00000001000066F8                 ADD             X9, X9, #selRef_addOperationWithBlock_@PAGEOFF

__text:00000001000066FC                 ADRP            X10, #_OBJC_IVAR_$_Foo._operationQueue@PAGE ; NSOperationQueue *_operationQueue;

__text:0000000100006700                 ADD             X10, X10, #_OBJC_IVAR_$_Foo._operationQueue@PAGEOFF ; NSOperationQueue *_operationQueue;

__text:0000000100006704                 LDUR            X0, [X29,#var_8]

__text:0000000100006708                 LDRSW           X10, [X10] ; NSOperationQueue *_operationQueue;

__text:000000010000670C                 ADD             X10, X0, X10

__text:0000000100006710                 LDR             X10, [X10]

__text:0000000100006714                 LDR             X1, [X9] ; "addOperationWithBlock:"

__text:0000000100006718                 MOV             X0, X10 ; void *

__text:000000010000671C                 MOV             X2, X8

__text:0000000100006720                 BL              _objc_msgSend

__text:0000000100006724                 ADRP            X8, #___block_literal_global.24@PAGE

__text:0000000100006728                 ADD             X8, X8, #___block_literal_global.24@PAGEOFF

__text:000000010000672C                 ADRP            X9, #selRef_addExecutionBlock_@PAGE

__text:0000000100006730                 ADD             X9, X9, #selRef_addExecutionBlock_@PAGEOFF

__text:0000000100006734                 LDR             X10, [SP,#0x30+var_18]

__text:0000000100006738                 LDR             X1, [X9] ; "addExecutionBlock:"

__text:000000010000673C                 MOV             X0, X10 ; void *

__text:0000000100006740                 MOV             X2, X8

__text:0000000100006744                 BL              _objc_msgSend

__text:0000000100006748                 MOV             X8, #0

__text:000000010000674C                 ADD             X9, SP, #0x30+var_18

__text:0000000100006750                 MOV             X0, X9

__text:0000000100006754                 MOV             X1, X8

__text:0000000100006758                 BL              _objc_storeStrong

__text:000000010000675C                 LDP             X29, X30, [SP,#0x30+var_s0]

__text:0000000100006760                 ADD             SP, SP, #0x40

__text:0000000100006764                 RET

__text:0000000100006764 ; End of function -[Foo foox]

__text:0000000100006764


__text:0000000100006768

