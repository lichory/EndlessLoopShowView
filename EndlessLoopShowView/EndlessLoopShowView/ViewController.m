//
//  ViewController.m
//  EndlessLoopShowView
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 李重阳. All rights reserved.
//

#import "ViewController.h"
#import "EndlessLoopShowView.h"

@interface ViewController ()<EndlessLoopShowViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    EndlessLoopShowView * showView = [[EndlessLoopShowView alloc]initWithFrame:CGRectMake(0, 100, 200, 200)];
    showView.backgroundColor = [UIColor redColor];
    showView.imageDataArr = @[@"1",@"2",@"3",@"4",@"5"];
    showView.delegate = self;
    [self.view addSubview:showView];
    
}

- (void)endlessLoop:(EndlessLoopShowView *)showView scrollToIndex:(NSInteger)currentIndex {
    
    NSLog(@"currentIndex = %ld",currentIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
