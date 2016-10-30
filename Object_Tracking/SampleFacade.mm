//
//  SampleFacade.m
//  OpenCV Tutorial
//
//  Created by BloodAxe on 8/14/12.
//
//

#import "SampleFacade.h"
#import "NSString+StdString.h"
#import "UIImage2OpenCV.h"
#import "ObjectTrackingSample.h"

@interface SampleFacade(){
    NSString * m_title;
    NSString * m_description;
    UIImage  * m_smallIcon;
    UIImage  * m_largeIcon;
    
    SampleBase * _sample;
}

@end

@implementation SampleFacade

- (id)init{
    
    if (self = [super init])
        _sample = new ObjectTrackingSample();
    
    return self;
}

- (bool)processFrame:(const cv::Mat&) inputFrame into:(cv::Mat&) outputFrame{
    return _sample->processFrame(inputFrame, outputFrame);
}

- (UIImage*) processFrame:(UIImage*) source{
    
    cv::Mat inputImage = [source toMat];
    cv::Mat outputImage;
    
    _sample->processFrame(inputImage, outputImage);
    UIImage * result = [UIImage imageWithMat:outputImage andImageOrientation:[source imageOrientation]];
    return result;
}

- (bool) getIsReferenceFrameRequired{
    return _sample->isReferenceFrameRequired();
}

- (void) setReferenceFrame:(cv::Mat&) referenceFrame{ _sample->setReferenceFrame(referenceFrame);}

- (void) resetReferenceFrame{ _sample->resetReferenceFrame(); }

@end
