//
//  ObjectTrackingSample.h
//  OpenCV Tutorial
//
//  Created by Anton Belodedenko on 26/07/2012.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

#ifndef OpenCV_Tutorial_ObjectTrackingSample_h
#define OpenCV_Tutorial_ObjectTrackingSample_h

inline float Min(float a, float b) { return a < b ? a : b; }
inline float Max(float a, float b) { return a > b ? a : b; }

class ObjectTrackingSample
{
public:
    
    //!the extreme corners among pointsNext. Used for display a rectangle along the region being tracked.
    std::vector<cv::Point2f> extremes;
    
    //!points that are being ifentified in the previous and next frame.
    std::vector<cv::Point2f> pointsPrev, pointsNext;
    
    ObjectTrackingSample();
    
    //! Sets the reference frame for latter processing
    virtual void setReferenceFrame(const cv::Mat& reference);
    
    //! clears reference frame parameters
    virtual void resetReferenceFrame() const;
    
    //! Processes a frame and returns output image
    virtual bool processFrame(const cv::Mat& inputFrame, cv::Mat& outputFrame);
    
    static void getGray(const cv::Mat& input, cv::Mat& gray);
    
private:
    
    cv::Mat imageNext, imagePrev;
    
    std::vector<uchar> status;
    
    std::vector<float> err;
    
    std::string m_algorithmName;
    
    // optical flow options
    int m_maxCorners;
    
    virtual void setExtremes(std::vector<cv::Point2f>& points);
};

#endif
