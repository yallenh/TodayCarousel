//
//  HRHomeWidgetBaseViewController.m
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/24/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRHomeWidgetBaseViewController.h"

@interface HRHomeWidgetBaseViewController ()
// constants
@property (nonatomic) CGFloat cardDefaultHeight;
@property (nonatomic) CGFloat cardMarginX;
@property (nonatomic) CGFloat cardCornerRadius;
@property (nonatomic) CGSize cardShadowOffset;
@property (nonatomic) CGFloat cardShadowRadius;
@property (nonatomic) CGColorRef cardShadowColor;

// UI
@property (nonatomic) UILabel *widgetNameLabel;
@end

@implementation HRHomeWidgetBaseViewController

- (instancetype)init
{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CALayer *layer = self.view.layer;
    layer.cornerRadius = _cardCornerRadius;
    layer.shadowColor = _cardShadowColor;
    layer.shadowOffset = _cardShadowOffset;
    layer.shadowOpacity = 1.f;
    layer.rasterizationScale = [[UIScreen mainScreen] scale];
    layer.shouldRasterize = YES;
    layer.shadowRadius = _cardShadowRadius;

    self.view.frame = CGRectMake(self.cardMarginX, 0, CGRectGetWidth(self.view.frame) - 2.f * self.cardMarginX, self.cardDefaultHeight);
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark Public Methods
- (UIView *)loadViewFromNibNamed:(NSString *)nibName
{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject];
    view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(view.frame));
    return view;
}
- (void)addSubView:(UIView *)subView
{
    CGRect frame = self.view.frame;
    frame.size.height = CGRectGetHeight(subView.frame);
    self.view.frame = frame;
    [self.view addSubview:subView];
}


#pragma mark Private Methods
- (void)setUp
{
    _cardDefaultHeight = 300.f;
    _cardMarginX = 12.f;
    _cardCornerRadius = 1.5f;
    _cardShadowOffset = CGSizeMake(0, 1.f);
    _cardShadowRadius = 2.f;
    _cardShadowColor = [[UIColor colorWithWhite:0.0 alpha:0.2] CGColor];
}

@end
