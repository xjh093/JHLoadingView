//
//  ViewController.m
//  JHLoadingView
//
//  Created by HaoCold on 16/11/7.
//  Copyright © 2016年 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "UIView+JHCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"JHLoadingView";
    
    for (int i = 0; i < 12; i++) {
        UIActivityIndicatorView *aiView = [UIActivityIndicatorView jhAIViewInsuperView:self.view showInfo:@"加载中..." type:i]; //文字可心任意长度
        aiView.jh_x = 30 + (i%3)*90;
        aiView.jh_y = 90 + (i/3)*90;
        [self.view addSubview:aiView];
        [aiView startAnimating];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
