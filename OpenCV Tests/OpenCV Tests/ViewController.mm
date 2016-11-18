//
//  ViewController.m
//  OpenCV Tests
//
//  Created by Yongyang Nie on 11/16/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import "ViewController.h"
#import <opencv2/opencv.hpp>
#import <opencv2/core.hpp>
#import <opencv2/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#import <opencv2/features2d/features2d.hpp>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

#import "ImageUtils.h"
#import "MSERManager.h"

using namespace cv;

@implementation ViewController

#pragma mark - NSTableView Delegate & Datasource

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.array.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSString *cellID;
    NSString *textValue;
    
    MSERFeature *feature = [self.array objectAtIndex:row];
    
    //MSER #
    if ([tableColumn isEqual:tableView.tableColumns[0]]) {
        cellID = @"idMSERN";
        textValue = [NSString stringWithFormat:@"%li", (long)row];
    }else if ([tableColumn isEqual:tableView.tableColumns[1]]){
        cellID = @"idskeletLengthRate";
        textValue = [NSString stringWithFormat:@"%f", feature.skeletLengthRate];
    }else if ([tableColumn isEqual:tableView.tableColumns[2]]){
        cellID = @"idcontourAreaRate";
        textValue = [NSString stringWithFormat:@"%f", feature.contourAreaRate];
    }else if ([tableColumn isEqual:tableView.tableColumns[3]]){
        cellID = @"minRectAreaRate";
        textValue = [NSString stringWithFormat:@"%f", feature.minRectAreaRate];
    }
        //else{
//        cellID = @"numberOfHoles";
//        textValue = [NSString stringWithFormat:@"%li", (long)feature.numberOfHoles];
//    }
    
    NSTableCellView *cell = [tableView makeViewWithIdentifier:cellID owner:nil];
    cell.textField.stringValue = textValue;
    
    return (cell)? cell : nil;
}

#pragma mark - cv & MSER

cv::MserFeatureDetector mserDetector;

- (void) detectRegions: (cv::Mat &) gray intoVector: (std::vector<std::vector<cv::Point>> &) vector{
    mserDetector(gray, vector);
}

-(IBAction)processImage:(id)sender{
    
    cv::Mat image = [ImageUtils cvMatFromUIImage:self.image.image];
    cv::Mat testImage;
    cv::cvtColor(image, testImage, CV_BGR2GRAY);
    
    std::vector<std::vector<cv::Point>> contours;
    
    /* THESE ARE ALL DEFAULT VALUES */
    int delta = 5;                  //! delta, in the code, it compares (size_{i}-size_{i-delta})/size_{i-delta}
    //int minArea = 5120;            //! (640 * 480 / 60) ... max mser is 1/60 of the whole image
    //int maxArea = 10480;            //! (640 * 480 / 15) ... max mser is 1/15 of the whole image
    int minArea = 60;               //! prune the area which bigger than maxArea
    int maxArea = 14400;            //! prune the area which smaller than minArea
    double maxVariation = 0.25;     //! prune the area have simliar size to its children
    double minDiversity = 0.2;      //! trace back to cut off mser with diversity < min_diversity
    int maxEvolution = 200;         //! for color image, the evolution steps
    double areaThreshold = 1.01;    //! the area threshold to cause re-initialize
    double minMargin = 0.003;       //! ignore too small margin
    int edgeBlurSize = 0;           //! the aperture size for edge blur
    
    mserDetector = cv::MserFeatureDetector(delta, minArea, maxArea,
                                           maxVariation, minDiversity, maxEvolution,
                                           areaThreshold, minMargin, edgeBlurSize
                                           );
    [self detectRegions:testImage intoVector:contours];
    
    for (int i = 0; i < contours.size(); i++) {
        cv::Rect bound = cv::boundingRect(contours[i]);
        cv::rectangle(image, bound, CV_RGB(100, 100, 100));
        
        MSERFeature *feature = [MSERManager extractFeature:&contours[i]];
        if (feature) {
            [self.array addObject:feature];
        }
    }
    
    self.image.image = [ImageUtils UIImageFromCVMat:image];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.image.image = [NSImage imageNamed:@"test3"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.array = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

@end
