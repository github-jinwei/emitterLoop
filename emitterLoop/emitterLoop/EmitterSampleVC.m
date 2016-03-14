//
//  EmitterSampleVC.m
//  emitterLoop
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 shaiba. All rights reserved.
//

#import "EmitterSampleVC.h"
#import "SYEmitterLoopView.h"
#import "SYLoadingLoopView.h"
@implementation EmitterSampleVC
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationItem];
    [self initEmitter];
}
-(void)initEmitter
{
    SYEmitterLoopView *loopView = [[SYEmitterLoopView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, self.view.bounds.size.height/2-50, 100, 100)];
    [self.view addSubview:loopView];
    SYLoadingLoopView *loadingLoopView = [[SYLoadingLoopView alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
    [self.view addSubview:loadingLoopView];
}
-(void)initNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 30, 30);
    [titleLabel setText:@"我的订单"];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    //    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"top_back"]  forState:UIControlStateNormal];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    
    //    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    
    [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];
}
-(void)clicked
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
