//
//  ViewController.m
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/22/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ViewController.h"
#import "TodayCarouselController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    TodayCarouselController *tcController = [[TodayCarouselController alloc] init];

    [self addChildViewController:tcController];

    CGFloat headerHeight = 100.f;
    CGFloat todayHeight = 300.f;
    CGRect frame = CGRectMake(0, headerHeight, CGRectGetWidth(self.view.frame), todayHeight);
    tcController.view.frame = frame;

    [self.view addSubview:tcController.view];

    [tcController didMoveToParentViewController:self];
}


@end
