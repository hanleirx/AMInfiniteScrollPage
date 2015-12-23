//
//  ViewController.m
//  AMInfiniteScrollPage
//
//  Created by 李朝 on 15/12/22.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import "ViewController.h"
#import "AMInfiniteScrollPage.h"

@interface ViewController () <AMInfiniteScrollPageDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AMInfiniteScrollPage *page = [[AMInfiniteScrollPage alloc] init];
    page.imageNames = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
    page.frame = CGRectMake(30, 50, 300, 130);
    
    // 设置代理
    page.delegate = self;
    
    // 设置自动跳转页面的间隔时间
    page.timeInterval = 1.5;
    
    // 设置右下角点点的颜色
    page.pageIndicatorTintColor = [UIColor redColor];
    page.currentPageIndicatorTintColor = [UIColor greenColor];
    
    // 设置右下角点点的位置
    page.pageControllerCenter = CGPointMake(100, 100);
    
    [self.view addSubview:page];
}

#pragma mark - AMInfiniteScrollPageDelegate

- (void)infiniteScrollPage:(AMInfiniteScrollPage *)infiniteScrollPage didSelectedImageAtIndex:(NSInteger)index
{
    NSLog(@"点击了%@的第%zd张图片", infiniteScrollPage, index);
}


@end
