//

//  main.m

//  singleview

//

//  Created by demo on 2018/1/12.

//  Copyright © 2018 demo. All rights reserved.

//



#import <UIKit/UIKit.h>

#import "AppDelegate.h"



@interface Car: NSObject

{
    
    NSString *blabla;
    
}

@end



@implementation Car



-(Car *) init

{
    
    self->blabla = @"blabla";
    
    return self;
    
}



@end



int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        
        Car *x = [Car new];
        
        NSString *y = [x valueForKey: @"blabla"];
        
        NSLog(@"%@", y);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}





__text:00000001000068AC                 BL              _objc_autoreleasePoolPush

__text:00000001000068B0                 ADRP            X1, #selRef_new@PAGE

__text:00000001000068B4                 ADD             X1, X1, #selRef_new@PAGEOFF

__text:00000001000068B8                 ADRP            X30, #classRef_Car@PAGE

__text:00000001000068BC                 ADD             X30, X30, #classRef_Car@PAGEOFF

__text:00000001000068C0                 LDR             X30, [X30] ; _OBJC_CLASS_$_Car

__text:00000001000068C4                 LDR             X1, [X1] ; "new"

__text:00000001000068C8                 STUR            X0, [X29,#var_28]

__text:00000001000068CC                 MOV             X0, X30 ; void *

__text:00000001000068D0                 BL              _objc_msgSend

__text:00000001000068D4                 ADRP            X1, #cfstr_Blabla_0@PAGE ; "blabla"

__text:00000001000068D8                 ADD             X1, X1, #cfstr_Blabla_0@PAGEOFF ; "blabla"

__text:00000001000068DC                 ADRP            X30, #selRef_valueForKey_@PAGE

__text:00000001000068E0                 ADD             X30, X30, #selRef_valueForKey_@PAGEOFF

__text:00000001000068E4                 STUR            X0, [X29,#var_18]

__text:00000001000068E8                 LDUR            X0, [X29,#var_18]

__text:00000001000068EC                 LDR             X30, [X30] ; "valueForKey:"

__text:00000001000068F0                 STUR            X1, [X29,#var_30]

__text:00000001000068F4                 MOV             X1, X30 ; char *

__text:00000001000068F8                 LDUR            X2, [X29,#var_30]

__text:00000001000068FC                 BL              _objc_msgSend

__text:0000000100006900                 MOV             X29, X29

__text:0000000100006904                 BL              _objc_retainAutoreleasedReturnValue

__text:0000000100006908                 STUR            X0, [X29,#var_20]

__text:000000010000690C                 LDUR            X0, [X29,#var_20]

__text:0000000100006910                 MOV             X1, SP

__text:0000000100006914                 STR             X0, [X1,#0x70+var_70]

__text:0000000100006918                 ADRP            X0, #stru_1000080A8@PAGE ; "%@"

__text:000000010000691C                 ADD             X0, X0, #stru_1000080A8@PAGEOFF ; "%@"


__text:0000000100006920                 BL              _NSLog





Although this is not a direct `field` access, we do not care for we focus on `control` access.
