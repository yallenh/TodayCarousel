//
//  HRHomeWidgetMyViewController.m
//  TodayCarousel
//
//  Created by Yan-Hsiang Huang on 8/25/16.
//  Copyright © 2016 Yahoo. All rights reserved.
//

#import "HRHomeWidgetMyViewController.h"
#import "HRHomeWidgetMyChannelCell.h"

@interface HRHomeWidgetMyViewController ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate
>
@property (weak, nonatomic) IBOutlet UICollectionView *channelCollectionView;

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
