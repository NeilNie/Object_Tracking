//
//  SampleFacade.h
//  OpenCV Tutorial
//  Created by Neil Nie, in 10/2016
//  Referenced From BloodAxe on 8/14/12.
//
//

#import <Foundation/Foundation.h>
#import "CVPoint_objc.h"

@interface SampleFacade : NSObject

- (instancetype __nonnull) init;

- (bool)processFrame:(const cv::Mat&) inputFrame into:(cv::Mat&) outputFrame;

- (UIImage *__nonnull)processFrame:(UIImage *__nonnull) source;

- (void) setReferenceFrame:(cv::Mat&) referenceFrame;
- (void) resetReferenceFrame;

-(NSArray *__nonnull)getPoints;
-(NSArray *__nonnull)getExtremes;

@end
