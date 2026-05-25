//
//  SettingViewController.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/11.
//

#import "SettingViewController.h"
#import <Masonry/Masonry.h>

@interface SettingViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *picture;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupUI {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.layer.cornerRadius = 4;
    [self.view addSubview:self.scrollView];
    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = self.picture.count - 2;
    self.pageControl.currentPage = 0;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.pageIndicatorTintColor = [UIColor tertiaryLabelColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor labelColor];
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView).offset(-8);
        make.right.equalTo(self.scrollView);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(8);
        make.height.mas_equalTo(240);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    UIView *prev = nil;
    for (NSInteger i = 0; i < self.picture.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.picture[i]]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.centerY.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            if (0 == i) {
                make.left.equalTo(self.contentView);
            } else if (i == self.picture.count - 1) {
                make.left.equalTo(prev.mas_right);
                make.right.equalTo(self.contentView);
            } else {
                make.left.equalTo(prev.mas_right);
            }
        }];
        prev = imageView;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currX = scrollView.contentOffset.x;
    CGFloat width = self.scrollView.bounds.size.width;
    
    if (currX <= 0) {
        [scrollView setContentOffset:CGPointMake(width * (self.picture.count - 2), 0) animated:NO];
    } else if (currX >= width * (self.picture.count - 1)) {
        [scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    }
    
    currX = scrollView.contentOffset.x;
    self.pageControl.currentPage = currX / width - 1;
}

- (void)setupData {
    self.picture = [NSMutableArray array];
    NSArray *arr = @[
        @"005",
        @"001",
        @"002",
        @"003",
        @"004",
        @"005",
        @"001"
    ];
    [self.picture addObjectsFromArray:arr];
}

- (void)startTimer {
    if (nil != self.timer) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf.scrollView setContentOffset:CGPointMake(weakSelf.scrollView.bounds.size.width + weakSelf.scrollView.contentOffset.x, 0) animated:YES];
    }];
}

- (void)nilTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self nilTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startTimer];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self nilTimer];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    static BOOL isOffset = NO;
    if (isOffset == NO) {
        isOffset = YES;
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0) animated:NO];
    }
}

@end
