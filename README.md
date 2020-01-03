# SiOS

Dataset and scripts for our paper.

## Dynamic analysis/MobileSubstrate Tweak/binddetours: 
Dynamic analysis module for analyzing the network service in iOS app on the fly.
## Dynamic analysis/top 1300 analysis result: 
Result of dynamic analysis for top 1300 apps.

## Static analysis/IDAPython: 
IDA plugins, static analysis module for building call hierarchy and object reference graph.
## Static analysis/test case: 
Objective-C peculiarities, including Blocks, Category, Delegate, etc.

## Data analysis/tablesheetandgraph_library_raw_data.py: 
Query for official/thrid-party network serivce provider library in our iOS app collection. 
## Data analysis/lib_dist:
Static analysis result of network service library in iOS app.
## Data analysis/call stack analysis/
Weighted edit distance script based on result of dynamic analysis result.

## GCDWebServerStud:
Static script for analyzing the third-party network service library GCDWebServer.

## SiOS/Misc/ObfsStud
A survey on iOS app obfuscation.

## PoC (Prove of Concept)
Script for attacking waze, qqbrowser, now, etc.

## Our dataflow analyzer includes:
1. We mitigate original framework to Ubuntu.  
2. We supplement the new ARM instructions to the LLVM based disassembler module Dagger. Moreover, as the IR of a moderate app will always consume gigabytes of memory, some instructions are simplified to shrink the memory usage, such as removing bitwise binary operations. 
3. We model complex objects (eg, NSDictionary) and perform analysis on them.  
4. We convert inter-procedural data-flow analysis to on-demand inter-procedural since the inter-procedural analysis always takes days to analyze a moderate binary. We only analyze the function enclosing the reference to the expected class object name or method name of a third-party library.  

Access the framework via: https://github.com/pwnzen-mobile  
