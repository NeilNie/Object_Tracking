//
//  VideoViewController.h
//  OpenCV Tutorial
//
//  License:
//  You may not copy, redistribute, use without quoting the author.
//  By using this file, you agree to the following LICENSE:
//  https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SampleFacade.h"
#import "ImageUtils.h"

@interface VideoViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) SampleFacade * objectTracker;

@property (weak, nonatomic) IBOutlet UIView *trackingScreen;
@property (weak, nonatomic) IBOutlet UIImageView *currentFrameView;
@property (strong, nonatomic) UIImage *currentFrame;
@property (weak, nonatomic) IBOutlet UIImageView *testImage;
@property (weak, nonatomic) IBOutlet UIView *captureView;
@property (weak, nonatomic) IBOutlet UIImageView *containerView;

@property (weak, nonatomic) IBOutlet UIButton *captureReferenceFrameButton;
@property (weak, nonatomic) IBOutlet UIButton *clearReferenceFrameButton;

@end

