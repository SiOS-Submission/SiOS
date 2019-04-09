//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

//



#import <UIKit/UIKit.h>

#import "AppDelegate.h"



@protocol WorkerProtocol <NSObject>

@optional

- (void)doSomeOptionalWork;



@required

- (void)doSomeRequiredWork;

@end



@interface Manager : NSObject

@property (weak) id <WorkerProtocol> delegate;



- (void)doWork;

@end





@interface Manager ()

- (void)myWork;

@end



@implementation Manager

@synthesize delegate;



/*
 
 __text:00000001000066D4 ; WorkerProtocol *__cdecl -[Manager delegate](Manager *self, SEL)
 
 __text:00000001000066D4 __Manager_delegate_                     ; DATA XREF: __objc_const:0000000100008DC0↓o
 
 __text:00000001000066D4
 
 __text:00000001000066D4 var_10          = -0x10
 
 __text:00000001000066D4 var_8           = -8
 
 __text:00000001000066D4 var_s0          =  0
 
 __text:00000001000066D4
 
 __text:00000001000066D4 ; FUNCTION CHUNK AT __stubs:0000000100006A5C SIZE 0000000C BYTES
 
 __text:00000001000066D4
 
 __text:00000001000066D4                 SUB             SP, SP, #0x20
 
 __text:00000001000066D8                 STP             X29, X30, [SP,#0x10+var_s0]
 
 __text:00000001000066DC                 ADD             X29, SP, #0x10
 
 __text:00000001000066E0                 STR             X0, [SP,#0x10+var_8]
 
 __text:00000001000066E4                 STR             X1, [SP,#0x10+var_10]
 
 __text:00000001000066E8                 LDR             X0, [SP,#0x10+var_8]
 
 __text:00000001000066EC                 ADRP            X1, #_OBJC_IVAR_$_Manager.delegate@PAGE ; WorkerProtocol *delegate;
 
 __text:00000001000066F0                 LDRSW           X1, [X1,#_OBJC_IVAR_$_Manager.delegate@PAGEOFF] ; WorkerProtocol *delegate;
 
 __text:00000001000066F4                 ADD             X0, X0, X1
 
 __text:00000001000066F8                 BL              _objc_loadWeakRetained
 
 __text:00000001000066FC                 LDP             X29, X30, [SP,#0x10+var_s0]
 
 __text:0000000100006700                 ADD             SP, SP, #0x20
 
 __text:0000000100006704                 B               _objc_autoreleaseReturnValue
 
 __text:0000000100006704 ; End of function -[Manager delegate]
 
 __text:0000000100006704
 
 __text:0000000100006708
 
 __text:0000000100006708 ; =============== S U B R O U T I N E =======================================
 
 __text:0000000100006708
 
 __text:0000000100006708 ; Attributes: bp-based frame
 
 __text:0000000100006708
 
 __text:0000000100006708 ; void __cdecl -[Manager setDelegate:](Manager *self, SEL, id)
 
 __text:0000000100006708 __Manager_setDelegate__                 ; DATA XREF: __objc_const:0000000100008DD8↓o
 
 __text:0000000100006708
 
 __text:0000000100006708 var_20          = -0x20
 
 __text:0000000100006708 var_18          = -0x18
 
 __text:0000000100006708 var_10          = -0x10
 
 __text:0000000100006708 var_8           = -8
 
 __text:0000000100006708 var_s0          =  0
 
 __text:0000000100006708
 
 __text:0000000100006708                 SUB             SP, SP, #0x30
 
 __text:000000010000670C                 STP             X29, X30, [SP,#0x20+var_s0]
 
 __text:0000000100006710                 ADD             X29, SP, #0x20
 
 __text:0000000100006714                 ADRP            X8, #_OBJC_IVAR_$_Manager.delegate@PAGE ; WorkerProtocol *delegate;
 
 __text:0000000100006718                 ADD             X8, X8, #_OBJC_IVAR_$_Manager.delegate@PAGEOFF ; WorkerProtocol *delegate;
 
 __text:000000010000671C                 STUR            X0, [X29,#var_8]
 
 __text:0000000100006720                 STR             X1, [SP,#0x20+var_10]
 
 __text:0000000100006724                 STR             X2, [SP,#0x20+var_18]
 
 __text:0000000100006728                 LDR             X1, [SP,#0x20+var_18]
 
 __text:000000010000672C                 LDUR            X0, [X29,#var_8]
 
 __text:0000000100006730                 LDRSW           X8, [X8] ; WorkerProtocol *delegate;
 
 __text:0000000100006734                 ADD             X8, X0, X8
 
 __text:0000000100006738                 MOV             X0, X8
 
 __text:000000010000673C                 BL              _objc_storeWeak
 
 __text:0000000100006740                 STR             X0, [SP,#0x20+var_20]
 
 __text:0000000100006744                 LDP             X29, X30, [SP,#0x20+var_s0]
 
 __text:0000000100006748                 ADD             SP, SP, #0x30
 
 __text:000000010000674C                 RET
 
 __text:000000010000674C ; End of function -[Manager setDelegate:]
 
 */



- (void)doWork

{
    
    
    
    
    // since our analysis is context insensitive, we do not know what `delegate` really point to.
    
    // and till now, I have no idea how much this property will affect on our analysis.
    
    
    
    [delegate doSomeRequiredWork];
    
    
    
    /*
     
     I can link all possible implementation of the delegate method, however, there is no information indicate which class obey the `protocol`, so aggressive link on literal name may work.
     
     */
    
    
    
    if(YES == [delegate respondsToSelector:@selector(doSomeOptionalWork)])
        
    {
        
        [delegate doSomeOptionalWork];
        
    }
    
    
    
    [self myWork];
    
}



- (void)myWork;

{
    
    NSLog(@"I am a manager and I am working");
    
}

@end



@interface Worker1 : NSObject <WorkerProtocol>



@end





@implementation Worker1

- (void)doSomeRequiredWork

{
    
    NSLog(@"Worker1 doing required work.");
    
}

@end



@interface Worker2 : NSObject <WorkerProtocol>



@end



@implementation Worker2



- (void)doSomeRequiredWork

{
    
    NSLog(@"Worker2 doing required work.");
    
}



- (void)doSomeOptionalWork

{
    
    NSLog(@"Worker2 doing optional work.");
    
}

@end



int main(int argc, char * argv[]) {
    
    
    
    @autoreleasepool {
        
        
        
        Manager *manager = [[Manager alloc] init];
        
        Worker1 *worker1 = [[Worker1 alloc] init];
        
        manager.delegate = worker1;
        
        
        
        /*
         
         __text:0000000100006890                 ADRP            X1, #selRef_setDelegate_@PAGE
         
         __text:0000000100006894                 ADD             X1, X1, #selRef_setDelegate_@PAGEOFF
         
         __text:0000000100006898                 STUR            X0, [X29,#var_20]
         
         __text:000000010000689C                 LDUR            X0, [X29,#var_18]
         
         __text:00000001000068A0                 LDUR            X30, [X29,#var_20]
         
         __text:00000001000068A4                 LDR             X1, [X1] ; "setDelegate:"
         
         __text:00000001000068A8                 MOV             X2, X30
         
         
         __text:00000001000068AC                 BL              _objc_msgSend
         
         */
        
        
        
        [manager doWork];
        
        
        
        Worker2 *worker2 = [[Worker2 alloc] init];
        
        manager.delegate = worker2;
        
        
        
        
        
        [manager doWork];
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}
