NSString *autoreleaseString;

autoreleaseString = [[NSString alloc] initWithString:@"blabla"];

[autoreleaseString autorelease];

[autoreleaseString stringByAppendingString: @"blabla"];







__text:000000010000685C                 STUR            X1, [X29,#var_10]

__text:0000000100006860                 BL              _objc_autoreleasePoolPush

__text:0000000100006864                 ADRP            X1, #selRef_alloc@PAGE

__text:0000000100006868                 ADD             X1, X1, #selRef_alloc@PAGEOFF

__text:000000010000686C                 ADRP            X30, #classRef_NSString@PAGE

__text:0000000100006870                 ADD             X30, X30, #classRef_NSString@PAGEOFF

__text:0000000100006874                 LDR             X30, [X30] ; _OBJC_CLASS_$_NSString

__text:0000000100006878                 LDR             X1, [X1] ; "alloc"

__text:000000010000687C                 STUR            X0, [X29,#var_40]

__text:0000000100006880                 MOV             X0, X30 ; void *

__text:0000000100006884                 BL              _objc_msgSend



; next `X0` may pollute by this `_objc_msgSend`, but it isn't



__text:0000000100006888                 ADRP            X1, #cfstr_Blabla@PAGE ; "blabla"

__text:000000010000688C                 ADD             X1, X1, #cfstr_Blabla@PAGEOFF ; "blabla"

__text:0000000100006890                 ADRP            X30, #selRef_initWithString_@PAGE

__text:0000000100006894                 ADD             X30, X30, #selRef_initWithString_@PAGEOFF

__text:0000000100006898                 LDR             X30, [X30] ; "initWithString:"

__text:000000010000689C                 STUR            X1, [X29,#var_48]

__text:00000001000068A0                 MOV             X1, X30 ; char *

__text:00000001000068A4                 LDUR            X2, [X29,#var_48]

__text:00000001000068A8                 BL              _objc_msgSend



; next `X0` may pollute by this `_objc_msgSend`, but it isn't



__text:00000001000068AC                 ADRP            X1, #selRef_autorelease@PAGE

__text:00000001000068B0                 ADD             X1, X1, #selRef_autorelease@PAGEOFF

__text:00000001000068B4                 STUR            X0, [X29,#var_18]

__text:00000001000068B8                 LDUR            X0, [X29,#var_18]

__text:00000001000068BC                 LDR             X1, [X1] ; "autorelease"


__text:00000001000068C0                 BL              _objc_msgSend





