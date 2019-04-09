//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

// case comes from Learn.Objective-C.on.the.Mac.2nd.Edition, Section 4



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



ShapeRect rect0 = {0, 0, 10, 30};

shapes[0] = [Circle new];

[(Circle *)shapes[0] setBounds: rect0];

[(Circle *)shapes[0] setFillColor: kRedColor];



ShapeRect rect1 = {0, 0, 10, 30};

shapes[1] = [Rectangle new];

[(Rectangle *)shapes[1] setBounds: rect1];

[(Rectangle *)shapes[1] setFillColor: kRedColor];





__text:00000001000068F4                 ADRP            X8, #classRef_Circle@PAGE

__text:00000001000068F8                 LDR             X8, [X8,#classRef_Circle@PAGEOFF]

__text:00000001000068FC                 ADRP            X1, #selRef_new@PAGE

__text:0000000100006900                 LDR             X30, [X1,#selRef_new@PAGEOFF]



;    ea_cur = 0x0000000100006900


;    print hex(idc.GetOperandValue(ea_cur, 1))

; displacement = 0xf78L



__text:0000000100006904                 STR             X0, [SP,#0xB0+var_60]

__text:0000000100006908                 MOV             X0, X8  ; void *

__text:000000010000690C                 STR             X1, [SP,#0xB0+var_68]

; preserved address of the page without offset

__text:0000000100006910                 MOV             X1, X30 ; char *

__text:0000000100006914                 BL              _objc_msgSend

__text:0000000100006918                 LDUR            X8, [X29,#var_20]

__text:000000010000691C                 STUR            X0, [X29,#var_20]

__text:0000000100006920                 MOV             X0, X8

__text:0000000100006924                 BL              _objc_release

__text:0000000100006928                 LDUR            X0, [X29,#var_20]

__text:000000010000692C                 ADRP            X8, #selRef_setBounds_@PAGE

__text:0000000100006930                 LDR             X1, [X8,#selRef_setBounds_@PAGEOFF] ; char *

__text:0000000100006934                 LDUR            X3, [X29,#var_40+8]

__text:0000000100006938                 LDUR            X2, [X29,#var_40]

__text:000000010000693C                 STR             X8, [SP,#0xB0+var_70]

__text:0000000100006940                 BL              _objc_msgSend


; analysis result: [ Circle setBounds_ ]

; However, there is no implementation in `Circle` class object, so, we need class hierarchy to find the real implementation of this method.

; this process simulate `the Objective-C method dispatcher` work to searches for the method in the current class. If the dispatcher doesn’t find the method in the class of the object receiving the message, it looks at the object’s superclasses.


; __objc_const:0000000100008E48 _OBJC_INSTANCE_METHODS_Circle __objc2_meth_list <0x18, 1>

; __objc_const:0000000100008E48                                         ; DATA XREF: __objc_const:Circle_$classData↓o



; __objc_const:0000000100008E50                 __objc2_meth <sel_draw, aV1608, __Circle_draw_> ; -[Circle draw] ...


the _class_t (prefix with `_OBJC_CLASS_`) structure defined the super class of this class.


; __objc_data:00000001000090E0 _OBJC_CLASS_$_Circle __objc2_class <_OBJC_METACLASS_$_Circle, _OBJC_CLASS_$_Shape, \

; __objc_data:00000001000090E0                                         ; DATA XREF: __objc_classlist:00000001000080D0↑o

; __objc_data:00000001000090E0                                         ; __objc_classrefs:classRef_Circle↑o



; __objc_data:00000001000090E0                                __objc_empty_cache, 0, Circle_$classData>



__text:0000000100006944                 LDUR            X0, [X29,#var_20]

__text:0000000100006948                 ADRP            X8, #selRef_setFillColor_@PAGE

__text:000000010000694C                 LDR             X1, [X8,#selRef_setFillColor_@PAGEOFF] ; char *

__text:0000000100006950                 LDUR            W2, [X29,#var_54]

__text:0000000100006954                 BL              _objc_msgSend

__text:0000000100006958                 ADRP            X8, #xmmword_100007F80@PAGE

__text:000000010000695C                 ADD             X8, X8, #xmmword_100007F80@PAGEOFF

__text:0000000100006960                 LDR             Q0, [X8]

__text:0000000100006964                 STUR            Q0, [X29,#var_50]

__text:0000000100006968                 ADRP            X8, #classRef_Rectangle@PAGE

__text:000000010000696C                 LDR             X0, [X8,#classRef_Rectangle@PAGEOFF] ; void *

__text:0000000100006970                 LDR             X8, [SP,#0xB0+var_68]

; loads a doubleword from memory preserved page address

__text:0000000100006974                 LDR             X1, [X8,#0xF78] ; char *




;    ea_cur = 0x0000000100006974


;    print hex(idc.GetOperandValue(ea_cur, 1))



; displacement = 0xf78L



; `X0` now point to `new` selector. but IDA can not process this case well, so we failed to get the `selector`.

__text:0000000100006978                 BL              _objc_msgSend

__text:000000010000697C                 LDUR            X8, [X29,#var_18]

__text:0000000100006980                 STUR            X0, [X29,#var_18]

__text:0000000100006984                 MOV             X0, X8

__text:0000000100006988                 BL              _objc_release

__text:000000010000698C                 LDUR            X8, [X29,#var_18]

__text:0000000100006990                 LDR             X0, [SP,#0xB0+var_70]

__text:0000000100006994                 LDR             X1, [X0,#0xF80] ; char *

__text:0000000100006998                 LDUR            X3, [X29,#var_50+8]

__text:000000010000699C                 LDUR            X30, [X29,#var_50]

__text:00000001000069A0                 MOV             X0, X8  ; void *

__text:00000001000069A4                 MOV             X2, X30

__text:00000001000069A8                 BL              _objc_msgSend

__text:00000001000069AC                 MOV             W9, #0

__text:00000001000069B0                 ADRP            X8, #selRef_setFillColor_@PAGE

__text:00000001000069B4                 ADD             X8, X8, #selRef_setFillColor_@PAGEOFF

__text:00000001000069B8                 LDUR            X0, [X29,#var_18]

__text:00000001000069BC                 LDR             X1, [X8] ; "setFillColor:"

__text:00000001000069C0                 MOV             X2, X9

__text:00000001000069C4                 BL              _objc_msgSend

__text:00000001000069C8                 MOV             W1, #2

__text:00000001000069CC                 SUB             X0, X29, #-var_20


__text:00000001000069D0                 BL              _drawShapes





