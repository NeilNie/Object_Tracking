//
//  FPS.m
//  LogoDetector
//
//  Created By Yongyang Nie 11/20/2016
//  Copyright (c) 2016 Yongyang Nie. All rights reserved.
//  License:
//  You may not copy, redistribute, use without quoting the author.
//  By using this file, you agree to the following LICENSE:
//  https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode

#import "FPS.h"
#import <sys/time.h>
#import "ImageUtils.h"

@implementation FPS

static long long last;

+(int) tick
{
    struct timeval t;
    gettimeofday(&t, NULL);
    
    long long now = (((long long) t.tv_sec) * 1000) + (((long long) t.tv_usec) / 1000);
    
    int result = (int)(1000.0 / (now - last));
    last = now;
    
    return result;
}

+(void) draw: (cv::Mat) rgb;
{
    int fps = [FPS tick];
    const char* str_fps = [[NSString stringWithFormat: @"FPS: %d", fps] cStringUsingEncoding: NSUTF8StringEncoding];
    
    cv::putText(rgb, str_fps, cv::Point(10, 20), CV_FONT_HERSHEY_PLAIN, 1.0, RED);
}

@end
