![image](http://7xpeqq.com1.z0.glb.clouddn.com/无限循环分页.gif)

```
#import <UIKit/UIKit.h>

@interface AMInfiniteScrollPage : UIView

/** 图片名 */
@property (strong, nonatomic) NSArray *imageNames;

/** 设置自动跳转时间 */
@property (assign, nonatomic) NSTimeInterval timeInterval;

/** 设置右下角点点的选中颜色 */
@property (strong, nonatomic) UIColor *currentPageIndicatorTintColor;

/** 设置右下角点点未选中时的颜色 */
@property (strong, nonatomic) UIColor *pageIndicatorTintColor;

/** 设置右下角点点的位置 */
@property (assign, nonatomic) CGPoint pageControllerCenter;

@end

```

### Only Use Three ImageView

![image](http://7xpety.com1.z0.glb.clouddn.com/分页实现思路.png)