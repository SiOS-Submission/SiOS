//

//  main.m

//  demo

//

//  Created by demo on 2018/1/23.

//  Copyright © 2018 demo. All rights reserved.

//



#import <UIKit/UIKit.h>

#import "AppDelegate.h"



@interface Tire: NSObject

@end



@implementation Tire

- (NSString *) description{
    
    return (@"tire");
    
}

@end



/*
 
 @interface Pedal: NSObject
 
 @end
 
 
 
 @implementation Pedal
 
 - (NSString *) description{
 
 return (@"pedal");
 
 }
 
 @end
 
 */



@interface Engine: NSObject

@end



@implementation Engine

- (NSString *) description{
    
    return (@"engine");
    
}

@end



@interface Car: NSObject{
    
    Engine *engine;
    
    Tire *tires[4];
    
}



-(Engine *) engine;

-(void) setEngine: (Engine *) newEngine;

-(Tire *) tireAtIndex: (int) index;

-(void) setTire: (Tire *) tire atIndex: (int) index;



-(void) print;

+(void) classMethodPrint;



@end



@implementation Car



+(void) classMethodPrint

{
    
    NSLog(@"null");
    
    
    
}

- (id) init

{
    
    if (self = [super init]){
        
        engine = [Engine new];
        
        tires[0] = [Tire new];
        
        tires[1] = [Tire new];
        
        tires[2] = [Tire new];
        
        tires[3] = [Tire new];
        
        
        
    }
    
    return(self);
    
    
    
}



- (void) dealloc

{
    
    NSLog(@"dealloc");
    
    
    
}



-(void) print

{
    
    NSLog(@"%@", engine);
    
    
    
    /*
     
     Remember that NSLog() lets you use the %@ format specifier to print objects. When NSLog() processes the %@ specifier, it asks the corresponding object in the parameter list for its `description`. Speaking technically, NSLog() sends the `description` message to the object, and the object’s `description` method builds an NSString and returns it. NSLog() then includes that string in its output. By supplying a description method in your class, you can customize how your objects are printed by NSLog().
     
     */
    
    
    
    NSLog(@"%@", tires[0]);
    
    NSLog(@"%@", tires[1]);
    
    NSLog(@"%@", tires[2]);
    
    NSLog(@"%@", tires[3]);
    
}



-(void) setEngine:(Engine *)newEngine

{
    
    
    
}



-(void) setTire:(Tire *)t atIndex:(int)i

{
    
    
    
}



@end



/*
 
 @interface Unicycle: NSObject
 
 {
 
 Pedal *pedal;
 
 Tire *tire;
 
 }
 
 @end
 
 */



int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        
        [Car classMethodPrint];
        
        
        
        Car *car;
        
        car = [Car new];
        
        
        
        // The `init` method creates an engine and four tires to outfit the car. When you create a new object with `new`, two steps actually happen under the hood. First, the object is `allocated`, meaning that a chunk of memory is obtained that will hold your instance variables. The `init` method is then called automatically to get the object into a workable state.
        
        
        
        
        
        /*
         
         
         
         IDA output for `new` is as below, however, the `alloc` and `init` method is invoked sequentially.
         
         
         
         
         
         _text:0000000100006948                 ADRP            X0, #selRef_new@PAGE
         
         __text:000000010000694C                 ADD             X0, X0, #selRef_new@PAGEOFF
         
         __text:0000000100006950                 ADRP            X1, #classRef_Car@PAGE
         
         __text:0000000100006954                 ADD             X1, X1, #classRef_Car@PAGEOFF
         
         __text:0000000100006958                 LDR             X1, [X1] ; _OBJC_CLASS_$_Car
         
         __text:000000010000695C                 LDR             X0, [X0] ; "new"
         
         __text:0000000100006960                 STUR            X0, [X29,#var_40]
         
         __text:0000000100006964                 MOV             X0, X1  ; void *
         
         __text:0000000100006968                 LDUR            X1, [X29,#var_40]
         
         
         __text:000000010000696C                 BL              _objc_msgSend
         
         */
        
        
        
        
        
        Car *car1;
        
        car1 = [[Car alloc] init];
        
        
        
        /*
         
         _text:0000000100006970                 ADRP            X1, #selRef_alloc@PAGE
         
         __text:0000000100006974                 ADD             X1, X1, #selRef_alloc@PAGEOFF
         
         __text:0000000100006978                 ADRP            X30, #classRef_Car@PAGE
         
         __text:000000010000697C                 ADD             X30, X30, #classRef_Car@PAGEOFF
         
         __text:0000000100006980                 STUR            X0, [X29,#var_18]
         
         __text:0000000100006984                 LDR             X0, [X30] ; _OBJC_CLASS_$_Car ; void *
         
         __text:0000000100006988                 LDR             X1, [X1] ; "alloc"
         
         __text:000000010000698C                 BL              _objc_msgSend
         
         
         
         ; although the `X0` now point to an instance, but it is the *same* as as before from the point of static view.
         
         
         
         
         
         __text:0000000100006990                 ADRP            X1, #selRef_init@PAGE
         
         __text:0000000100006994                 ADD             X1, X1, #selRef_init@PAGEOFF
         
         __text:0000000100006998                 LDR             X1, [X1] ; "init"
         
         __text:000000010000699C                 BL              _objc_msgSend
         
         __text:00000001000069A0                 ADRP            X1, #selRef_copy@PAGE
         
         __text:00000001000069A4                 ADD             X1, X1, #selRef_copy@PAGEOFF
         
         __text:00000001000069A8                 STUR            X0, [X29,#var_20]
         
         __text:00000001000069AC                 LDUR            X0, [X29,#var_20]
         
         __text:00000001000069B0                 LDR             X1, [X1] ; "copy"
         
         __text:00000001000069B4                 BL              _objc_msgSend
         
         */
        
        
        
        Car *car2 = [car1 copy];
        
        
        
        
        
        
        
        Tire *t = [Tire new];
        
        
        
        [car retain];
        
        [car release];
        
        
        
        [[car retain] setTire: t atIndex:8];
        
        [car release];
        
        [car retianCount];
        
        
        
        [car print];
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
    
}



We have checked the IDA code to find there is no obvious connection between the `caller` and `callee` for `new` to `init` or `@` to `description`.



Since `description` method commonly implement nothing `important` thing, we connect them as pleasure.




But lots of important work is implemented in `init` work, we connect the `new` selector to `init` if there is an implementation.
