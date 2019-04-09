//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

// case comes from Learn.Objective-C.on.the.Mac.2nd.Edition, Section 4



//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

//



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



@interface Shape: NSObject{
    
    ShapeColor fillColor;
    
    ShapeRect bounds;
    
}

-(void) setFillColor: (ShapeColor) fillColor;

-(void) setBounds: (ShapeRect) bounds;

-(void) draw;

@end



@implementation Shape



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
    
    
    
}



@end





@interface Circle : Shape

@end





@implementation Circle



- (void)setFillColor:(ShapeColor)c

{
    
    ShapeColor mc = c;
    
    if ( c == kRedColor)
        
    {
        
        mc = kGreenColor;
        
    }
    
    
    
    [super setFillColor: mc];
    
}



-(void)draw

{
    
    NSLog(@"Circle");
    
}



@end



@interface Rectangle : Shape

@end





@implementation Rectangle



-(void)draw

{
    
    NSLog(@"Rectangle");
    
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
        
        
        
        ShapeRect rect1 = {0, 0, 10, 30};
        
        shapes[1] = [Rectangle new];
        
        [(Rectangle *)shapes[1] setBounds: rect1];
        
        [(Rectangle *)shapes[1] setFillColor: kRedColor];
        
        
        
        drawShapes (shapes, 2);
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}



IDA output for:



- (void)setFillColor:(ShapeColor)c

{
    
    ShapeColor mc = c;
    
    if ( c == kRedColor)
        
    {
        
        mc = kGreenColor;
        
    }
    
    
    
    [super setFillColor: mc];
    
}



__text:0000000100006754 ; void __cdecl -[Circle setFillColor:](Circle *self, SEL, int)

__text:0000000100006754 __Circle_setFillColor__                 ; DATA XREF: __objc_const:0000000100008E50↓o

__text:0000000100006754

__text:0000000100006754 var_28          = -0x28

__text:0000000100006754 var_20          = -0x20

__text:0000000100006754 var_18          = -0x18

__text:0000000100006754 var_14          = -0x14

__text:0000000100006754 var_10          = -0x10

__text:0000000100006754 var_8           = -8

__text:0000000100006754 var_s0          =  0

__text:0000000100006754

__text:0000000100006754                 SUB             SP, SP, #0x40

__text:0000000100006758                 STP             X29, X30, [SP,#0x30+var_s0]

__text:000000010000675C                 ADD             X29, SP, #0x30

__text:0000000100006760                 STUR            X0, [X29,#var_8]

__text:0000000100006764                 STUR            X1, [X29,#var_10]

__text:0000000100006768                 STUR            W2, [X29,#var_14]

__text:000000010000676C                 LDUR            W2, [X29,#var_14]

__text:0000000100006770                 STR             W2, [SP,#0x30+var_18]

__text:0000000100006774                 LDUR            W2, [X29,#var_14]

__text:0000000100006778                 CBNZ            W2, loc_100006784

__text:000000010000677C                 MOV             W8, #1

__text:0000000100006780                 STR             W8, [SP,#0x30+var_18]

__text:0000000100006784

__text:0000000100006784 loc_100006784                           ; CODE XREF: -[Circle setFillColor:]+24↑j

__text:0000000100006784                 ADD             X0, SP, #0x30+var_28

__text:0000000100006788                 ADRP            X8, #selRef_setFillColor_@PAGE

__text:000000010000678C                 ADD             X8, X8, #selRef_setFillColor_@PAGEOFF

__text:0000000100006790                 ADRP            X9, #classRef_Circle_0@PAGE

__text:0000000100006794                 ADD             X9, X9, #classRef_Circle_0@PAGEOFF

__text:0000000100006798                 LDUR            X10, [X29,#var_8]

__text:000000010000679C                 LDR             W2, [SP,#0x30+var_18]

__text:00000001000067A0                 STR             X10, [SP,#0x30+var_28]

__text:00000001000067A4                 LDR             X9, [X9] ; _OBJC_CLASS_$_Circle

__text:00000001000067A8                 STR             X9, [SP,#0x30+var_20]

__text:00000001000067AC                 LDR             X1, [X8] ; "setFillColor:"

__text:00000001000067B0                 BL              _objc_msgSendSuper2



; for _objc_msgSendSuper2, `X0` point to `self`, and we can find the implementation of the method from this information. In practice, we do not care the real value of `X0`, but search the inheritance of this class to get the real implementation of this method.



__text:00000001000067B4                 LDP             X29, X30, [SP,#0x30+var_s0]

__text:00000001000067B8                 ADD             SP, SP, #0x40


__text:00000001000067BC                 RET



