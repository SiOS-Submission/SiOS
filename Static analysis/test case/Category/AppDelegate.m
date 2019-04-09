//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

// write in a file for copy / paste use.



#import <UIKit/UIKit.h>

#import "AppDelegate.h"



@interface NSString (NumberConvenience)





- (NSNumber *) lengthAsNumber;



@end



@implementation NSString (NumberConvenience)



-(NSNumber *) lengthAsNumber

{
    
    NSUInteger length = [self length];
    
    return ([NSNumber numberWithUnsignedInt:length]);
    
}



@end





int main(int argc, char * argv[]) {
    
    
    
    @autoreleasepool {
        
        
        
        
        
        NSLog(@"%@", [@"xx" lengthAsNumber]);
        
        
        
        /*
         
         __text:00000001000069C0                 ADRP            X1, #cfstr_Xx@PAGE ; "xx"
         
         __text:00000001000069C4                 ADD             X1, X1, #cfstr_Xx@PAGEOFF ; "xx"
         
         __text:00000001000069C8                 ADRP            X30, #selRef_lengthAsNumber@PAGE
         
         __text:00000001000069CC                 ADD             X30, X30, #selRef_lengthAsNumber@PAGEOFF
         
         __text:00000001000069D0                 LDR             X30, [X30] ; "lengthAsNumber"
         
         __text:00000001000069D4                 STUR            X0, [X29,#var_20]
         
         __text:00000001000069D8                 MOV             X0, X1  ; void *
         
         __text:00000001000069DC                 MOV             X1, X30 ; char *
         
         __text:00000001000069E0                 BL              _objc_msgSend
         
         
         
         
         
         send message to the `literal` instance directly. and this can work well. this is not important after all.
         
         
         
         */
        
        NSString *s = [[NSString alloc] initWithString:@"blabla"];
        
        
        
        
        
        /*
         
         
         
         __text:0000000100006A10                 ADRP            X0, #selRef_alloc@PAGE
         
         __text:0000000100006A14                 ADD             X0, X0, #selRef_alloc@PAGEOFF
         
         __text:0000000100006A18                 ADRP            X1, #classRef_NSString@PAGE
         
         __text:0000000100006A1C                 ADD             X1, X1, #classRef_NSString@PAGEOFF
         
         
         
         ; for this `selector` implemented through category, we locate the real implementation thru:
         
         ; 1. go to _OBJC_CLASS_$_NSString.
         
         ; 2. find the `reference to` from a `_category_t` structure.
         
         ; 3. the `_method_list_t` in this structure point to the method list.
         
         ; 4. visit the method list to find the `selector` and the `implementation`.
         
         
         
         
         
         ; related structure for this sample:
         
         
         
         struct _category_t {
         
         const char *name;
         
         struct _class_t *cls;
         
         const struct _method_list_t *instance_methods;
         
         const struct _method_list_t *class_methods;
         
         const struct _protocol_list_t *protocols;
         
         const struct _prop_list_t *properties;
         
         };
         
         
         
         static struct _category_t _OBJC_$_CATEGORY_NSString_$_NumberConvenience __attribute__ ((used, section ("__DATA,__objc_const"))) =
         
         {
         
         "NSString",
         
         0, // &OBJC_CLASS_$_NSString,
         
         (const struct _method_list_t *)&_OBJC_$_CATEGORY_INSTANCE_METHODS_NSString_$_NumberConvenience,
         
         0,
         
         0,
         
         0,
         
         
         };
         
         
         
         static struct /*_method_list_t*/ {
             
             unsigned int entsize;  // sizeof(struct _objc_method)
             
             unsigned int method_count;
             
             struct _objc_method method_list[1];
             
         } _OBJC_$_CATEGORY_INSTANCE_METHODS_NSString_$_NumberConvenience __attribute__ ((used, section ("__DATA,__objc_const"))) = {
             
             sizeof(_objc_method),
             
             1,
             
             {{(struct objc_selector *)"lengthAsNumber", "@16@0:8", (void *)_I_NSString_NumberConvenience_lengthAsNumber}}
             
             
         };
        
        
        
        
        
        struct _objc_method {
            
            struct objc_selector * _cmd;
            
            const char *method_type;
            
            void  *_imp;
            
            
        };
        
        
        
        
        
        
        
    __text:0000000100006A20                 LDR             X1, [X1] ; _OBJC_CLASS_$_NSString
        
    __text:0000000100006A24                 LDR             X0, [X0] ; "alloc"
        
    __text:0000000100006A28                 STUR            X0, [X29,#var_30]
        
    __text:0000000100006A2C                 MOV             X0, X1  ; void *
        
    __text:0000000100006A30                 LDUR            X1, [X29,#var_30]
        
    __text:0000000100006A34                 BL              _objc_msgSend
        
        
        
        ; function abstraction to bridge `X0`
        
        
        
    __text:0000000100006A38                 ADRP            X1, #cfstr_Blabla@PAGE ; "blabla"
        
    __text:0000000100006A3C                 ADD             X1, X1, #cfstr_Blabla@PAGEOFF ; "blabla"
        
    __text:0000000100006A40                 ADRP            X30, #selRef_initWithString_@PAGE
        
    __text:0000000100006A44                 ADD             X30, X30, #selRef_initWithString_@PAGEOFF
        
    __text:0000000100006A48                 LDR             X30, [X30] ; "initWithString:"
        
    __text:0000000100006A4C                 STUR            X1, [X29,#var_38]
        
    __text:0000000100006A50                 MOV             X1, X30 ; char *
        
    __text:0000000100006A54                 LDUR            X2, [X29,#var_38]
        
    __text:0000000100006A58                 BL              _objc_msgSend
        
        
        
        ; function abstraction to bridge `X0`
        
        
        
    __text:0000000100006A5C                 ADRP            X1, #selRef_lengthAsNumber@PAGE
        
    __text:0000000100006A60                 ADD             X1, X1, #selRef_lengthAsNumber@PAGEOFF
        
    __text:0000000100006A64                 STUR            X0, [X29,#var_18]
        
    __text:0000000100006A68                 LDUR            X0, [X29,#var_18]
        
    __text:0000000100006A6C                 LDR             X1, [X1] ; "lengthAsNumber"
        
        
    __text:0000000100006A70                 BL              _objc_msgSend
        
        
        
        */
        
        NSLog(@"%@", [s lengthAsNumber]);
        
        
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}





