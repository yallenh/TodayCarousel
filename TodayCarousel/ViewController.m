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
@property (nonatomic) CGFloat yOffSet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.yOffSet = 100.f;

    TodayCarouselController *tcController = [[TodayCarouselController alloc] init];
    [self addChildViewController:tcController];
    [tcController didMoveToParentViewController:self];
    [self.view addSubview:tcController.view];

    CGRect frame = tcController.view.frame;
    frame.origin = CGPointMake(0, self.yOffSet);
    tcController.view.frame = frame;

    self.yOffSet += frame.size.height;
}


@end
