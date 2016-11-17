//
//  VideoViewController.m
//  OpenCV Tutorial
//
//  Created by BloodAxe on 6/26/12.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

#import "FeatureDetectionViewController.h"
#import "ImageUtils.h"

#import <opencv2/highgui/cap_ios.h>

#define kTransitionDuration	0.75

@interface FeatureDetectionViewController ()<CvVideoCameraDelegate>
{
    CGPoint begin;
    cv::Mat outputFrame;
}
@property (nonatomic, strong) CvVideoCamera* videoSource;

@end

@implementation FeatureDetectionViewController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.featureSample = [[SampleFacade alloc] init];
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
//    [self.view addGestureRecognizer:pan];
    
    self.videoSource = [[CvVideoCamera alloc] initWithParentView:self.containerView];
    self.videoSource.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoSource.defaultAVCaptureSessionPreset = AVCaptureSessionPreset1280x720;
    self.videoSource.defaultFPS = 30;
    self.videoSource.imageWidth = 1280;
    self.videoSource.imageHeight = 720;
    self.videoSource.delegate = self;
    self.videoSource.recordVideo = NO;
    self.videoSource.grayscaleMode = NO;

}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"capture session loaded: %d", [self.videoSource captureSessionLoaded]);
}

- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.videoSource start];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.videoSource stop];
}

//#pragma mark - UIGesture Recognizers

//-(void)panGesture:(UIPanGestureRecognizer *)pan{
//    
//    CGPoint point = [pan translationInView:self.containerView];
//    
//    if (pan.state == UIGestureRecognizerStateBegan) {
//        
//        begin = [pan locationInView:self.view];
//        self.captureView.frame = CGRectMake(begin.x, begin.y, 1, 1);
//        self.captureView.backgroundColor = [UIColor clearColor];
//        self.captureView.layer.borderColor = [UIColor blackColor].CGColor;
//        self.captureView.layer.borderWidth = 5.0f;
//        
//    }else if (pan.state == UIGestureRecognizerStateChanged){
//        
//        self.captureView.frame = CGRectMake(begin.x, begin.y, point.x, point.y);
//        
//    }
//}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus

- (void) processImage:(cv::Mat&)image{
    // Do some OpenCV stuff with the image
    [self.featureSample processFrame:image into:outputFrame];
    outputFrame.copyTo(image);
}
#endif

#pragma mark - Capture reference frame

- (IBAction) captureReferenceFrame:(id) sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.featureSample setReferenceFrame:outputFrame];
    });
}

#pragma mark - Clear reference frame

- (IBAction) clearReferenceFrame:(id) sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.featureSample resetReferenceFrame];
    });
}


@end
