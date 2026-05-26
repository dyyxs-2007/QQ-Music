//
//  STViewController.m
//  网易云音乐imit
//
//  Created by 秋雨梧桐叶落莳 on 2026/5/25.
//

#import "STViewController.h"
#import <Masonry/Masonry.h>
#import "CellModel.h"
#import "SectionSettingModel.h"
#import "SettingTableViewCell.h"
@interface STViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation STViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    [self setupTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    SectionSettingModel *sectionModel = self.section[indexPath.section];
    CellModel *modelNow = sectionModel.cell[indexPath.row];
    [cell configWithModel:modelNow];
    __weak typeof(self) weakSelf = self;
    cell.switchLight = ^(CellModel * _Nonnull model, BOOL isOn) {
        modelNow.isOn = isOn;
        if ([model.title isEqualToString:@"黑夜模式"]) {
            if (isOn == YES) {
                weakSelf.view.window.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
            } else {
                weakSelf.view.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
            }
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    SectionSettingModel *sectionModel = self.section[section];
    return sectionModel.title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.section.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionSettingModel *model = self.section[section];
    return model.cell.count;
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tintColor = [UIColor systemGroupedBackgroundColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self.view);
        make.left.equalTo(self.view).offset(8);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController setTabBarHidden:NO];
}
@end
