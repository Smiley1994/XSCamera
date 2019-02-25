//
//  XSSplashViewController.m
//  XSCamera
//
//  Created by 晓松 on 2019/2/15.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSSplashViewController.h"
#import "XSCaptureViewController.h"

@interface XSSplashViewController ()

@end

@implementation XSSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self openCaptrueViewController];
    
}

- (void)openCaptrueViewController {
    XSCaptureViewController *captrueViewController = [[XSCaptureViewController alloc] init];
    UINavigationController *captrueNavigationController = [[UINavigationController alloc] initWithRootViewController:captrueViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = captrueNavigationController;
}


@end
