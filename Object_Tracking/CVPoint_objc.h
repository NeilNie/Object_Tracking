//
//  Point.h
//  Object_Tracking
//
//  Created by Yongyang Nie on 11/15/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import <Foundation/Foundation.h>

//objectify a point.
@interface CVPoint_objc : NSObject

@property float x;
@property float y;

-(instancetype)initWithx:(float)x y:(float)y;

@end
