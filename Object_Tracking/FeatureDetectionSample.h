//
//  FeatureDetection.h
//  OpenCV Tutorial
//
//  Created by Anton Belodedenko on 25/07/2012.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

#ifndef OpenCV_Tutorial_FeatureDetection_h
#define OpenCV_Tutorial_FeatureDetection_h

class FeatureDetectionSample {
    
public:
    FeatureDetectionSample();
    
    //! Processes a frame and returns output image
    virtual bool processFrame(const cv::Mat& inputFrame, cv::Mat& outputFrame);
    
    static void getGray(const cv::Mat& input, cv::Mat& gray);
    
private:
    cv::Mat grayImage;
    
    std::vector<cv::KeyPoint> objectKeypoints;
    
    std::string m_detectorName;
    std::vector<std::string> m_alorithms;
    
    cv::Ptr<cv::ORB>  m_ORB;
    //cv::Ptr<cv::AKAZE> m_AKAZE;
    cv::Ptr<cv::FastFeatureDetector> m_FAST;
    
    int m_maxFeatures;
    int m_fastThreshold;
};

#endif
