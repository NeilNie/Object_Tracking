////////
// This sample is published as part of the blog article at www.toptal.com/blog
// Visit www.toptal.com/blog and subscribe to our newsletter to read great posts
////////

//
//  MSERManager.m
//  LogoDetector
//
//  Created by altaibayar tseveenbayar on 13/05/15.
//  Copyright (c) 2015 altaibayar tseveenbayar. All rights reserved.
//

#import "MSERManager.h"
#import "ImageUtils.h"

@implementation MSERManager

+ (void) detectRegions: (cv::Mat &) gray intoVector: (std::vector<std::vector<cv::Point>> &) vector
{
    cv::MserFeatureDetector mserDetector;
    mserDetector(gray, vector);
}

+ (MSERFeature *) extractFeature: (std::vector<cv::Point> *) mser{
    
    cv::Mat mserImg = [ImageUtils mserToMat: mser];
    if (mserImg.cols <= 2 || mserImg.rows <= 2) { return nil; }
    
    MSERFeature *result = [[MSERFeature alloc] init];
    cv::RotatedRect minRect = cv::minAreaRect(*mser);
    
    // numer of holes
    result.numberOfHoles = [MSERManager numberOfHoles: &mserImg];
    
    // MSER_AREA / CONVEX_HULL_AREA
    std::vector<cv::Point> convexHull;
    cv::convexHull(*mser, convexHull);
    result.convexHullAreaRate = (double)mser->size() / cv::contourArea( convexHull );
    
    // MSER_AREA / MIN_RECT_AREA
    result.minRectAreaRate = (double)mser->size() / (double) minRect.size.area();
    
    // MSER_SKELET_LENGTH / MSER_AREA
    result.skeletLengthRate = (double)[MSERManager skeletLength: &mserImg ] / (double) mser->size();
    
    // MSER_AREA / CONTOUR_AREA
    double contourArea = [MSERManager contourArea: &mserImg];
    if (contourArea == 0.0) return nil;
    result.contourAreaRate = (double)mser->size() / contourArea;
    if (result.contourAreaRate > 1.0) return nil;
    
    return result;
}

#pragma mark - helper

// http://felix.abecassis.me/2011/09/opencv-morphological-skeleton/
+ (int) skeletLength: (cv::Mat *) mserImg
{
    cv::Mat img;
    mserImg->copyTo(img);
    
    cv::threshold(img, img, 127, 255, cv::THRESH_BINARY);
    cv::Mat skel(img.size(), CV_8UC1, cv::Scalar(0));
    cv::Mat temp;
    cv::Mat eroded;
    
    cv::Mat element = cv::getStructuringElement(cv::MORPH_CROSS, cv::Size(3, 3));
    bool done;
    do
    {
        cv::erode(img, eroded, element);
        cv::dilate(eroded, temp, element); // temp = open(img)
        cv::subtract(img, temp, temp);
        cv::bitwise_or(skel, temp, skel);
        eroded.copyTo(img);
        
        done = (cv::countNonZero(img) == 0);
    } while (!done);
    
    return cv::countNonZero(skel);
}

// number of holes are obtained from number of contours
+ (int) numberOfHoles: (cv::Mat *) img
{
    std::vector<std::vector<cv::Point>> contours;
    std::vector<cv::Vec4i> hierarchy;
    cv::findContours(*img, contours, hierarchy, cv::RETR_TREE, cv::CHAIN_APPROX_NONE);
    
    if (hierarchy.size() == contours.size()) return 1;
    
    int result = 0;
    for (size_t i = 0; i < hierarchy.size(); i++) {
        if (hierarchy[i][3] != - 1) result++;
    }
    
    return result;
}

+ (double) contourArea: (cv::Mat *) img
{
    std::vector<std::vector<cv::Point>> contours;
    std::vector<cv::Vec4i> hierarchy;
    cv::findContours(*img, contours, hierarchy, cv::RETR_TREE, cv::CHAIN_APPROX_SIMPLE);
    
    for (size_t i = 0; i < hierarchy.size(); i++) {
        if (hierarchy[i][3] == -1) {
            double area = cv::contourArea(contours[i]);
            if (area > 0) return area;
        }
    }
    
    return 0.0;
}

@end
