//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

//



#import <UIKit/UIKit.h>

#import "AppDelegate.h"



@interface ITunesFinder: NSObject <NSNetServiceBrowserDelegate>

@end



@implementation ITunesFinder



-(void) netServiceBrowser: (NSNetServiceBrowser *) b didFindService: (NSNetService *) service moreComing: (BOOL) moreComing

{
    
    [service resolveWithTimeout: 10];
    
    
    
}



-(void) netServiceBrowser: (NSNetServiceBrowser *) b didRemoveService:(NSNetService *) service moreComing: (BOOL)moreComing

{
    
    [service resolveWithTimeout: 10];
    
}

@end



int main(int argc, char * argv[]) {
    
    
    
    @autoreleasepool {
        
        
        
        NSNetServiceBrowser *browser = [[NSNetServiceBrowser alloc] init];
        
        ITunesFinder *finder = [[ITunesFinder alloc] init];
        
        
        
        
        
        [browser setDelegate: finder];
        
        
        
        /*
         
         There is no obviously signature indicate that the `ITunesFinder` is a delegator, except the selector `setDelegate`. In order to complete the call graph, we have to get the `X2` argument to find the class object and connect all methods in this `category` to the `setDelegate`  method. However this is not a reasonable solution.
         
         
         
         __text:00000001000067B4                 ADD             X1, X1, #selRef_alloc@PAGEOFF
         
         __text:00000001000067B8                 ADRP            X30, #classRef_ITunesFinder@PAGE
         
         __text:00000001000067BC                 ADD             X30, X30, #classRef_ITunesFinder@PAGEOFF
         
         __text:00000001000067C0                 STUR            X0, [X29,#var_18]
         
         __text:00000001000067C4                 LDR             X0, [X30] ; _OBJC_CLASS_$_ITunesFinder ; void *
         
         __text:00000001000067C8                 LDR             X1, [X1] ; "alloc"
         
         __text:00000001000067CC                 BL              _objc_msgSend
         
         __text:00000001000067D0                 ADRP            X1, #selRef_init@PAGE
         
         __text:00000001000067D4                 ADD             X1, X1, #selRef_init@PAGEOFF
         
         __text:00000001000067D8                 LDR             X1, [X1] ; "init"
         
         __text:00000001000067DC                 BL              _objc_msgSend
         
         __text:00000001000067E0                 ADRP            X1, #selRef_setDelegate_@PAGE
         
         __text:00000001000067E4                 ADD             X1, X1, #selRef_setDelegate_@PAGEOFF
         
         __text:00000001000067E8                 STUR            X0, [X29,#var_20]
         
         __text:00000001000067EC                 LDUR            X0, [X29,#var_18]
         
         __text:00000001000067F0                 LDUR            X30, [X29,#var_20]
         
         __text:00000001000067F4                 LDR             X1, [X1] ; "setDelegate:"
         
         __text:00000001000067F8                 MOV             X2, X30
         
         __text:00000001000067FC                 BL              _objc_msgSend
         
         
         
         
         
         classRef_ITunesFinder tracing:
         
         
         
         __objc_data:0000000100009020 _OBJC_CLASS_$_ITunesFinder __objc2_class <_OBJC_METACLASS_$_ITunesFinder, _OBJC_CLASS_$_NSObject,\
         
         __objc_data:0000000100009020                                         ; DATA XREF: _main+64↑o
         
         __objc_data:0000000100009020                                         ; __objc_classlist:00000001000080A8↑o ...
         
         
         __objc_data:0000000100009020                                __objc_empty_cache, 0, ITunesFinder_$classData>
         
         
         
         
         
         __objc_const:0000000100008E90 ITunesFinder_$classData __objc2_class_ro <0x80, 8, 8, 0, 0, aItunesfinder, \
         
         __objc_const:0000000100008E90                                         ; DATA XREF: __objc_data:_OBJC_CLASS_$_ITunesFinder↓o
         
         __objc_const:0000000100008E90                                   _OBJC_INSTANCE_METHODS_ITunesFinder, \ ; "ITunesFinder"
         
         __objc_const:0000000100008E90                                   ITunesFinder_$prots, 0, 0, ITunesFinder_$properties>
         
         
         
         
         
         __objc_const:0000000100008E10 _OBJC_INSTANCE_METHODS_ITunesFinder __objc2_meth_list <0x18, 2>
         
         __objc_const:0000000100008E10                                         ; DATA XREF: __objc_const:ITunesFinder_$classData↓o
         
         __objc_const:0000000100008E18                 __objc2_meth <sel_netServiceBrowser_didFindService_moreComing_, \ ; -[ITunesFinder netServiceBrowser:didFindService:moreComing:] ...
         
         __objc_const:0000000100008E18                               aV36081624b32, \
         
         __objc_const:0000000100008E18                               __ITunesFinder_netServiceBrowser_didFindService_moreComing__>
         
         __objc_const:0000000100008E30                 __objc2_meth <sel_netServiceBrowser_didRemoveService_moreComing_, \ ; -[ITunesFinder netServiceBrowser:didRemoveService:moreComing:] ...
         
         __objc_const:0000000100008E30                               aV36081624b32, \
         
         __objc_const:0000000100008E30                               __ITunesFinder_netServiceBrowser_didRemoveService_moreComing__>
         
         
         
         
         */
        
        [browser searchForServicesOfType: @"_daap._tcp" inDomain: @"local."];
        
        
        
        [[NSRunLoop currentRunLoop] run];
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}
