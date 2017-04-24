//
//  YFAgileTagView.m
//  Pods
//
//  Created by YaFei on 2017/4/5.
//
// 

#import "YFAgileTagView.h"
#import "YFTagItemView.h"
#import "YFBaseAnimation.h"
#import "YFBaseAnimation.h"

@interface YFAgileTagView ()<ItemDidCickDelegate>
{
    CGRect lastframe;
}
@end


@implementation YFAgileTagView

- (instancetype)initWithTagType:(TagViewType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)setSelectedDataArray:(NSMutableArray *)selectedDataArray{
    _selectedDataArray = [[NSMutableArray alloc] initWithArray:selectedDataArray];
}

//用于展示所有Tag
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = [[NSMutableArray alloc] initWithArray:dataArray];
    if (self.subviews.count==0) {
        [self initData];
    }
    [self updateData];
}

- (void)setIntervalVertical:(CGFloat)intervalVertical{
    _intervalVertical = intervalVertical;
}

- (void)setIntervalHorizontal:(CGFloat)intervalHorizontal{
    _intervalHorizontal = intervalHorizontal;
}

- (void)initData{
    for (int i = 0; i<_dataArray.count;i++) {
        NSString *title = _dataArray[i];
        YFTagItemView *item = [self creatTagWithTitle:title isAddAction:NO];
        
        [self addSubview:item];
    }
}

//用于刷新变动的所有Tag
- (void)updateData{
    lastframe = CGRectZero;
    self.rows = 1;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[YFTagItemView class]]) {
            YFTagItemView *item = (YFTagItemView *)view;
            if (self.type == StaticTag && [self.selectedDataArray containsObject:item.currentTitle]) {
                item.selected = YES;
            }else{
                item.selected = NO;
            }
            CGSize size = [item intrinsicContentSize];
            CGRect frame = CGRectMake(lastframe.origin.x+lastframe.size.width+((lastframe.size.width==0)?0:_intervalHorizontal), lastframe.origin.y, size.width, size.height);
            frame = [self reviseFrame:frame];
            if (item.isFresh) {
                item.isFresh = NO;
                [item startShowAnimationCompleted:nil];
            }else{
                if (self.type == DynamicTag) {
                    [UIView animateWithDuration:0.35 animations:^{
                        item.frame = frame;
                    }];
                }else{
                    
                
                }
            }
            [item updateFrame:frame];
        }
    }
    self.totalHeight = self.rows*lastframe.size.height+(self.rows-1)*self.intervalVertical;
    if (self.finallyHeightBlock && self.subviews.count>0) {
        self.finallyHeightBlock(self.totalHeight);
    }
}

- (YFTagItemView *)creatTagWithTitle:(NSString *)title isAddAction:(BOOL)addAction{
    YFTagItemView *item = [[YFTagItemView alloc] initWithFrame:CGRectZero];
    item.delegate = self;
    item.isFresh = addAction;
    [item setTitle:title forState:UIControlStateNormal];
    if (self.type == DynamicTag) {
        [item setBadge:[UIImage imageNamed:@"delete"]];
    }else{
         [item setBadge:[UIImage imageNamed:@"add"]];
    }
    return item;
}

- (CGRect)reviseFrame:(CGRect)originalFrame{
    CGRect targetFrame = originalFrame;
    if (originalFrame.origin.x + originalFrame.size.width > self.frame.size.width) {
        targetFrame.origin.x = 0;
        targetFrame.origin.y += (originalFrame.size.height+self.intervalVertical);
        self.rows++;
    }
    lastframe = targetFrame;
    return targetFrame;
}





#pragma mark - ItemDidCickDelegate

- (void)didClickTag:(YFTagItemView *)tag{
    if (self.didClickedTagBlock) {
        self.didClickedTagBlock(tag);
    }
}

#pragma mark - Public method

- (void)addTagWithTitle:(NSString *)title WithAnimation:(BOOL)animation completed:(void (^)(void))completed{
    [_dataArray addObject:title];
    YFTagItemView *item = [self creatTagWithTitle:title isAddAction:YES];
    [self addSubview:item];
    [self updateData];
    completed();
}

- (void)removeTagWithTitle:(NSString *)title WithAnimation:(BOOL)animation completed:(void (^)(void))completed{
    [_dataArray removeObject:title];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[YFTagItemView class]]) {
            YFTagItemView *item = (YFTagItemView *)view;
            if ([item.currentTitle isEqualToString:title]) {
                [item startDismissAnimationCompleted:^{
                    [item removeFromSuperview];
                    [self updateData];
                    completed();
                }];
                break;
            }
        }
    }
    
}

@end

#pragma mark -

@implementation UIImage (ImageCategory)

+ (instancetype)imageForColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, (CGRect) {CGPointZero, size});
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

