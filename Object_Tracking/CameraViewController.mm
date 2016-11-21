
//
//  CameraViewController.m
//  LogoDetector
//
//  License:
//  You may not copy, redistribute, use without quoting the author.
//  By using this file, you agree to the following LICENSE:
//  https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode


#import "CameraViewController.h"
#import <opencv2/highgui/cap_ios.h>

#import "MSERManager.h"
#import "MLManager.h"
#import "ImageUtils.h"
#import "GeometryUtil.h"

#ifdef DEBUG
#import "FPS.h"
#endif

//this two values are dependant on defaultAVCaptureSessionPreset
#define W (480)
#define H (640)

@interface CameraViewController(){
    CvVideoCamera *camera;
    BOOL started;
}

@end

@implementation CameraViewController

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
    //Camera
    camera = [[CvVideoCamera alloc] initWithParentView:_img];
    camera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    camera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    camera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    camera.defaultFPS = 15;
    camera.grayscaleMode = NO;
    camera.delegate = self;
    
    started = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
    
    //[self test];
    [self learn:[UIImage imageNamed: @"e"]];
}

- (void) learn: (UIImage *) templateImage{
    
    cv::Mat image = [ImageUtils cvMatFromUIImage: templateImage];
    
    //get gray image
    cv::Mat gray;
    cvtColor(image, gray, CV_BGRA2GRAY);
    
    //mser with maximum area is
    std::vector<cv::Point> maxMser = [ImageUtils maxMser: &gray];
    
//    //get 4 vertices of the maxMSER minrect
//    cv::RotatedRect rect = cv::minAreaRect(maxMser);
//    cv::Point2f points[4];
//    rect.points(points);
//    
//    //normalize image
//    cv::Mat M = [GeometryUtil getPerspectiveMatrix: points toSize: rect.size];
//    cv::Mat normalizedImage = [GeometryUtil normalizeImage: &gray withTranformationMatrix: &M withSize: rect.size.width];
//    
//    //get maxMser from normalized image
//    std::vector<cv::Point> normalizedMser = [ImageUtils maxMser: &normalizedImage];
    
    //remember the template
    //[MLManager sharedInstance].logoTemplate = [[MSERManager sharedInstance] extractFeature: &normalizedMser];
    
    [MLManager sharedInstance].logoTemplate = [[MSERManager sharedInstance] extractFeature: &maxMser];
    
    //store the feature
    [[MLManager sharedInstance] storeTemplate];
    
    [self.img setImage:[ImageUtils UIImageFromCVMat: [ImageUtils mserToMat:&maxMser]]];
}

- (IBAction)btn_TouchUp:(id)sender {
    started = !started;
    dispatch_async(dispatch_get_main_queue(), ^{
        [camera start];
    });
}

-(void)processImage:(cv::Mat &)image{
    
    if (!started){
        [FPS draw: image]; return; }
    
    //convert it into gray image
    cv::Mat gray;
    cvtColor(image, gray, CV_BGRA2GRAY);
    
    std::vector<std::vector<cv::Point>> msers;
    
    [[MSERManager sharedInstance] detectRegions:gray intoVector: msers]; //detection regions
    if (msers.size() == 0) return; //if there is not region, return
    
    std::vector<cv::Point> *bestMser = nil;
    double bestPoint = 10.0;
    
    std::for_each(msers.begin(), msers.end(), [&] (std::vector<cv::Point> &mser){
        
        MSERFeature *feature = [[MSERManager sharedInstance] extractFeature: &mser];
        
        if(feature){
            
            //NSLog(@"%@", feature);
            
            if([[MLManager sharedInstance] isFeature: feature] ){
                
                double tmp = [[MLManager sharedInstance] distance:feature];
                if (bestPoint > tmp ) {
                    bestPoint = tmp;
                    bestMser = &mser;
                }
                [ImageUtils drawMser: &mser intoImage: &image withColor: GREEN];
            }
            //            else
            //                [ImageUtils drawMser: &mser intoImage: &image withColor: RED];
            
        }
        //        else
        //            [ImageUtils drawMser: &mser intoImage: &image withColor: BLUE];
        //
    });
    
    if (bestMser){
        
        NSLog(@"minDist: %f", bestPoint);
        
        cv::Rect bound = cv::boundingRect(*bestMser);
        cv::rectangle(image, bound, GREEN, 3); //if there is best MSER, draw green bounds around it.
    }else
        cv::rectangle(image, cv::Rect(0, 0, W, H), RED, 3);

    
    const char* str_fps = [[NSString stringWithFormat: @"MSER: %ld", msers.size()] cStringUsingEncoding: NSUTF8StringEncoding];
    cv::putText(image, str_fps, cv::Point(10, H - 10), CV_FONT_HERSHEY_PLAIN, 1.0, RED);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [FPS draw: image];
    });
}

@end
