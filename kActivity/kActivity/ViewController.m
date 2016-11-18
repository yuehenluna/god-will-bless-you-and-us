//
//  ViewController.m
//  kActivity
//
//  Created by zhaoke on 16/8/18.
//  Copyright © 2016年 zk. All rights reserved.
//

#import "ViewController.h"
#import "ZKGeneralHeader.h"
#import "TestVC.h"

#import "UIButton+Extend.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic, assign) int typeNum;
@property (nonatomic, strong) KLoadingView *loadingView;
@property (nonatomic, strong) KLoadingView2 *loadingView2;
@property (nonatomic, strong) UIView *loadingBgView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 60, 30)];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"哈哈哈" forState:UIControlStateNormal];
    [btn setButtonAction:^(id sender) {
        NSLog(@"you click the button, 哈哈哈 -_-！");
    }];
    [self.view addSubview:btn];
}
- (IBAction)hide:(UIBarButtonItem *)sender {
    switch (self.typeNum) {
        case 1:
            [LoadingView hideLoadingView];
            break;
        case 2:
            [_loadingView stopLoadAnimating];
            [_loadingView removeFromSuperview];
            break;
        case 3:
            [_loadingView2 stopAnimating];
            [_loadingView2 removeFromSuperview];
            [_loadingBgView2 removeFromSuperview];
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        default:
            break;
    }
}
- (IBAction)showType1:(UIButton *)sender {
    self.typeNum = 1;
    [LoadingView showLoadingWithString:@"加载中。。。" withView:self.view];
}
- (IBAction)showType2:(UIButton *)sender {
    self.typeNum = 2;
    _loadingView = [[KLoadingView alloc] init];
    _loadingView.center = self.view.center;
    [self.view addSubview:_loadingView];
//    [[UIApplication sharedApplication].keyWindow addSubview:_loadingView];
    [_loadingView startLoadingAnimating];
}
- (IBAction)showType3:(UIButton *)sender {
    self.typeNum = 3;
    _loadingBgView2 = [[UIView alloc] initWithFrame:self.view.bounds];
    _loadingBgView2.backgroundColor = [UIColor blackColor];
    _loadingBgView2.alpha = 0.8;
    
    _loadingView2 = [[KLoadingView2 alloc] initWithFrame:CGRectMake((_kScreenWidth-80)/2, 200, 80, 80) color:[UIColor redColor]];
    [self.view addSubview:_loadingBgView2];
    [_loadingBgView2 addSubview:_loadingView2];
    [_loadingView2 startLoading];
}
- (IBAction)showType4:(UIButton *)sender {
    self.typeNum = 4;
    TestVC *textVC = [[TestVC alloc] initWithNibName:@"TestVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:textVC animated:YES];
}
- (IBAction)showType5:(UIButton *)sender {
    self.typeNum = 5;
    [ErrorView showError:@"店小二约会去了，暂不提供服务" withShowDuration:0.3];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
