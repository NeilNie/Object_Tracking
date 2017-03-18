//
//  SampleFacade.m
//  OpenCV Tutorial
//  Created by Neil Nie, in 10/2016
//  Referenced From BloodAxe on 8/14/12.
//
//

#import "SampleFacade.h"
#import "NSString+StdString.h"
#import "ImageUtils.h"
#import "ObjectTrackingSample.h"

@interface SampleFacade(){
    ObjectTrackingSample* _sample;
}

@end

@implementation SampleFacade

- (instancetype)init{
    
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

-(NSArray *__nonnull)getPoints{
    
    //get ObjectTrackingSample class pointsPrev, which contains all the points beging tracked. Send this to the VC and display on the UI
    std::vector<cv::Point2f> points = _sample->ObjectTrackingSample::pointsNext;
    
    NSMutableArray *array = [NSMutableArray array];
    
    //contruct the array
    for (int i = 0; i < points.size(); i++) {
        
        CVPoint_objc *point = [[CVPoint_objc alloc] initWithx:points[i].x y:points[i].y];
        [array addObject:point];
    }
    
    return array;
}

-(NSArray *__nonnull)getExtremes{
    
    //get ObjectTrackingSample class extremes, which contains all the extreme points. Draw a rectangle on the screen with these points.
    std::vector<cv::Point2f> extremes = _sample->ObjectTrackingSample::extremes;
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < extremes.size(); i++) {
        CVPoint_objc *point = [[CVPoint_objc alloc] initWithx:extremes[i].x y:extremes[i].y];
        [array addObject:point];
    }
    return array;
}

- (bool) getIsReferenceFrameRequired{
    return true;
}

- (void) setReferenceFrame:(cv::Mat&) referenceFrame{
    
    _sample->setReferenceFrame(referenceFrame);
}

- (void) resetReferenceFrame{
    
    _sample->resetReferenceFrame();
}

@end
