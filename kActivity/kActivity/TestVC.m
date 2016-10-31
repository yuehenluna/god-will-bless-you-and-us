//
//  TestVC.m
//  kActivity
//
//  Created by zhaoke on 16/8/30.
//  Copyright © 2016年 zk. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"z字体种类有：%ld",[UIFont familyNames].count);
    int i = 0;
    for(NSString *fontName in [UIFont familyNames]){
        i++;
        NSLog(@"%d_________%@",i,fontName);
    }
    self.label1.font = [UIFont fontWithName:@"STXingkai" size:17];
    self.label2.font = [UIFont fontWithName:@"STXingkai" size:17];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
