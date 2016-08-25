//
//  HRHomeWidgetMyChannelCell.h
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/25/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRHomeWidgetMyChannelCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UIButton *channelCategory;
@property (weak, nonatomic) IBOutlet UILabel *channelName;
@property (weak, nonatomic) IBOutlet UILabel *channelFollows;

+ (NSString *)nibName;

@end
