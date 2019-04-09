//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

//  case comes from Learn.Objective-C.on.the.Mac.2nd.Edition, Section 3



#import <UIKit/UIKit.h>

#import "AppDelegate.h"



typedef enum{
    
    kCircle,
    
    kRectangle,
    
    kEgg
    
} ShapeType;



typedef enum{
    
    kRedColor,
    
    kGreenColor,
    
    kBlueColor
    
} ShapeColor;



typedef struct {
    
    int x, y, width, height;
    
}ShapeRect;



@interface Circle : NSObject

{
    
@private
    
    ShapeColor fillColor;
    
    ShapeRect bounds;
    
    
    
}



-(void) setFillColor: (ShapeColor) fillColor;

-(void) setBounds: (ShapeRect) bounds;

-(void) draw;

@end



@implementation Circle



-(void) setFillColor:(ShapeColor)c

{
    
    fillColor = c;
    
}



-(void) setBounds: (ShapeRect)b

{
    
    bounds = b;
    
}



-(void)draw

{
    
    NSLog(@"circle");
    
}



@end



void drawShapes(__strong id shapes[], int count)

{
    
    for ( int i = 0; i < count; i ++)
        
    {
        
        id shape = shapes[i];
        
        [shape draw];
        
    }
    
}



int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        
        
        
        id shapes[3];
        
        ShapeRect rect0 = {0, 0, 10, 30};
        
        shapes[0] = [Circle new];
        
        [(Circle *)shapes[0] setBounds: rect0];
        
        [(Circle *)shapes[0] setFillColor: kRedColor];
        
        
        
        drawShapes (shapes, 1);
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}





IDA output for:

shapes[0] = [Circle new];


[(Circle *)shapes[0] setBounds: rect0];





__text:0000000100006970                 STUR            Q0, [X29,#var_40]

__text:0000000100006974                 ADRP            X8, #classRef_Circle@PAGE

__text:0000000100006978                 LDR             X8, [X8,#classRef_Circle@PAGEOFF]

__text:000000010000697C                 ADRP            X1, #selRef_new@PAGE

__text:0000000100006980                 LDR             X1, [X1,#selRef_new@PAGEOFF] ; char *

__text:0000000100006984                 STR             X0, [SP,#0x90+var_48]

__text:0000000100006988                 MOV             X0, X8  ; void *

__text:000000010000698C                 BL              _objc_msgSend



;for the `new` selector, `X0` is the class object, after this invocation, we get a pointer in `X0` point to an instance of the class. Although we consider the `X0` register is easily polluted by an invocation, this case should be ignored. So, in practice, we just simply patch this method invocation with `mov X0, X0’ instruction to make the object searching process smoothly.



__text:0000000100006990                 LDUR            X8, [X29,#var_20]

__text:0000000100006994                 STUR            X0, [X29,#var_20]

__text:0000000100006998                 MOV             X0, X8

__text:000000010000699C                 BL              _objc_release

__text:00000001000069A0                 LDUR            X8, [X29,#var_20]

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





IDA output for:

void drawShapes(__strong id shapes[], int count)

{
    
    for ( int i = 0; i < count; i ++)
        
    {
        
        id shape = shapes[i];
        
        [shape draw];
        
    }
    
}





__text:000000010000689C                 EXPORT _drawShapes

__text:000000010000689C _drawShapes                             ; CODE XREF: _main+D4↓p

__text:000000010000689C

__text:000000010000689C var_18          = -0x18

__text:000000010000689C var_10          = -0x10

__text:000000010000689C var_C           = -0xC

__text:000000010000689C var_8           = -8

__text:000000010000689C var_s0          =  0

__text:000000010000689C

__text:000000010000689C                 SUB             SP, SP, #0x30

__text:00000001000068A0                 STP             X29, X30, [SP,#0x20+var_s0]

__text:00000001000068A4                 ADD             X29, SP, #0x20

__text:00000001000068A8                 STUR            X0, [X29,#var_8]

__text:00000001000068AC                 STUR            W1, [X29,#var_C]

__text:00000001000068B0                 STR             WZR, [SP,#0x20+var_10]

__text:00000001000068B4

__text:00000001000068B4 loc_1000068B4                           ; CODE XREF: _drawShapes+78↓j

__text:00000001000068B4                 LDR             W8, [SP,#0x20+var_10]

__text:00000001000068B8                 LDUR            W9, [X29,#var_C]

__text:00000001000068BC                 CMP             W8, W9

__text:00000001000068C0                 B.GE            loc_100006918

__text:00000001000068C4                 LDRSW           X8, [SP,#0x20+var_10]

__text:00000001000068C8                 LDUR            X9, [X29,#var_8]

__text:00000001000068CC                 MOV             X10, #8

__text:00000001000068D0                 MADD            X8, X8, X10, XZR

__text:00000001000068D4                 ADD             X8, X9, X8

__text:00000001000068D8                 LDR             X0, [X8]

__text:00000001000068DC                 BL              _objc_retain

__text:00000001000068E0                 ADRP            X8, #selRef_draw@PAGE

__text:00000001000068E4                 ADD             X8, X8, #selRef_draw@PAGEOFF

__text:00000001000068E8                 STR             X0, [SP,#0x20+var_18]

__text:00000001000068EC                 LDR             X0, [SP,#0x20+var_18] ; void *



; `receiver` comes from stack, so we will make a aggressive predict for the `receiver`, which means that any `receiver` with the same `selector` will be called. and this is what the code block really did.



__text:00000001000068F0                 LDR             X1, [X8] ; "draw"

__text:00000001000068F4                 BL              _objc_msgSend

__text:00000001000068F8                 ADD             X0, SP, #0x20+var_18

__text:00000001000068FC                 MOV             X8, #0

__text:0000000100006900                 MOV             X1, X8

__text:0000000100006904                 BL              _objc_storeStrong

__text:0000000100006908                 LDR             W8, [SP,#0x20+var_10]

__text:000000010000690C                 ADD             W8, W8, #1

__text:0000000100006910                 STR             W8, [SP,#0x20+var_10]

__text:0000000100006914                 B               loc_1000068B4

__text:0000000100006918 ; ---------------------------------------------------------------------------

__text:0000000100006918

__text:0000000100006918 loc_100006918                           ; CODE XREF: _drawShapes+24↑j

__text:0000000100006918                 LDP             X29, X30, [SP,#0x20+var_s0]

__text:000000010000691C                 ADD             SP, SP, #0x30

__text:0000000100006920                 RET


__text:0000000100006920 ; End of function _drawShapes





