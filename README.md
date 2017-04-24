# AgileTag

[![CI Status](http://img.shields.io/travis/YaFei/AgileTag.svg?style=flat)](https://travis-ci.org/YaFei/AgileTag)
[![Version](https://img.shields.io/cocoapods/v/AgileTag.svg?style=flat)](http://cocoapods.org/pods/AgileTag)
[![License](https://img.shields.io/cocoapods/l/AgileTag.svg?style=flat)](http://cocoapods.org/pods/AgileTag)
[![Platform](https://img.shields.io/cocoapods/p/AgileTag.svg?style=flat)](http://cocoapods.org/pods/AgileTag)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS8+

## ScreenShot
![下拉式相册分组](https://github.com/lovisty/AgileTag/blob/master/ScreenShot/demo.gif?raw=true)

## Installation
- 通过CocoaPods安装   

AgileTag 支持通过 [CocoaPods](http://cocoapods.org)进行安装。
在Podfile文件中加上
```ruby
pod "AgileTag"
```
- 直接加项目中使用
```ruby
git clone https://github.com/lovisty/AgileTag   
```
找到包含的文件Classes和Assets的AgileTag文件，直接把AgileTag拖到项目中。

**导入头文件：**
```ruby
#import "YFAgileTagView.h"  
```
## Usage
初始化以及赋值
```ruby
YFAgileTagView *tagView = [[YFAgileTagView alloc] initWithFrame:YOUR_FRAME];
[tagView setIntervalVertical:10];//Tag之间的水平间距
[tagView setIntervalHorizontal:15];//Tag之间的竖直间距
[self addSubview:self.tagView];

//赋值
[self.tagView setSelectedDataArray:DATA_ARRAY];
```
提供的重要接口
```ruby
//返回总高度
self.tagView.finallyHeightBlock = ^(CGFloat height){
  
};

//添加tag
[self.tagView addTagWithTitle:tagItem.currentTitle WithAnimation:YES completed:^{
           
}];

//删除tag
[firstCell.tagView removeTagWithTitle:tagItem.currentTitle WithAnimation:YES completed:^{

}];

注：每次调用添加或者删除tag后，会自动回调finallyHeightBlock返回添加或者删除后的高度，然后回调用completed。
```


## Author

YaFei, nihao1992@163.com
个人博客:http://blog.csdn.net/u013749108
QQ:617267337
## License

AgileTag is available under the MIT license. See the LICENSE file for more info.
