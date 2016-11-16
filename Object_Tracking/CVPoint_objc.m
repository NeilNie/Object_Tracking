//
//  Point.m
//  Object_Tracking
//
//  Created by Yongyang Nie on 11/15/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import "CVPoint_objc.h"

@implementation CVPoint_objc

-(instancetype)initWithx:(float)x y:(float)y{
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}

@end
