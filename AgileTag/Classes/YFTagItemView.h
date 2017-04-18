//
//  YFTagItemView.h
//  AgileTag
//
//  Created by YaFei on 2017/4/9.
//  Copyright © 2017年 YaFei. All rights reserved.
//

@class YFTagItemView;

@protocol ItemDidCickDelegate <NSObject>

- (void)didClickTag:(YFTagItemView *)tag;

@end

typedef void(^ShowAnimationCompleted)(void);
typedef void(^DismissAnimationCompleted)(void);

#import <UIKit/UIKit.h>

@interface YFTagItemView : UIButton <CAAnimationDelegate>

@property (nonatomic, assign) BOOL isFresh;//即将要操作的那个Tag （为了动画使用）

@property (nonatomic, assign) id<ItemDidCickDelegate> delegate;

@property (nonatomic, assign) CGFloat marginHorizontal; //文字与button的水平边距
@property (nonatomic, assign) CGFloat marginVertical; //文字与button的竖直边距

@property (nonatomic, strong) UIImage *badge;

- (void)updateFrame:(CGRect)frame;

@property (nonatomic, copy) ShowAnimationCompleted showAnimationCompleted;
@property (nonatomic, copy) DismissAnimationCompleted dismissAnimationCompleted;

- (void)startShowAnimationCompleted:(void (^)(void))completed;

- (void)startDismissAnimationCompleted:(void (^)(void))completed;

@end
