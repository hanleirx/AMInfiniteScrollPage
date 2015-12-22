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

@end
