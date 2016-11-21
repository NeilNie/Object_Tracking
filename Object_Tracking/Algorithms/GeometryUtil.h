
//
//  GeometryUtil.h
//  LogoDetector
//
//  Created By Yongyang Nie 11/20/2016
//  Copyright (c) 2016 Yongyang Nie. All rights reserved.
//  License:
//  You may not copy, redistribute, use without quoting the author.
//  By using this file, you agree to the following LICENSE:
//  https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode

#import <Foundation/Foundation.h>

/*
 This static class provides perspective transformation function
 */
@interface GeometryUtil : NSObject

/*
 Return perspective transformation matrix for given points to square with 
 origin [0,0] and with size (size.width, size.width)
 */
+ (cv::Mat) getPerspectiveMatrix: (cv::Point2f[]) points toSize: (cv::Size2f) size;

/*
 Returns new perspecivly transformed image with given size
 */
+ (cv::Mat) normalizeImage: (cv::Mat *) image withTranformationMatrix: (cv::Mat *) M withSize: (float) size;

@end
