//
//  YFAgileTagView.h
//  Pods
//
//  Created by YaFei on 2017/4/5.
//
//

#import <UIKit/UIKit.h>

@class YFTagItemView;

typedef void(^FinalHeightBlock)(CGFloat height);
typedef void(^DidClickTagBlock)(YFTagItemView *tagItem);

typedef enum {
    DynamicTag = 10,
    StaticTag
}TagViewType;

@interface YFAgileTagView : UIView

@property (nonatomic, assign) TagViewType type;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectedDataArray;//标记选中的，防止重复选中

@property (nonatomic, assign) CGFloat intervalHorizontal; //Tag 之间的水平间隙
@property (nonatomic, assign) CGFloat intervalVertical; //Tag 之间的竖直间隙

@property (nonatomic, assign) NSInteger rows;  //总行数
@property (nonatomic, assign) CGFloat totalHeight; //最后视图的高度

@property (nonatomic, copy) FinalHeightBlock finalHeightBlock;
@property (nonatomic, copy) DidClickTagBlock didClickTagBlock;

- (instancetype)initWithTagType:(TagViewType)type;

- (void)addTagWithTitle:(NSString *)title WithAnimation:(BOOL)animation completed:(void (^)(void))completed;

- (void)removeTagWithTitle:(NSString *)title WithAnimation:(BOOL)animation completed:(void (^)(void))completed;

@end
@interface UIImage (ImageCategory)
+ (instancetype)imageForColor:(UIColor *)color size:(CGSize)size;
@end
