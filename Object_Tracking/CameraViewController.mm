
//
//  CameraViewController.m
//  LogoDetector
//
//  License:
//  You may not copy, redistribute, use without quoting the author.
//  By using this file, you agree to the following LICENSE:
//  https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode


#import "CameraViewController.h"

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
            
            if([[MLManager sharedInstance] isFeature: feature] ){
                
                double tmp = [[MLManager sharedInstance] distance:feature];
                if (bestPoint > tmp ) {
                    bestPoint = tmp;
                    bestMser = &mser;
                }
                cv::Rect bound = cv::boundingRect(*bestMser);
                cv::rectangle(image, bound, GREEN, 3);
                //[ImageUtils drawMser: &mser intoImage: &image withColor: GREEN];
            }
        }
    });
    
    if (bestMser){
        
        NSLog(@"minDist: %f", bestPoint);
        NSLog(@"name: %@", [[MLManager sharedInstance] logoTemplate].name);
//        cv::Rect bound = cv::boundingRect(*bestMser);
//        cv::rectangle(image, bound, GREEN, 3); //if there is best MSER, draw green bounds around it.
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = [[MLManager sharedInstance] logoTemplate].name;
            //self.label.center = CGPointMake(bound.x, bound.y);
        });
    }else
        cv::rectangle(image, cv::Rect(0, 0, W, H), RED, 3);
    
    
    const char* str_fps = [[NSString stringWithFormat: @"MSER: %ld", msers.size()] cStringUsingEncoding: NSUTF8StringEncoding];
    cv::putText(image, str_fps, cv::Point(10, H - 10), CV_FONT_HERSHEY_PLAIN, 1.0, RED);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [FPS draw: image];
    });
}

@end
