//
//  HRTodayCarouselCard.h
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/24/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRTodayCarouselCard : UIView
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;


- (void)setNeedsTransform:(CGAffineTransform)transform;

@end
