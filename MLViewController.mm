//
//  MLViewController.m
//  Object_Tracking
//
//  Created by Yongyang Nie on 11/27/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import "MLViewController.h"

@interface MLViewController ()

@end

@implementation MLViewController

- (void) learn: (UIImage *) templateImage{
    
    cv::Mat image = [ImageUtils cvMatFromUIImage: templateImage];
    
    //get gray image
    cv::Mat gray;
    cvtColor(image, gray, CV_BGRA2GRAY);
    
    //mser with maximum area is
    std::vector<cv::Point> maxMser = [ImageUtils maxMser: &gray];
    
    [MLManager sharedInstance].logoTemplate = [[MSERManager sharedInstance] extractFeature: &maxMser];
    
    //store the feature
    [[MLManager sharedInstance] storeTemplate];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Learned Successfully"
                                                    message:[NSString stringWithFormat:@"The template have been learned. numberOfHoles %li \n convexHullAreaRate: %f \n minRectAreaRate: %f \n skeletLengthRate: %f \n contourAreaRate: %f", (long)[MLManager sharedInstance].logoTemplate.numberOfHoles, [MLManager sharedInstance].logoTemplate.convexHullAreaRate, [MLManager sharedInstance].logoTemplate.minRectAreaRate, [MLManager sharedInstance].logoTemplate.skeletLengthRate, [MLManager sharedInstance].logoTemplate.contourAreaRate]
                                                   delegate:nil
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:nil, nil];
    
    [alert show];
    
    [self.mserView setImage:[ImageUtils UIImageFromCVMat: [ImageUtils mserToMat:&maxMser]]];
}

#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.imageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
    [self learn:[UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]]];
    [[NSUserDefaults standardUserDefaults] setObject:[self.imageArray objectAtIndex:indexPath.row] forKey:@"imagename"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idTableCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.imageArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Private

-(void)loadPreviousLearning{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"imagename"]) {
        self.imageView.image = [UIImage imageNamed:[defaults objectForKey:@"imagename"]];
        
        cv::Mat image = [ImageUtils cvMatFromUIImage: self.imageView.image];
        
        //get gray image
        cv::Mat gray;
        cvtColor(image, gray, CV_BGRA2GRAY);
        
        //mser with maximum area is
        std::vector<cv::Point> maxMser = [ImageUtils maxMser: &gray];
        
        [self.mserView setImage:[ImageUtils UIImageFromCVMat: [ImageUtils mserToMat:&maxMser]]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [[NSMutableArray alloc] init];
    [self.imageArray addObject:@"Cocacola Logo"];
    [self.imageArray addObject:@"Microsoft_logo"];
    [self.imageArray addObject:@"traffic_stop_sign"];
    [self.imageArray addObject:@"green-recycling-symbol"];
    [self.imageArray addObject:@"coke_bottle"];
    
    [self loadPreviousLearning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
