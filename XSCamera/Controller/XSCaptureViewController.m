//
//  XSCaptureViewController.m
//  XSCamera
//
//  Created by 晓松 on 2019/2/15.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSCaptureViewController.h"
#import "XSPhotoAlbumViewController.h"
#import "XSCaptureTopView.h"
#import "XSCaptureBottomView.h"
#import "XSCaptureFiltersView.h"
#import "GPUImage.h"
#import "Masonry.h"
#import "XSUIMacro.h"
#import "XSGPUImageBeautyFilter.h"
#import "XSUtils.h"
#import "XSFilterModel.h"

@interface XSCaptureViewController ()<CaptureFiltersDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *takedImageView;


@property (nonatomic, strong) GPUImageStillCamera *stillCamera;
@property (nonatomic, strong) GPUImageView *filterImageView;
@property (nonatomic, strong) XSGPUImageBeautyFilter *defaultFilter;
@property (nonatomic, strong) GPUImageFilter *switchFilter;

@property (nonatomic, strong) GPUImageCropFilter *cropFilter;

@property (nonatomic, strong) XSCaptureTopView *topView;
@property (nonatomic, strong) XSCaptureBottomView *bottomView;
@property (nonatomic, strong) XSCaptureFiltersView *filtersView;
@property (nonatomic, strong) NSMutableArray *filterDataArray;

@end

@implementation XSCaptureViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupFilterDataArray];
    [self createCaptureCamera];
    [self createSubViews];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setupFilterDataArray {
    self.filterDataArray = [[NSMutableArray alloc] init];
    
    NSString *jsonpath = [[NSBundle mainBundle] pathForResource:@"XSFilters" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonpath];
    NSDictionary  *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary *filter in dic[@"data"]) {
        XSFilterModel *filterModel = [[XSFilterModel alloc] init];
        filterModel.filterName = filter[@"name"];
        filterModel.className = filter[@"filter"];
        filterModel.selected = [filter[@"selected"] integerValue];
        filterModel.index = [filter[@"index"] integerValue];
        [self.filterDataArray addObject:filterModel];
    }
}

- (void)createCaptureCamera {
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.clipsToBounds = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(SCREEN_HEIGHT - CAPTURE_BOTTOM_VIEW_HEIGHT);
    }];
    
    self.stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    self.stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.stillCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.filterImageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - CAPTURE_BOTTOM_VIEW_HEIGHT)];
    self.filterImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self.imageView addSubview:self.filterImageView];
    // 裁剪滤镜
    self.cropFilter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0, 0, 1, 1)];
    self.defaultFilter = [[XSGPUImageBeautyFilter alloc] init];
    self.defaultFilter.beautyLevel = 0.9f;//美颜程度
    self.defaultFilter.brightLevel = 0.7f;//美白程度
    self.defaultFilter.toneLevel = 0.9f;//色调强度
    
    [self addFilter:self.defaultFilter];
    
    // 开始拍照
    [self.stillCamera startCameraCapture];
    
    // 拍照完成显示View
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
    [self.bottomView.resetTakingButton addTarget:self action:@selector(resetTaking:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.chooseFilterButton addTarget:self action:@selector(chooseFilterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.choosePhotoButton addTarget:self action:@selector(choosePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.closeFilterButton addTarget:self action:@selector(closeFiltersTools:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(CAPTURE_BOTTOM_VIEW_HEIGHT);
    }];
    
    self.filtersView = [[XSCaptureFiltersView alloc] init];
    self.filtersView.delegate = self;
    self.filtersView.dataArray = self.filterDataArray;
    [self.bottomView addSubview:self.filtersView];
    [self.filtersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left);
        make.right.equalTo(self.bottomView.mas_right);
        make.top.equalTo(self.bottomView.mas_bottom);
        make.bottom.equalTo(self.bottomView.mas_bottom);
    }];
}

- (void)chooseFilterAction:(UIButton *)sender {
    [self showFiltersView];
}

- (void)closeFiltersTools:(UIButton *)sender {
    [self hideFiltersView];
}

- (void)choosePhotoAction:(UIButton *)sender {
    XSPhotoAlbumViewController *photoAilbum = [[XSPhotoAlbumViewController alloc] init];
    [self.navigationController pushViewController:photoAilbum animated:YES];
//    [self.navigationController presentViewController:photoAilbum animated:YES completion:^{
//
//    }];
}

// 显示滤镜View
- (void)showFiltersView {
    self.filtersView.isShow = YES;
    [self.filtersView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left);
        make.right.equalTo(self.bottomView.mas_right);
        make.top.equalTo(self.bottomView.mas_top);
        make.bottom.equalTo(self.bottomView.mas_bottom).inset(CAPTURE_BOTTOM_VIEW_BOTTOM_PADDING);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.bottomView showCloseButton];
        [self.bottomView layoutIfNeeded];
    }];
}

// 隐藏滤镜View
- (void)hideFiltersView {
    self.filtersView.isShow = NO;
    [self.filtersView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left);
        make.right.equalTo(self.bottomView.mas_right);
        make.top.equalTo(self.bottomView.mas_bottom);
        make.bottom.equalTo(self.bottomView.mas_bottom).inset(0);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.bottomView hideCloseButton];
        [self.bottomView layoutIfNeeded];
    }];
}

- (void)selectedFilterWithIndex:(NSInteger)index {
    XSFilterModel *selectedFilter = self.filterDataArray[index];
    self.switchFilter = [[NSClassFromString(selectedFilter.className) alloc] init];
    [self addFilter:self.switchFilter];
}

- (void)addFilter:(GPUImageFilter *)filter {
    [self.stillCamera removeAllTargets];
    
    [self.stillCamera addTarget:filter];
    [filter addTarget:self.filterImageView];
    [[GPUImageContext sharedImageProcessingContext].framebufferCache purgeAllUnassignedFramebuffers];
}



//拍照
- (void)takingAction:(UIButton *)sender {
    if (sender.selected == YES) {
        [self saveImage:self.takedImageView.image];
    }
    sender.selected = YES;
    if (self.filtersView.isShow == YES) {
        [self hideFiltersView];
    }
    
    __block UIImage *takedImage;
    __weak typeof(self) weakSelef = self;
    [self.stillCamera capturePhotoAsPNGProcessedUpToFilter:self.stillCamera.targets.firstObject withCompletionHandler:^(NSData *processedPNG, NSError *error) {
        __strong typeof(weakSelef) strongSelf = weakSelef;
        if (!error) {
            takedImage = [UIImage imageWithData:processedPNG];
            strongSelf.takedImageView.image = takedImage;
            [strongSelf.bottomView takedUI];
        } else {
            NSLog(@"%@",@"Taking Faild!!!!");
        }
    }];
}

- (void)saveImage:(UIImage *)image {
    [XSUtils saveImageToPhotoLibrary:image complate:^(NSString * _Nonnull localIdentifier, BOOL success) {
        NSLog(@"localIdentifier = %@, success = %d", localIdentifier, success);
        if (success == YES) {
            self.bottomView.takingButton.selected = NO;
            [self.bottomView reTakingUI];
            self.takedImageView.image = nil;
        }
    }];
}

//重拍
- (void)resetTaking:(UIButton *)sender {
    self.bottomView.takingButton.selected = NO;
    [self.bottomView reTakingUI];
    self.takedImageView.image = nil;
}

// 切换摄像头
- (void)switchCaptureDevice {
    [self.stillCamera rotateCamera];
}

@end
