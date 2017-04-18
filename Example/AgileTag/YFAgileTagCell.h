//
//  YFAgileTagCell.h
//  Pods
//
//  Created by YaFei on 2017/4/5.
//
//

#import <UIKit/UIKit.h>
#import "YFAgileTagView.h"

@interface YFAgileTagCell : UITableViewCell

@property (nonatomic, strong) YFAgileTagView *tagView;
@property (nonatomic, strong) NSArray *selectedDatas; //标记选中的，防止重复选中

- (void)configData:(NSArray *)datas withType:(TagViewType)type;

@end
