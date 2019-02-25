//
//  XSCaptureViewController.m
//  XSCamera
//
//  Created by 晓松 on 2019/2/15.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSCaptureViewController.h"
#import "XSCaptureTopView.h"
#import "XSCaptureBottomView.h"
#import "GPUImage.h"
#import "Masonry.h"
#import "XSUIMacro.h"


@interface XSCaptureViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *takedImageView;


@property (nonatomic, strong) GPUImageStillCamera *stillCamera;
@property (nonatomic, strong) GPUImageView *filterView;
@property (nonatomic, strong) GPUImageGrayscaleFilter *grayFilter;
@property (nonatomic, strong) GPUImageCropFilter *cropFilter;
@property (nonatomic, strong) GPUImageFilterGroup *filterGroup;

@property (nonatomic, strong) XSCaptureTopView *topView;
@property (nonatomic, strong) XSCaptureBottomView *bottomView;

@end

@implementation XSCaptureViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = UIColor.redColor;
    [self createCaptureCamera];
    [self createSubViews];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)createCaptureCamera {
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.clipsToBounds = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(SCREEN_HEIGHT - CAPTURE_BOTTOM_VIEW_HEIGHT);
    }];
    
    self.stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    self.stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.stillCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.filterView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - CAPTURE_BOTTOM_VIEW_HEIGHT)];
    self.filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self.imageView addSubview:self.filterView];
    
    self.cropFilter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0, 0, 1, 1)];
    self.grayFilter = [[GPUImageGrayscaleFilter alloc] init];
    
    self.filterGroup = [[GPUImageFilterGroup alloc] init];
    [self.filterGroup addFilter:self.cropFilter];
    [self.filterGroup addFilter:self.grayFilter];
    
    
    [self.cropFilter addTarget:self.grayFilter];
    self.filterGroup.initialFilters = @[self.cropFilter];
    self.filterGroup.terminalFilter = self.grayFilter;
    
    [self.stillCamera addTarget:self.filterGroup];
    [self.filterGroup addTarget:self.filterView];
    
    [self.stillCamera startCameraCapture];
    
    self.takedImageView = [[UIImageView alloc] init];
    self.takedImageView.backgroundColor = UIColor.clearColor;
    self.takedImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.takedImageView.clipsToBounds = YES;
    [self.imageView addSubview:self.takedImageView];
    [self.takedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imageView);
    }];
    
    
}

- (void)createSubViews {
    
    self.topView = [[XSCaptureTopView alloc] init];
    [self.topView.switchCameraButton addTarget:self action:@selector(switchCaptureDevice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CAPTURE_TOP_VIEW_HEIGHT);
    }];
    
    self.bottomView = [[XSCaptureBottomView alloc] init];
    [self.bottomView.takingButton addTarget:self action:@selector(takingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(CAPTURE_BOTTOM_VIEW_HEIGHT);
    }];
}

- (void)takingAction:(UIButton *)sender {
    
    __block UIImage *takedImage;
    [self.stillCamera capturePhotoAsPNGProcessedUpToFilter:self.stillCamera.targets.firstObject withCompletionHandler:^(NSData *processedPNG, NSError *error) {
        if (!error) {
            takedImage = [UIImage imageWithData:processedPNG];
            self.takedImageView.image = takedImage;
        } else {
            NSLog(@"%@",@"Taking Faild!!!!");
        }
    }];
}

- (void)switchCaptureDevice {
    [self.stillCamera rotateCamera];
}

@end
