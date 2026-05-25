//
//  STViewController.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/25.
//

#import "STViewController.h"
#import <Masonry/Masonry.h>
#import "SwitchStyle.h"
@interface STViewController ()
@property (nonatomic, strong) UISwitch *switchView;
@end

@implementation STViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self setupUI];
}

- (void)setupUI {
    self.switchView = [[UISwitch alloc] init];
    SwitchStyle *style = [SwitchStyle sharedInstance];
    self.switchView.on = style.isOn;
    [self.switchView addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)switchChange {
    SwitchStyle *style = [SwitchStyle sharedInstance];
    style.isOn = self.switchView.isOn;
    if (self.switchView.isOn) {
        self.view.window.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        self.view.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
}

@end
