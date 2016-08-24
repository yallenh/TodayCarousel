//
//  HRTodayCarouselCard.m
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/24/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRTodayCarouselCard.h"

@interface HRTodayCarouselCard ()
@property (nonatomic) CGAffineTransform needsTransform;
@end

@implementation HRTodayCarouselCard

#pragma mark Life Cycles
- (instancetype)init
{
    self = [[[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner:self options: nil] firstObject];
    if (self) {
        self.needsTransform = CGAffineTransformIdentity;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!CGAffineTransformIsIdentity(_needsTransform)) {
        self.transform = _needsTransform;
        _needsTransform = CGAffineTransformIdentity;
    }
}


#pragma mark Public Methods
- (void)setNeedsTransform:(CGAffineTransform)transform
{
    _needsTransform = transform;
}

@end
