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



@end
