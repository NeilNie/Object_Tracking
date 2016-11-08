//
//  SampleBase.h
//  OpenCV Tutorial
//
//  Created by BloodAxe on 6/23/12.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

#ifndef OpenCV_Tutorial_SampleBase_h
#define OpenCV_Tutorial_SampleBase_h

#include <vector>
#include <map>

//! Base class for all samples
class SampleBase
{
public:
    
    //! Returns true if this sample requires setting a reference image for latter use
    virtual bool isReferenceFrameRequired() const;
    
    //! Sets the reference frame for latter processing
    virtual void setReferenceFrame(const cv::Mat& reference);
    
    // Resets the reference frame
    virtual void resetReferenceFrame() const;
    
    //! Processes a frame and returns output image 
    virtual bool processFrame(const cv::Mat& inputFrame, cv::Mat& outputFrame) = 0;

    static void getGray(const cv::Mat& input, cv::Mat& gray);

};

#endif
