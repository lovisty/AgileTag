 //
//  YFViewController.m
//  AgileTag
//
//  Created by YaFei on 04/02/2017.
//  Copyright (c) 2017 YaFei. All rights reserved.
//


#import "YFViewController.h"
#import "YFDataSourceMode.h"
#import "YFAgileTagCell.h"
static NSString *identifierAstaticism = @"ReuseIdentifierAstaticism";

@interface YFViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YFDataSourceMode *model;

@property (nonatomic, assign) CGFloat astaticismHeight;// 变化的高度  section == 0  时的高度
@property (nonatomic, assign) CGFloat totalHeight; //总高度 section == 1 时候的高度
@end

@implementation YFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.model = [[YFDataSourceMode alloc] init];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [tableView registerClass:[YFAgileTagCell class] forCellReuseIdentifier:identifierAstaticism];
        tableView;
    });
    
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.model loadData];
    
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (self.astaticismHeight + 20 <= 50) { //为了好看，适当的留白。
            return 50;
        }
        return self.astaticismHeight+20;
    }else{
        return self.totalHeight+20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor darkGrayColor];
    if (section == 0) {
        label.text = @"   已选标签";
    }else{
       label.text = @"   全部标签";
    }
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YFAgileTagCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierAstaticism];
        __weak __typeof(self) weakSelf = self;
        cell.tagView.finallyHeightBlock = ^(CGFloat height){
            __strong __typeof(self) strongSelf = weakSelf;
            strongSelf.astaticismHeight = height;
        };
        
        cell.tagView.didClickedTagBlock = ^(YFTagItemView *button) {
            __strong __typeof(self) strongSelf = weakSelf;
            [strongSelf removeTagWithObjct:(UIButton *)button];
        };

        [cell configData:self.model.selectedArray withType:DynamicTag];
        return cell;
    }
    else{
        YFAgileTagCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierAstaticism];
        
        __weak __typeof(self) weakSelf = self;
        cell.tagView.finallyHeightBlock = ^(CGFloat height) {
            __strong __typeof(self) strongSelf = weakSelf;
            strongSelf.totalHeight = height;
        };

        cell.tagView.didClickedTagBlock = ^(YFTagItemView *button) {
            __strong __typeof(self) strongSelf = weakSelf;
            [strongSelf addTagWithObjct:(UIButton *)button];
        };
        
        cell.selectedDatas = [self.model.selectedArray copy];
        [cell configData:self.model.dataArray withType:StaticTag];
        return cell;
    }
}

- (void)addTagWithObjct:(UIButton *)tagItem{
    if (!tagItem.selected) {
        [self.model.selectedArray addObject:tagItem.currentTitle];
        YFAgileTagCell *firstCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        __weak __typeof(self) weakSelf = self;
        [firstCell.tagView addTagWithTitle:tagItem.currentTitle WithAnimation:YES completed:^{
            __strong __typeof(self) strongSelf = weakSelf;
            [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

- (void)removeTagWithObjct:(UIButton *)tagItem{
    [self.model.selectedArray removeObject:tagItem.currentTitle];
    YFAgileTagCell *firstCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
     __weak __typeof(self) weakSelf = self;
    [firstCell.tagView removeTagWithTitle:tagItem.currentTitle WithAnimation:YES completed:^{
        __strong __typeof(self) strongSelf = weakSelf;
        [strongSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

@end
