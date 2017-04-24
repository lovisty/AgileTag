//
//  YFAgileTagCell.m
//  Pods
//
//  Created by YaFei on 2017/4/5.
//
//

#import "YFAgileTagCell.h"

@interface YFAgileTagCell ()

@end


@implementation YFAgileTagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.separatorInset = UIEdgeInsetsMake(0.0000, 0.0000, 0.0000, 0.0000);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tagView = ({
            /*
             为了更灵活的让使用者控制边缘的距离 Tag 默认是紧贴父视图的，你可以通过设置 YFAgileTagView 的 frame,增加 Tag距离 cell 的左边距和上边距。
             
             如下：分别增加了 20 的边距。
             */
            YFAgileTagView *view = [[YFAgileTagView alloc] initWithFrame:CGRectMake(20, 35, [UIScreen mainScreen].bounds.size.width-40, self.frame.size.height)];
            [view setIntervalVertical:10];
            [view setIntervalHorizontal:15];
            view;
        });
        
        [self.contentView addSubview:self.tagView];
    }
    return self;
}

#pragma mark - 重新计算高度
- (void)layoutSubviews{
    [super layoutSubviews];
    self.tagView.frame = CGRectMake(20, 10, [UIScreen mainScreen].bounds.size.width-40, self.frame.size.height - 20);
}

- (void)configData:(NSArray *)datas withType:(TagViewType)type{
    self.tagView.type = type;
    [self.tagView setSelectedDataArray:[self.selectedDatas mutableCopy]];
    [self.tagView setDataArray:[datas mutableCopy]];
}

@end
