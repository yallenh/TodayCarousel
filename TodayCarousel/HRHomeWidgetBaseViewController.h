//
//  HRHomeWidgetBaseViewController.h
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/24/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRHomeWidgetBaseViewController : UIViewController

- (UIView *)loadViewFromNibNamed:(NSString *)nibName;
- (void)addSubView:(UIView *)subView;

@end
