//
//  XSPhotoEditViewController.m
//  XSCamera
//
//  Created by 晓松 on 2019/3/6.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSPhotoEditViewController.h"

@interface XSPhotoEditViewController ()

@end

@implementation XSPhotoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
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
