//
//  AMInfiniteScrollPage.m
//  AMInfiniteScrollPage
//
//  Created by 李朝 on 15/12/22.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import "AMInfiniteScrollPage.h"

static int const imageViewCount = 3;

@interface AMInfiniteScrollPage () <UIScrollViewDelegate>

/** scrollView */
@property (weak, nonatomic) UIScrollView *scrollView;

/** pageController */
@property (weak, nonatomic) UIPageControl *pageController;

/** 用来记录当前3个 imageView 显示的页码 */
@property (strong, nonatomic) NSMutableArray *theCurrentPages;

/** 添加定时器 */
@property (weak, nonatomic) NSTimer *timer;

@end


@implementation AMInfiniteScrollPage


#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 创建并设置 scrollView
        [self setupScrollView];
    }
    return self;
}

- (void)setupScrollView
{
    // 首先去掉滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    // 然后去掉弹簧效果
    self.scrollView.bounces = NO;
    
    // 添加分页效果
    self.scrollView.pagingEnabled = YES;
    
    // 允许用户交互
    self.scrollView.userInteractionEnabled = YES;
    
    // 设置代理
    self.scrollView.delegate = self;
    
    // 添加图片控件
    for (NSInteger i = 0; i < imageViewCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageView];
    }
}


#pragma mark - 布局子控件

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置 scrollView 的尺寸
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * imageViewCount, 0);
    
    // 设置图片的尺寸和位置
    for (NSInteger i = 0; i < imageViewCount; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.backgroundColor = [UIColor redColor];
        
        imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }
    
    // 设置 pageController
    CGFloat pageWidth = 80;
    CGFloat pageHeight = 20;
    CGFloat pageX = self.bounds.size.width - pageWidth - 5;
    CGFloat pageY = self.bounds.size.height - pageHeight - 10;
    self.pageController.frame = CGRectMake(pageX, pageY, pageWidth, pageHeight);
    
    // 设置内容
    [self addImageToImageView];
}


#pragma mark - 设置 getter 和 setter
- (void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    
    // 设置 pageController
    self.pageController.numberOfPages = imageNames.count;
    self.pageController.currentPage = 0;
    
    // 更新 imageView 图片
    [self addImageToImageView];
}


/**
 * 开启定时器方法
 */
- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    _timeInterval = timeInterval;
    
    // 创建定时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = timer;
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 * 跳转下一页
 */
- (void)nextPage
{
    [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];
}

/**
 * 停止定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 添加图片

/**
 * 添加图片到 imageView 中去
 */
- (void)addImageToImageView
{
    // 清空当前 currentPages 数组
    [self.theCurrentPages removeAllObjects];
    
    for (NSInteger i = 0 ; i < imageViewCount; i++) {
        
        // 取出 imageView
        UIImageView *imageView = self.scrollView.subviews[i];
        
        // 取出当前页码
        NSInteger index = self.pageController.currentPage;
        
        if (i == 0) {
            // 如果是第一个 imageView，所对应的图片名在图片数组中的位置应该是: index - 1
            index--;
        } else if (i == 2) {
            // 如果是第三个 imageView，所对应的图片名在图片数组中的位置应该是: index + 1
            index++;
        }
        
        // 判断是否是第一张图片或者是最后一张图片
        if (index < 0) {
            // 当前显示第一张图片
            index = self.pageController.numberOfPages - 1;
        } else if (index == self.pageController.numberOfPages) {
            // 当前显示最后一张图片
            index = 0;
        }
        
        imageView.image = [UIImage imageNamed:self.imageNames[index]];
        [self.theCurrentPages addObject:@(index)];
    }
    
    // 设置偏移量始终在中间
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
}


#pragma mark - UIScrollViewDelegate

/**
 * 滚动时会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 找出中间的 imageView 的页码
    NSInteger cunrrentPage = 0;
    
    if (self.scrollView.contentOffset.x >= 0.5 * self.scrollView.contentSize.width) {
        
        // 当向左划超过 imageView 一半的尺寸时
        cunrrentPage = [self.theCurrentPages[imageViewCount - 1] integerValue];
    } else if (self.scrollView.contentOffset.x >= 0.5 * self.scrollView.frame.size.width) {
        
        // 当向左或者向右滑都未超过一半 imageView 的尺寸时
        cunrrentPage = [self.theCurrentPages[imageViewCount - 2] integerValue];
    } else {
        // 向右滑超过 imageView 一半的尺寸时
        cunrrentPage = [self.theCurrentPages[imageViewCount - 3] integerValue];
    }
    
    self.pageController.currentPage = cunrrentPage;
}

/**
 * 用户快要停止拖拽时调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 更新状态
    [self addImageToImageView];
}

/**
 * contentOffset 属性改变时
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addImageToImageView];
}

/**
 * scrollView 马上被用户拖拽时
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 * scrollView 用户停止拖拽时
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setTimeInterval:self.timeInterval];
}

#pragma mark - 懒加载子控件

/**
 * 创建 scrollView
 */
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        
        _scrollView = scrollView;
        
        [self addSubview:scrollView];
    }
    return _scrollView;
}

/**
 * 创建 pageController
 */
- (UIPageControl *)pageController
{
    if (_pageController == nil) {
        
        UIPageControl *pageController = [[UIPageControl alloc] init];
        
        _pageController = pageController;
        
        [self addSubview:pageController];
    }
    return _pageController;
}

/**
 * 创建 theCurrentPages
 */
- (NSMutableArray *)theCurrentPages
{
    if (_theCurrentPages == nil) {
        
        _theCurrentPages = [NSMutableArray array];
    }
    return _theCurrentPages;
}

@end
