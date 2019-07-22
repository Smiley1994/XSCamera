//
//  XSSplashViewController.m
//  XSCamera
//
//  Created by 晓松 on 2019/2/15.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSSplashViewController.h"
#import "XSCaptureViewController.h"
#import "XSIndexViewController.h"

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wunused-variable"
//
//
//
//#pragma clang diagnostic pop


@interface XSSplashViewController ()

@end

@implementation XSSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self showCaptrueViewController];
    
    [self showIndexViewController];
}

- (void)showCaptrueViewController {
    XSCaptureViewController *captrueViewController = [[XSCaptureViewController alloc] init];
    UINavigationController *captrueNavigationController = [[UINavigationController alloc] initWithRootViewController:captrueViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = captrueNavigationController;
}

- (void)showIndexViewController {
    XSIndexViewController *indexViewController = [[XSIndexViewController alloc] init];
    UINavigationController *indexNavigationController = [[UINavigationController alloc] initWithRootViewController:indexViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = indexNavigationController;
}


@end
