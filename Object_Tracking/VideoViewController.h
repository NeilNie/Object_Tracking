//
//  VideoViewController.h
//  OpenCV Tutorial
//
//  Created by BloodAxe on 6/26/12.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

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

