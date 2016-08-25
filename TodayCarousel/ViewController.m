//
//  ViewController.m
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/22/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "ViewController.h"
#import "HRTodayCarouselViewController.h"
#import "HRHomeWidgetMyViewController.h"

@interface ViewController ()
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) CGFloat yOffSet;
@property (nonatomic) NSMutableArray *moduleViewQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:241.f/255.f green:241.f/255.f blue:245.f/255.f alpha:1.f];

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_scrollView];
    }
    if (!_moduleViewQueue) {
        _moduleViewQueue = [[NSMutableArray alloc] init];
    }

    // assume header height is 100
    [self addModule:nil withBottomSpacing:100.f];

    [self addModule:[[HRTodayCarouselViewController alloc] init] withBottomSpacing:10.f];
    [self addModule:[[HRHomeWidgetBaseViewController alloc] init] withBottomSpacing:20.f];
    [self addModule:[[HRHomeWidgetMyViewController alloc] init] withBottomSpacing:20.f];
    [self addModule:[[HRHomeWidgetBaseViewController alloc] init] withBottomSpacing:20.f];

    [[[self.moduleViewQueue reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [_scrollView addSubview:view];
    }];
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), self.yOffSet);
}

- (void)addModule:(UIViewController *)vc withBottomSpacing:(CGFloat)bottomSpacing
{
    if (vc) {
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [self.moduleViewQueue addObject:vc.view];

        CGRect frame = vc.view.frame;
        frame.origin = CGPointMake(frame.origin.x, self.yOffSet);
        vc.view.frame = frame;

        self.yOffSet = CGRectGetMaxY(frame);
    }
    self.yOffSet += bottomSpacing;
}

@end
