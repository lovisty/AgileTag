//
//  YFBaseAnimation.m
//  AgileTag
//
//  Created by YaFei on 2017/4/9.
//  Copyright © 2017年 YaFei. All rights reserved.
//



#import "YFBaseAnimation.h"

@implementation YFBaseAnimation

+ (CAAnimation *)addAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @0.2;
    animation.toValue   = @1.0;
    animation.duration  = 0.25;
    animation.removedOnCompletion = NO;
    return animation;
}

+ (CAAnimation *)removeAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1.0;
    animation.toValue   = @0.2;
    animation.duration  = 0.3;
    animation.removedOnCompletion = NO;
    return animation;
}

@end
