//
//  ViewController.m
//  LunchImageTest
//
//  Created by ckl@pmm on 2017/12/28.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    lab.font = [UIFont boldSystemFontOfSize:22];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"欢迎来到主界面";
    [self.view addSubview:lab];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
