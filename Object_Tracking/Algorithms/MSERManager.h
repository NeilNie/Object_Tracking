//
//  MSERManager.h
//  LogoDetector
//
//  Created By Yongyang Nie 11/20/2016
//  Copyright (c) 2016 Yongyang Nie. All rights reserved.
//  License:
//  You may not copy, redistribute, use without quoting the author.
//  By using this file, you agree to the following LICENSE:
//  https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode

#import <Foundation/Foundation.h>

#import <opencv2/features2d/features2d.hpp>
#import "MSERFeature.h"

/*
 Singelton class providing function related to msers
 */
@interface MSERManager : NSObject

+ (MSERManager *) sharedInstance;

/*
 Extracts all msers into provided vector
 */
- (void) detectRegions: (cv::Mat &) gray intoVector:(std::vector<std::vector<cv::Point>> &)vector;

/*
 Extracts feature from the mser. For some MSERs feature can be NULL !!!
 */
- (MSERFeature *) extractFeature: (std::vector<cv::Point> *) mser;

@end
