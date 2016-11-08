//
//  SampleFacade.m
//  OpenCV Tutorial
//
//  Created by BloodAxe on 8/14/12.
//
//

#import "SampleFacade.h"
#import "NSString+StdString.h"
#import "ImageUtils.h"
#import "ObjectTrackingSample.h"

@interface SampleFacade(){
    SampleBase * _sample;
}

@end

@implementation SampleFacade

- (id)init{
    
    if (self = [super init]){
        _sample = new ObjectTrackingSample();
    }
    
    return self;
}

- (bool)processFrame:(const cv::Mat&) inputFrame into:(cv::Mat&) outputFrame{
    return _sample->processFrame(inputFrame, outputFrame);
}

- (UIImage*) processFrame:(UIImage*) source{
    
    cv::Mat inputImage = [ImageUtils cvMatFromUIImage:source];
    cv::Mat outputImage;
    
    _sample->processFrame(inputImage, outputImage);
    UIImage * result = [ImageUtils UIImageFromCVMat:outputImage];
    return result;
}

- (bool) getIsReferenceFrameRequired{
    return _sample->isReferenceFrameRequired();
}

- (void) setReferenceFrame:(cv::Mat&) referenceFrame{
    
    _sample->setReferenceFrame(referenceFrame);
}

- (void) resetReferenceFrame{
    
    _sample->resetReferenceFrame();
}

@end
