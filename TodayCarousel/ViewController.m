//
//  ViewController.m
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/22/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ViewController.h"
#import "HRTodayCarouselViewController.h"

@interface ViewController ()
@property (nonatomic) CGFloat yOffSet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.yOffSet = 100.f;

    HRTodayCarouselViewController *tcVC = [[HRTodayCarouselViewController alloc] init];
    [self addChildViewController:tcVC];
    [tcVC didMoveToParentViewController:self];
    [self.view addSubview:tcVC.view];

    CGRect frame = tcVC.view.frame;
    frame.origin = CGPointMake(0, self.yOffSet);
    tcVC.view.frame = frame;

    self.yOffSet += frame.size.height;
}


@end
