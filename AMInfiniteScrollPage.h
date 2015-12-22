//
//  AMInfiniteScrollPage.h
//  AMInfiniteScrollPage
//
//  Created by 李朝 on 15/12/22.
//  Copyright © 2015年 ammar. All rights reserved.
//

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
