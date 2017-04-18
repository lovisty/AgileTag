//
//  YFTagItemView.m
//  AgileTag
//
//  Created by YaFei on 2017/4/9.
//  Copyright © 2017年 YaFei. All rights reserved.
//

#define ImageWidth 16

#import "YFTagItemView.h"
#import "YFBaseAnimation.h"

@interface YFTagItemView ()
@property (nonatomic, strong) UIImageView *badgeView;
@end

@implementation YFTagItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configTagShape];
        [self addTarget:self action:@selector(itemDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/*

 if you want to custom your tag ,please inherit the class , and then override this method.
 
*/
- (void)configTagShape{
    
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5;
    
    self.marginHorizontal = 5;
    self.marginVertical = 5;
}

- (void)setBadge:(UIImage *)badge{
    _badge = badge;
    [self setImage:_badge forState:UIControlStateNormal];
    
   
}

- (void)itemDidClick:(YFTagItemView *)button{
    if ([self.delegate respondsToSelector:@selector(didClickTag:)]) {
        [self.delegate performSelector:@selector(didClickTag:) withObject:button];
    }
}

- (CGSize)intrinsicContentSize {
    CGSize size = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    CGFloat d = 0.0;
    if (self.badge) {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -ImageWidth-2, 0, ImageWidth+2)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, size.width+2, 0, -size.width-2)];
        d = ImageWidth;
    }
    size.height = self.titleLabel.font.pointSize + self.marginVertical * 2;
    size.width += self.marginHorizontal * 2 + d;
    
    return size;
}

- (void)updateFrame:(CGRect)frame{
    self.frame = frame;
    self.badgeView.center = CGPointMake(self.frame.size.width-2, 2);
}

- (void)startShowAnimationCompleted:(void (^)(void))completed{
    CAAnimation *animation = [YFBaseAnimation addAnimation];
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"AddAnimation"];
    [self.badgeView.layer addAnimation:animation forKey:@"AddAnimation"];
    completed?self.showAnimationCompleted = completed:nil;
    
}

- (void)startDismissAnimationCompleted:(void (^)(void))completed{
    CAAnimation *animation = [YFBaseAnimation removeAnimation];
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"RemoveAnimation"];
    [self.badgeView.layer addAnimation:animation forKey:@"RemoveAnimation"];
    completed?self.dismissAnimationCompleted = completed:nil;
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([self.layer animationForKey:@"AddAnimation"] == anim) {
        [self.layer removeAnimationForKey:@"AddAnimation"];
        self.showAnimationCompleted?self.showAnimationCompleted():nil;
    }else if ([self.layer animationForKey:@"RemoveAnimation"] == anim){
        [self.layer removeAnimationForKey:@"RemoveAnimation"];
        self.dismissAnimationCompleted?self.dismissAnimationCompleted():nil;
        
    }
}

@end
