//
//  SampleFacade.h
//  OpenCV Tutorial
//
//  Created by BloodAxe on 8/14/12.
//
//

#import <Foundation/Foundation.h>
#import "SampleBase.h"

//typedef std::map<std::string> OptionsMap;

@interface SampleFacade : NSObject

- (id) init;

- (NSString *) title;
- (NSString *) description;
- (NSString *) friendlyName;

- (bool)processFrame:(const cv::Mat&) inputFrame into:(cv::Mat&) outputFrame;

- (UIImage*)processFrame:(UIImage*) source;

@property (getter = getIsReferenceFrameRequired, readonly) bool isReferenceFrameRequired;

- (void) setReferenceFrame:(cv::Mat&) referenceFrame;
- (void) resetReferenceFrame;

@end
