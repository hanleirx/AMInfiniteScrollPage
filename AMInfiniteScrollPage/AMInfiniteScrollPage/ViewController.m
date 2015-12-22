//
//  ViewController.m
//  AMInfiniteScrollPage
//
//  Created by 李朝 on 15/12/22.
//  Copyright © 2015年 ammar. All rights reserved.
//

#import "ViewController.h"
#import "AMInfiniteScrollPage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AMInfiniteScrollPage *page = [[AMInfiniteScrollPage alloc] init];
    page.imageNames = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
    page.frame = CGRectMake(30, 50, 300, 130);
    page.timeInterval = 1.5;
    
    [self.view addSubview:page];
}

@end
