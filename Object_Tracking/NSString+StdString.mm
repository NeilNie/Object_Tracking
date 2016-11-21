//
//  NSString+StdString.m
//  OpenCV Tutorial -- created by BloodAlex
//
//  Created By Yongyang Nie 11/20/2016
//  Copyright (c) 2016 Yongyang Nie. All rights reserved.
//  License:
//  You may not copy, redistribute, use without quoting the author.
//  By using this file, you agree to the following LICENSE:
//  https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode

#import "NSString+StdString.h"

@implementation NSString (StdString)

+ (NSString*) stringWithStdString: (const std::string&) str{
    
    return [[NSString alloc] initWithCString:str.c_str() encoding:NSASCIIStringEncoding];
}

@end
