//
//
//  ViewController.m
//  Demo
//
//  代码千万行，注释第一行！
//  编码不规范，同事泪两行。
//
//  Created by fqs on 2019/4/24.
//  Copyright © 2019 fqs. All rights reserved.
//
    

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *jiguoB;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)jiguo:(UIButton *)sender {
    ViewController2 *vc = [ViewController2 new];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
