//
//  SampleBase.cpp
//  OpenCV Tutorial
//
//  Created by BloodAxe on 6/23/12.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

#include "SampleBase.h"
#include <iostream>
#include "cvneon.h"

void SampleBase::getGray(const cv::Mat& input, cv::Mat& gray){
    
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

//! Returns true if this sample requires setting a reference image for latter use
bool SampleBase::isReferenceFrameRequired() const
{
    return false;
}

//! Sets the reference frame for latter processing
void SampleBase::setReferenceFrame(const cv::Mat& reference)
{
    // Does nothing. Override this method if you need to
}

// Resets the reference frame
void SampleBase::resetReferenceFrame() const
{
    // Does nothing. Override this method if you need to
}
