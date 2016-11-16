//
//  ObjectTrackingSample.cpp
//  OpenCV Tutorial
//
//  Created by Anton Belodedenko on 26/07/2012.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

#include <iostream>
#include "ObjectTrackingClass.h"
#include "ObjectTrackingSample.h"
#include "Globals.h"
#include <iostream>
#include "cvneon.h"

#pragma mark - Contructor

ObjectTrackingSample::ObjectTrackingSample(): m_algorithmName("LKT"), m_maxCorners(200){
    
    std::vector<std::string> algos;
    algos.push_back("LKT");
}

#pragma mark - Helpers

//! Sets the reference frame for latter processing
void ObjectTrackingSample::setReferenceFrame(const cv::Mat& reference)
{
    getGray(reference, imagePrev);
    computeObject = true;
}

void ObjectTrackingSample::getGray(const cv::Mat& input, cv::Mat& gray){
    
    const int numChannes = input.channels();
    
    if (numChannes == 4){
        cv::neon_cvtColorBGRA2GRAY(input, gray);
        
    }
    else if (numChannes == 3){
        cv::cvtColor(input, gray, cv::COLOR_BGR2GRAY);
    }
    else if (numChannes == 1)
    {
        gray = input;
    }
}

// Reset object keypoints and descriptors
void ObjectTrackingSample::resetReferenceFrame() const{
    trackObject = false;
    computeObject = false;
}

//!Get the extreme point, used for displaying the rectangle on the screen.
void ObjectTrackingSample::setExtremes(std::vector<cv::Point2f> &points){
    
    cv::Point2f min(FLT_MAX, FLT_MAX);
    cv::Point2f max(FLT_MIN, FLT_MIN);
    
    //find the max point
    for (int i = 0; i < points.size(); i++) {
        min.x = Min(min.x, points[i].x);
        min.y = Min(min.y, points[i].y);
        max.x = Max(max.x, points[i].x);
        max.y = Max(max.y, points[i].y);
    }
    
    //push those point into the std::vector;
    extremes.push_back(cv::Point2f (min.x, min.y));
    extremes.push_back(cv::Point2f (max.x, min.y));
    extremes.push_back(cv::Point2f (max.x, max.y));
    extremes.push_back(cv::Point2f (min.x, max.y));
}

#pragma mark - Object Tracking Method

//! Processes a frame and returns output image
bool ObjectTrackingSample::processFrame(const cv::Mat& inputFrame, cv::Mat& outputFrame){
    
    // display the frame
    inputFrame.copyTo(outputFrame);
    
    // convert input frame to gray scale
    getGray(inputFrame, imageNext);
    
    // prepare the tracking class
    ObjectTrackingClass ot;
    ot.setMaxCorners(m_maxCorners);
    
    // begin tracking object
    if (trackObject) {
        ot.track(outputFrame,
                 imagePrev, imageNext,
                 pointsPrev, pointsNext,
                 status,err);
        
        // check if the next points array isn't empty
        if (pointsNext.empty())
            trackObject = false;
        else
            //find the extremes.
            setExtremes(pointsNext);
    }
    
    // store the reference frame as the object to track
    if (computeObject) {
        ot.init(outputFrame, imagePrev, pointsNext);
        trackObject = true;
        computeObject = false;
    }
    
    // backup previous frame
    imageNext.copyTo(imagePrev);
    
    // backup points array
    std::swap(pointsNext, pointsPrev);

    return true;
}
