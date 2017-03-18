//
//  ViewController.h
//  OpenCV Tests
//
//  Created by Yongyang Nie on 11/16/16.
//  Copyright © 2016 Yongyang Nie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource, NSWindowDelegate>

@property (strong) NSMutableArray *array;
@property (strong) NSArray *imageArray;

@property (weak) IBOutlet NSImageView *image;
@property (weak) IBOutlet NSImageView *maxMser;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSTableView *images;

@end

