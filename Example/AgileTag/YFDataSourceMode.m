//
//  YFDataSourceMode.m
//  AgileTag
//
//  Created by YaFei on 2017/4/9.
//  Copyright © 2017年 YaFei. All rights reserved.
//

#import "YFDataSourceMode.h"

@implementation YFDataSourceMode

- (instancetype)init{
    self = [super init];
    if (self) {
        
        
        self.dataArray = [[NSMutableArray alloc] init];
        self.selectedArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)loadData{
    NSArray *tempArray = @[@"文艺小青年",@"狮子座",@"90后",@"乐观",@"懵逼",@"轻度强迫症",@"密集恐惧症",@"孤僻",@"幽默",@"社交恐惧症",@"萌",@"音乐达人",@"优秀少先队员",@"2",@"不健身会死的运动达人",@"听音乐",@"民谣热",@"手机依赖症",@"成熟稳重的大叔",@"新时代愤青",@"燃",@"多重人格",@"严重人格分裂",@"抠脚大叔",@"程序员妹纸",@"加班狂魔",@"单身狗",@"电影",@"旅行的意义",@"爱幻想",@"现实主义",@"iOS开发",@"暖男"];
    
    [self.dataArray addObjectsFromArray:tempArray];
}

@end
