//
//  VideoViewController.h
//  OpenCV Tutorial
//
//  Created by BloodAxe on 6/26/12.
//  Copyright (c) 2012 computer-vision-talks.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SampleBase.h"
#import "SampleFacade.h"

@interface VideoViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) SampleFacade * currentSample;

@property (weak, nonatomic) IBOutlet UIView *captureView;
@property (weak, nonatomic) IBOutlet UIImageView *containerView;

- (IBAction)captureReferenceFrame:(id)sender;
- (IBAction)clearReferenceFrame:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *captureReferenceFrameButton;
@property (weak, nonatomic) IBOutlet UIButton *clearReferenceFrameButton;

@end

