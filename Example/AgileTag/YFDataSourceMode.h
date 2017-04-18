//
//  YFDataSourceMode.h
//  AgileTag
//
//  Created by YaFei on 2017/4/9.
//  Copyright © 2017年 YaFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFDataSourceMode : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray; //总的Tags
@property (nonatomic, strong) NSMutableArray *selectedArray; //选中的Tags
- (void)loadData; //模拟数据下载
@end
