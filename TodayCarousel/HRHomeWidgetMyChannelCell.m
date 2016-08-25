//
//  HRHomeWidgetMyChannelCell.m
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/25/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRHomeWidgetMyChannelCell.h"

@interface HRHomeWidgetMyChannelCell ()

@property (weak, nonatomic) IBOutlet UIButton *followButton;


@end

@implementation HRHomeWidgetMyChannelCell

#pragma mark Life Cycles

#pragma mark Public Methods

+ (NSString*)nibName
{
    return NSStringFromClass(self);
}

- (void)awakeFromNib
{
    CALayer *layer = self.followButton.layer;
    layer.borderColor = [UIColor colorWithRed:70.f/255.f green:78.f/255.f blue:86.f/255.f alpha:1.f].CGColor;
    layer.borderWidth = 1.f;
}

@end
