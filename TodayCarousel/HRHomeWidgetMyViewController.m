//
//  HRHomeWidgetMyViewController.m
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/25/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRHomeWidgetMyViewController.h"
#import "HRHomeWidgetMyChannelCell.h"

#define USER_LOGINED
#define USER_WITH_FOLLOW

static NSString *descUserNotLogined = @"嗨，登入你的Yahoo帳號可以立即啟用我的追蹤功能喔！";
static NSString *descUserLoginedWithoutFollow = @"嗨，你好像尚未追蹤任何頻道，快來追蹤你喜歡的頻道吧！";

@interface HRHomeWidgetMyViewController ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate
>
// UI
@property (weak, nonatomic) IBOutlet UICollectionView *channelCollectionView;
@property (weak, nonatomic) IBOutlet UIView *viewWithoutFollow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWithoutFollowHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UICollectionView *followCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *seeAllButton;

@end

@implementation HRHomeWidgetMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *view = [self loadViewFromNibNamed:@"HRHomeWidgetMyWithoutFollow"];

    // setup collection view
    self.channelCollectionView.dataSource = self;
    self.channelCollectionView.delegate = self;
    self.channelCollectionView.backgroundColor = [UIColor clearColor];
    [self.channelCollectionView registerNib:[UINib nibWithNibName:[HRHomeWidgetMyChannelCell nibName] bundle:nil] forCellWithReuseIdentifier:[HRHomeWidgetMyChannelCell nibName]];

    CGRect frame;
#ifdef USER_LOGINED
    #ifdef USER_WITH_FOLLOW
    self.followCollectionView.hidden = NO;
    self.seeAllButton.hidden = NO;
    self.viewWithoutFollow.hidden = YES;
    self.channelCollectionView.hidden = YES;
    #else
    self.followCollectionView.hidden = YES;
    self.seeAllButton.hidden = YES;
    self.viewWithoutFollow.hidden = NO;
    self.channelCollectionView.hidden = NO;
    self.desc.text = descUserLoginedWithoutFollow;
    self.loginButton.hidden = YES;
    self.viewWithoutFollowHeightConstraint.constant = 119 - 49.f;
    frame = view.frame;
    frame.size = CGSizeMake(CGRectGetWidth(frame), 385.f - 49.f);
    view.frame = frame;
    #endif
#else
    self.followCollectionView.hidden = YES;
    self.seeAllButton.hidden = YES;
    self.viewWithoutFollow.hidden = NO;
    self.channelCollectionView.hidden = NO;
    self.desc.text = descUserNotLogined;
    self.loginButton.hidden = NO;
    self.viewWithoutFollowHeightConstraint.constant = 119.f;
    frame = view.frame;
    frame.size = CGSizeMake(CGRectGetWidth(frame), 385.f);
    view.frame = frame;
#endif

    [self addSubView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Collection View Delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HRHomeWidgetMyChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HRHomeWidgetMyChannelCell nibName] forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(116.f, 204.f);
}

@end
