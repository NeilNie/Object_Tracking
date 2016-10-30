//
//  VideoViewController.m
//  OpenCV Tutorial
//
//  Created by BloodAxe on 6/26/12.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

#import "VideoViewController.h"
#import "UIImage2OpenCV.h"

#import <opencv2/highgui/cap_ios.h>

#define kTransitionDuration	0.75

@interface VideoViewController ()<CvVideoCameraDelegate>
{
    BOOL bbegin;
    CGPoint begin;
    cv::Mat outputFrame;
}
@property (nonatomic, strong) CvVideoCamera* videoSource;

@end

@implementation VideoViewController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentSample = [[SampleFacade alloc] init];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:pan];
    
    self.videoSource = [[CvVideoCamera alloc] initWithParentView:self.containerView];
    self.videoSource.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoSource.defaultAVCaptureSessionPreset = AVCaptureSessionPresetMedium;
    self.videoSource.defaultFPS = 15;
    self.videoSource.imageWidth = self.view.frame.size.width / 2;
    self.videoSource.imageHeight = self.view.frame.size.height/ 2;
    self.videoSource.delegate = self;
    self.videoSource.recordVideo = NO;
    self.videoSource.grayscaleMode = NO;
    bbegin = NO;
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"capture session loaded: %d", [self.videoSource captureSessionLoaded]);
    
    self.captureReferenceFrameButton.enabled = self.currentSample.isReferenceFrameRequired;
    self.clearReferenceFrameButton.enabled = self.currentSample.isReferenceFrameRequired;
}

- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //start video source
    [self.videoSource start];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //stop video source.
    [self.videoSource stop];
}

#pragma mark - UIGesture Recognizers

-(void)panGesture:(UIPanGestureRecognizer *)pan{
    
    CGPoint point = [pan translationInView:self.containerView];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        begin = [pan locationInView:self.view];
        self.captureView.frame = CGRectMake(begin.x, begin.y, 1, 1);
        self.captureView.backgroundColor = [UIColor clearColor];
        self.captureView.layer.borderColor = [UIColor blackColor].CGColor;
        self.captureView.layer.borderWidth = 5.0f;
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
        self.captureView.frame = CGRectMake(begin.x, begin.y, point.x, point.y);
        
    }
}

- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:0.0 orientation:UIImageOrientationLeft];
    CGImageRelease(imageRef);
    
    return cropped;
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus

- (void) processImage:(cv::Mat&)image{
    
    //frame processing should be done here. Refer to objectTrack class for actual algorithm.
    
    [self.currentSample processFrame:image into:outputFrame];
    outputFrame.copyTo(image);
    
//    if (bbegin) {
//        UIImage *iimage = [UIImage imageWithMat:outputFrame andImageOrientation:UIImageOrientationLeft];
//        outputFrame = [[self croppIngimageByImageName:iimage toRect:CGRectMake(300,
//                                                                               300,
//                                                                               300,
//                                                                               300)] toMat];
//    }
//    
    //display actual image
    UIImage *uiimage2 = [UIImage imageWithMat:image andImageOrientation:UIImageOrientationLeft];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.testImage2.image = uiimage2;
    });
    
    //display output frame
    UIImage *uiimage = [UIImage imageWithMat:outputFrame andImageOrientation:UIImageOrientationLeft];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.testImage.image = uiimage;
    });
}
#endif

#pragma mark - Capture reference frame

- (IBAction) captureReferenceFrame:(id) sender{

    UIImage *iimage = [UIImage imageWithMat:outputFrame andImageOrientation:UIImageOrientationLeft];
    outputFrame = [[self croppIngimageByImageName:iimage toRect:CGRectMake(200,
                                                                     200,
                                                                     200,
                                                                     200)] toMat];
    bbegin = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.currentSample setReferenceFrame:outputFrame];
        self.testImage.image = [UIImage imageWithMat:outputFrame andImageOrientation:UIImageOrientationLeft];
    });
}

#pragma mark - Clear reference frame

- (IBAction) clearReferenceFrame:(id) sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.currentSample resetReferenceFrame];
        bbegin = NO;
    });
}

@end
