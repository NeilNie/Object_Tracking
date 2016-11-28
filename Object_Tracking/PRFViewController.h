//
//  PRFViewController.h
//  
//
//  Created by Yongyang Nie on 11/27/16.
//  (c) Yongyang Nie. All Rights reserved. 
//
//  License:
//  You may not copy, redistribute, use without quoting the author.
//  By using this file, you agree to the following LICENSE:
//  https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode

#import <UIKit/UIKit.h>
#import <MLManager.h>

@interface PRFViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *debuggerSwitch;
@property (weak, nonatomic) IBOutlet UISlider *accuracySlide;
@property (weak, nonatomic) IBOutlet UISlider *frameSlide;
@property (weak, nonatomic) IBOutlet UISegmentedControl *definitionControl;

@end
