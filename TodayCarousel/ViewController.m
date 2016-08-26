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

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) CGFloat yOffset;
@property (nonatomic) BOOL scrollViewShouldShowMore;
@property (nonatomic) CGFloat yOffsetShowMore;
@property (nonatomic) NSMutableArray *moduleViewQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:241.f/255.f green:241.f/255.f blue:245.f/255.f alpha:1.f];

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        self.scrollViewShouldShowMore = NO;
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

    // show more modules
    [self addModule:[[HRHomeWidgetBaseViewController alloc] init] withBottomSpacing:20.f];
    self.yOffsetShowMore = self.yOffset;
    self.yOffset -= 320.f;


    [[[self.moduleViewQueue reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [_scrollView addSubview:view];
    }];

    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), self.yOffset);
}

- (void)addModule:(UIViewController *)vc withBottomSpacing:(CGFloat)bottomSpacing
{
    if (vc) {
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [self.moduleViewQueue addObject:vc.view];

        CGRect frame = vc.view.frame;
        frame.origin = CGPointMake(frame.origin.x, self.yOffset);
        vc.view.frame = frame;

        self.yOffset = CGRectGetMaxY(frame);
    }
    self.yOffset += bottomSpacing;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.y + self.scrollView.frame.size.height >= self.yOffset) {
        self.scrollViewShouldShowMore = YES;
    }
    else {
        self.scrollViewShouldShowMore = NO;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.yOffset);
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollViewShouldShowMore) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.yOffsetShowMore);
    }
    else {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.yOffset);
    }
}

@end
