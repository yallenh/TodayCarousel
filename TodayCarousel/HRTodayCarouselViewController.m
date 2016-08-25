//
//  HRTodayCarouselViewController.m
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/24/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRTodayCarouselViewController.h"
#import "HRTodayCarouselCard.h"

#define TODAYCAROUSEL_CARD_VERTICAL_SCROLLABLE

@interface HRTodayCarouselViewController () <UIScrollViewDelegate>
// constants
@property (nonatomic) CGFloat todayCarouselHeight;
@property (nonatomic) CGFloat imageViewMarginBottom;
@property (nonatomic) CGFloat scrollViewMarginX;
@property (nonatomic) CGFloat cardHeight;
@property (nonatomic) CGFloat cardMargin;
@property (nonatomic) CGFloat cardCornerRadius;
@property (nonatomic) CGSize cardShadowOffset;
@property (nonatomic) CGFloat cardShadowRadius;
@property (nonatomic) CGFloat cardUnFocusedScale;
@property (nonatomic) CGColorRef cardShadowColor;
@property (nonatomic) CGFloat indicatorViewHeight;

// private variables
@property (nonatomic) NSUInteger currentIndex;

// data source
@property (nonatomic) NSArray *dataSource;

// UI
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;
@end

@implementation HRTodayCarouselViewController

#pragma mark Life Cycles
- (instancetype)init
{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // resize
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(CGRectGetWidth(self.view.frame), self.todayCarouselHeight);
    self.view.frame = frame;
    self.view.backgroundColor = [UIColor clearColor];
    
    // get data
    [self getDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Methods
- (void)setUp
{
    _todayCarouselHeight = 300.f;
    _imageViewMarginBottom = 40.f;
    _scrollViewMarginX = 22.f;
    _cardHeight = 136.f;
    _cardMargin = 5.f;
    _cardCornerRadius = 1.5f;
    _cardShadowOffset = CGSizeMake(0, 3.f);
    _cardShadowRadius = 4.f;
    _cardUnFocusedScale = 0.8f;
    _cardShadowColor = [[UIColor colorWithWhite:0.0 alpha:0.1] CGColor];
    _indicatorViewHeight = 30.f;
    _dataSource = @[];
    _currentIndex = 0;
}

- (void)getDataSource
{
    _dataSource = @[
                    @{@"img": [UIColor redColor]},
                    @{@"img": [UIColor orangeColor]},
                    @{@"img": [UIColor yellowColor]},
                    @{@"img": [UIColor greenColor]},
                    @{@"img": [UIColor blueColor]},
                    @{@"img": [UIColor purpleColor]}
                    ];
    [self setUpTodayCarousel];
}

- (void)setUpTodayCarousel
{
    if (![self.dataSource count]) {
        return;
    }
    
    CGFloat todayWidth = CGRectGetWidth(self.view.frame);
    CGFloat scrollViewWidth = todayWidth - 2 * self.scrollViewMarginX;
    CGFloat scrollViewHeight = self.todayCarouselHeight - self.indicatorViewHeight;
    NSUInteger numberOfCards = [self.dataSource count];
    
    // data source
    /*
     NSMutableArray *newDataSource = [NSMutableArray arrayWithArray:self.dataSource];
     [newDataSource insertObject:[newDataSource lastObject] atIndex:0];
     self.dataSource = newDataSource;
     */
    
    // image view
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, todayWidth, self.todayCarouselHeight - self.imageViewMarginBottom)];
        [self.view addSubview:_imageView];
    }
    _imageView.backgroundColor = [[self.dataSource objectAtIndex:0] objectForKey:@"img"];
    
    // page indicator view
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.todayCarouselHeight - self.indicatorViewHeight, todayWidth, self.indicatorViewHeight)];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:30.f / 255.f alpha:.3f];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:40.f / 255.f alpha:1.f];
        [self.view addSubview:_pageControl];
    }
    _pageControl.numberOfPages = numberOfCards;
    _pageControl.currentPage = self.currentIndex;
    
    // card view
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.scrollViewMarginX, 0, scrollViewWidth, scrollViewHeight)];
        _scrollView.clipsToBounds = NO;
        _scrollView.contentOffset = CGPointMake(scrollViewWidth * self.currentIndex, 0);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    _scrollView.contentSize = CGSizeMake(scrollViewWidth * numberOfCards, scrollViewHeight);
    
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGRect containerFrame = CGRectMake(scrollViewWidth * idx + _cardMargin, scrollViewHeight - _cardHeight, scrollViewWidth - 2 * _cardMargin, _cardHeight);
        HRTodayCarouselCard *card = [[HRTodayCarouselCard alloc] init];
        
#ifdef TODAYCAROUSEL_CARD_VERTICAL_SCROLLABLE
        UIScrollView *verticalScrollContainer = [[UIScrollView alloc] initWithFrame:containerFrame];
        verticalScrollContainer.alwaysBounceVertical = YES;
        verticalScrollContainer.backgroundColor = [UIColor clearColor];
        verticalScrollContainer.clipsToBounds = NO;
        
        card.frame = CGRectMake(0, 0, CGRectGetWidth(verticalScrollContainer.frame), CGRectGetHeight(verticalScrollContainer.frame));
        [verticalScrollContainer addSubview:card];
        [_scrollView addSubview:verticalScrollContainer];
#else
        card.frame = containerFrame;
        [_scrollView addSubview:card];
#endif
        
        card.categoryIcon.backgroundColor = [obj objectForKey:@"img"];
        card.category.textColor = [obj objectForKey:@"img"];
        
        // shadow
        CALayer *layer = card.layer;
        layer.cornerRadius = _cardCornerRadius;
        layer.shadowColor = _cardShadowColor;
        layer.shadowOffset = _cardShadowOffset;
        layer.shadowOpacity = 1.f;
        layer.rasterizationScale = [[UIScreen mainScreen] scale];
        layer.shouldRasterize = YES;
        layer.shadowRadius = _cardShadowRadius;
        
        // scale
        if (idx != _currentIndex) {
            [card setNeedsTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1, self.cardUnFocusedScale)];
        }
    }];
}

- (void)setCurrentIndex:(NSUInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self.pageControl setCurrentPage:self.currentIndex];
    self.imageView.backgroundColor = [[self.dataSource objectAtIndex:self.currentIndex] objectForKey:@"img"];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    NSInteger currentPage = ((self.scrollView.contentOffset.x - width / 2.f) / width) + 1;
    
    NSArray *cards = [self.scrollView subviews];
    NSUInteger total = [self.dataSource count];
    CGFloat percentageConstant = self.scrollView.contentOffset.x / width + 1.f;
    // NOTE: (allenh) percentageConstant is from:
    // ((self.scrollView.contentOffset.x + width) - inspectIndex * width) / width;
    
    for (NSInteger index = currentPage - 1; index <= currentPage + 1; index++) {
        UIView *card = nil;
        if (index == currentPage - 1 && currentPage > 0) {
            card = [cards objectAtIndex:currentPage - 1];
        }
        else if (index == currentPage) {
            card = [cards objectAtIndex:currentPage];
        }
        else if ((index == currentPage + 1) && (currentPage < total - 1)) {
            card = [cards objectAtIndex:currentPage + 1];
        }
        if (card) {
#ifdef TODAYCAROUSEL_CARD_VERTICAL_SCROLLABLE
            card = [[card subviews] objectAtIndex:0];
#endif
            CGFloat percentage = percentageConstant - index;
            if (percentage > 1.f) {
                percentage = 1.f - (percentage - 1.f);
            }
            if (percentage >= 0 && percentage <= 1.f) {
                card.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.f, (1.f - _cardUnFocusedScale) * percentage + _cardUnFocusedScale);
            }
        }
    }
    
    if (currentPage != self.currentIndex) {
        self.currentIndex = currentPage;
    }
}

@end
