//
//  ViewController.m
//  OpenCV Tests
//
//  Created by Yongyang Nie on 11/16/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import "ViewController.h"
#import <opencv2/opencv.hpp>
#import <opencv2/highgui.hpp>
#import <opencv2/core.hpp>
#import <opencv2/imgproc.hpp>
#import <opencv2/features2d.hpp>
#import <opencv2/features2d/features2d.hpp>
#include <iostream>
#import "ImageUtils.h"

@implementation ViewController

-(IBAction)processImage:(id)sender{
    
    cv::Mat image = [ImageUtils cvMatFromUIImage:self.image.image];
    cv::Mat testImage;
    cv::cvtColor(image, testImage, CV_BGR2GRAY);
    
    std::vector<std::vector <cv::Point2f>> contours;
    std::vector<cv::Rect> bboxes;
    
    //cv::Ptr<cv::MSER> mserDetector;
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
    
    //mserDetector = cv::MSER::create(delta, minArea, maxArea,
                                    maxVariation, minDiversity, maxEvolution,
                                    areaThreshold, minMargin, edgeBlurSize
                                    );
    
//    Mat inImg = imread("M:\\____videoSample____\\SceneText\\SceneText01.jpg");
//    
//    Mat textImg;
//    
//    cvtColor(inImg, textImg, CV_BGR2GRAY);
//    
//    //Extract MSER
//    vector< vector< Point> > contours;
//    
//    vector< Rect> bboxes;
//    
//    Ptr< MSER> mser = MSER::create(21, (int)(0.00002 * textImg.cols * textImg.rows), (int)(0.05 * textImg.cols * textImg.rows), 1, 0.7);
//    
//    mser->detectRegions(textImg, contours, bboxes);
//    
//    for (int i = 0; i < bboxes.size(); i++){
//        rectangle(inImg, bboxes[i], CV_RGB(0, 255, 0));
//    }
//    namedWindow("t");
//    imshow("t", inImg);

}

- (void)viewDidLoad {
    
    std::cout << "Hello World";
    [super viewDidLoad];
    self.image.image = [NSImage imageNamed:@"test1"];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
