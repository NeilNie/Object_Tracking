//
//  VideoViewController.m
//  OpenCV Tutorial
//
//  Created by BloodAxe on 6/26/12.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

#import "VideoViewController.h"
#import "ImageUtils.h"

#import <opencv2/videoio/cap_ios.h>

#define kTransitionDuration	0.75

@interface VideoViewController ()<CvVideoCameraDelegate>
{
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

-(CGRect)mapImageRect{
    
    return
    CGRectMake(self.captureView.frame.origin.y * 2 - 200,
               self.captureView.frame.origin.x * 2,
               self.captureView.frame.size.height * 2,
               self.captureView.frame.size.width * 2
               );
    
}

- (UIImage *)imageByCroppingImage:(UIImage *)image{
    
    CGRect cropRect = [self mapImageRect];
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationLeft];
    CGImageRelease(imageRef);
    
    return cropped;
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus

- (void) processImage:(cv::Mat&)image{
    
    // Do some OpenCV stuff with the image
    self.currentFrame = [ImageUtils imageWithMat:image andImageOrientation:UIImageOrientationLeft];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.currentFrameView.image = self.currentFrame;
    });
    [self.currentSample processFrame:image into:outputFrame];
    outputFrame.copyTo(image);
}
#endif

#pragma mark - Capture reference frame

- (IBAction) captureReferenceFrame:(id) sender{
    
    self.testImage.image = [self imageByCroppingImage:self.currentFrame];
    
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
