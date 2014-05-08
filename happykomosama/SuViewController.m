//
//  SuViewController.m
//  happykomosama
//
//  Created by ohta tomotaka on 2014/05/08.
//  Copyright (c) 2014年 ohta tomotaka. All rights reserved.
//

#import "SuViewController.h"

@interface SuViewController ()

@end

@implementation SuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer* swipeRightGesture =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(view_SwipeRight:)];
    
    // 左スワイプを認識するように設定
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    // ビューにジェスチャーを追加
    [self.view addGestureRecognizer:swipeRightGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)view_SwipeRight:(UISwipeGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
