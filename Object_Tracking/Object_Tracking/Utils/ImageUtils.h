
//
//  ImageUtils.h
//  LogoDetector
//
//  Created By Yongyang Nie 11/20/2016
//  Copyright (c) 2016 Yongyang Nie. All rights reserved.
//  License:
//  You may not copy, redistribute, use without quoting the author.
//  By using this file, you agree to the following LICENSE:
//  https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include <opencv2/opencv.hpp>

@interface ImageUtils : NSObject

extern const cv::Scalar RED;
extern const cv::Scalar GREEN;
extern const cv::Scalar BLUE;
extern const cv::Scalar BLACK;
extern const cv::Scalar WHITE;
extern const cv::Scalar YELLOW;
extern const cv::Scalar LIGHT_GRAY;

+ (cv::Mat) cvMatFromUIImage: (UIImage *) image;
+ (cv::Mat) cvMatGrayFromUIImage: (UIImage *)image;

+ (UIImage *) UIImageFromCVMat: (cv::Mat)cvMat;

+ (cv::Mat) mserToMat: (std::vector<cv::Point> *) mser;

+ (void) drawMser: (std::vector<cv::Point> *) mser intoImage: (cv::Mat *) image withColor: (cv::Scalar) color;

+ (std::vector<cv::Point>) maxMser: (cv::Mat *) gray;

+(UIImage*) imageWithMat:(const cv::Mat&) image andImageOrientation: (UIImageOrientation) orientation;
+(UIImage*) imageWithMat:(const cv::Mat&) image andDeviceOrientation: (UIDeviceOrientation) orientation;

@end
