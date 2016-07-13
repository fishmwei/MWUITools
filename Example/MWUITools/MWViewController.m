//
//  MWViewController.m
//  MWUITools
//
//  Created by huangmingwei on 07/12/2016.
//  Copyright (c) 2016 huangmingwei. All rights reserved.
//

#import "MWViewController.h"
#import "MWCircleProgressView.h"

@interface MWViewController () {
    MWCircleProgressView *pv ;
}

@end

@implementation MWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    pv = [[MWCircleProgressView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:pv];
    [pv setStrokeColor:[UIColor redColor]];
    [pv setCoverWidth:2];
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fire) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:t forMode:NSRunLoopCommonModes];
}


- (void)fire {
    static CGFloat progress = 0;
    progress += 0.1;
    if (progress > 1) {
        progress = 0;
    }
    
    [pv updateProgress:progress];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
