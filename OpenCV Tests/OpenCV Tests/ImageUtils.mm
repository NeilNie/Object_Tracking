////////
// This sample is published as part of the blog article at www.toptal.com/blog
// Visit www.toptal.com/blog and subscribe to our newsletter to read great posts
////////

//
//  ImageUtils.m
//  LogoDetector
//
//  Created by altaibayar tseveenbayar on 15/05/15.
//  Copyright (c) 2015 altaibayar tseveenbayar. All rights reserved.
//

#import "ImageUtils.h"

//http://docs.opencv.org/doc/tutorials/ios/image_manipulation/image_manipulation.html

@implementation ImageUtils

const cv::Scalar RED = cv::Scalar(0, 0, 255);
const cv::Scalar GREEN = cv::Scalar(0, 255, 0);
const cv::Scalar BLUE = cv::Scalar(255, 0, 0);
const cv::Scalar BLACK = cv::Scalar(0, 0, 0);
const cv::Scalar WHITE = cv::Scalar(255, 255, 255);
const cv::Scalar YELLOW = cv::Scalar(0, 255, 255);
const cv::Scalar LIGHT_GRAY = cv::Scalar(100, 100, 100);

+ (cv::Mat) cvMatFromUIImage: (NSImage *) image{
    
    CGImageRef imageRef;
    CGImageSourceRef CGImageRef = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
    imageRef = CGImageSourceCreateImageAtIndex(CGImageRef, 0, NULL);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), imageRef);
    CGContextRelease(contextRef);
    
    return cvMat;
}

+ (cv::Mat) cvMatGrayFromUIImage: (NSImage *)image{
    
    CGImageRef imageRef;
    CGImageSourceRef CGImageRef = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
    imageRef = CGImageSourceCreateImageAtIndex(CGImageRef, 0, NULL);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC1); // 8 bits per component, 1 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), imageRef);
    CGContextRelease(contextRef);
    
    return cvMat;
}

+ (NSImage *) UIImageFromCVMat: (cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1)
        colorSpace = CGColorSpaceCreateDeviceGray();
    else
        colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                              //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,//bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    NSImage *finalImage = [[NSImage alloc] initWithCGImage:imageRef size:NSMakeSize(cvMat.cols, cvMat.rows)];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}

@end
