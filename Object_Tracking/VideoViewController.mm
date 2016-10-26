//
//  VideoViewController.m
//  OpenCV Tutorial
//
//  Created by BloodAxe on 6/26/12.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

#import "VideoViewController.h"
#import "UIImage2OpenCV.h"

#import <opencv2/videoio/cap_ios.h>

#define kTransitionDuration	0.75

@interface VideoViewController ()<CvVideoCameraDelegate>
{
    cv::Mat outputFrame;
}
@property (nonatomic, strong) CvVideoCamera* videoSource;

@end

@implementation VideoViewController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    self.toggleCameraButton.enabled = true;
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

- (IBAction)showActionSheet:(id)sender{
    [self presentViewController:self.actionSheet animated:YES completion:nil];
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus

- (void) processImage:(cv::Mat&)image{
    // Do some OpenCV stuff with the image
    [self.currentSample processFrame:image into:outputFrame];
    outputFrame.copyTo(image);
}
#endif

#pragma mark - Capture reference frame

- (IBAction) captureReferenceFrame:(id) sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.currentSample setReferenceFrame:outputFrame];
    });
}

#pragma mark - Clear reference frame

- (IBAction) clearReferenceFrame:(id) sender{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.currentSample resetReferenceFrame];
    });
}


@end
