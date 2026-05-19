//
//  AvatorChangeViewController.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/19.
//
#import <Masonry/Masonry.h>
#import "AvatorChangeViewController.h"

@interface AvatorChangeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *picture;
@property (nonatomic, strong) UIImageView *avator;
@end

@implementation AvatorChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupBar];
    [self setupUI];
}

- (void)setupBar {
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(tapped)];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)setupData {
    self.picture = [NSMutableArray array];
    NSArray *arr = @[
        @"HeadPicture",
        @"IMG_0154",
        @"IMG_0201",
        @"IMG_0621",
        @"IMG_2048",
        @"IMG_4693",
        @"IMG_4806",
        @"IMG_4813",
        @"IMG_0202",
        @"IMG_0204"
    ];
    [self.picture addObjectsFromArray:arr];
}

- (void)tapped {
    if ([self.delegate respondsToSelector:@selector(changePictureWithImage:)]) {
        [self.delegate changePictureWithImage:self.avator.image];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    self.avator = [[UIImageView alloc] initWithImage:self.avatorImage];
    self.avator.clipsToBounds = YES;
    self.avator.layer.cornerRadius = 50;
    [self.view addSubview:self.avator];
    [self.avator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.centerX.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    layout.itemSize = CGSizeMake(100, 100);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.avator.mas_bottom).offset(24);
    }];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picture.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.picture[indexPath.item]]];
    [cell.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    self.avator.image = [UIImage imageNamed:self.picture[indexPath.item]];
}

@end
