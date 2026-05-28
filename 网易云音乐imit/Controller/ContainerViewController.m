//
//  ContainerViewController.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/28.
//

#import "ContainerViewController.h"
#import "ProfileViewController.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "MenuViewController.h"
#import <Masonry/Masonry.h>

static CGFloat const VCWidth = 240.0f;

@interface ContainerViewController ()
@property (nonatomic, strong) MenuViewController *menuVC;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) BOOL isOpen;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMainVC];
    [self setupMenuVC];
    [self setupMask];
}

- (void)setupMainVC {
    UIViewController *mainVC = [self createMain];
    [self addChildViewController:mainVC];
    [self.view addSubview:mainVC.view];
    [mainVC didMoveToParentViewController:self];
    [mainVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupMenuVC {
    self.menuVC = [[MenuViewController alloc] init];
    [self addChildViewController:self.menuVC];
    [self.view addSubview:self.menuVC.view];
    [self.menuVC didMoveToParentViewController:self];
    [self.menuVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-VCWidth);
        make.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(VCWidth);
    }];
}

- (void)setupMask {
    self.maskView = [[UIView alloc] init];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.maskView.alpha = 0;
    self.maskView.userInteractionEnabled = NO;
    
    [self.view insertSubview:self.maskView belowSubview:self.menuVC.view];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu)];
    [self.maskView addGestureRecognizer:tap];
}

- (void)closeMenu {
    [self.menuVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-VCWidth);
    }];
    [UIView animateWithDuration:0.3 animations:^{
            self.maskView.alpha = 0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.isOpen = NO;
        }];
}

- (void)openMenu {
    [self.menuVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
    }];
    self.maskView.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.3 animations:^{
            self.maskView.alpha = 1;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.isOpen = YES;
        }];
}

- (UIViewController *)createMain {
    HomeViewController *home = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage systemImageNamed:@"house"] tag:0];
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    UINavigationController *profileNav = [[UINavigationController alloc] initWithRootViewController:profile];
    profileNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage systemImageNamed:@"person.circle"] tag:0];
    
    SettingViewController *setting = [[SettingViewController alloc] init];
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:setting];
    settingNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"乐馆" image:[UIImage systemImageNamed:@"globe.europe.africa.fill"] tag:0];
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    tabbar.viewControllers = @[homeNav, settingNav, profileNav];
    return tabbar;
}

- (void)switchOpen {
    self.isOpen ? [self closeMenu] : [self openMenu];
}

@end
