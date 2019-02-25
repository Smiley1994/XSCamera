//
//  XSCaptureBottomView.m
//  XSCamera
//
//  Created by 晓松 on 2019/2/19.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSCaptureBottomView.h"
#import "Masonry.h"

@interface XSCaptureBottomView ()

@property (nonatomic, strong) UIButton *resetPhotoButton;

@end

@implementation XSCaptureBottomView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.takingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.takingButton.layer.masksToBounds = YES;
    self.takingButton.layer.cornerRadius = CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7 / 2;
    [self.takingButton setBackgroundColor:UIColor.redColor];
    [self addSubview:self.takingButton];
    [self.takingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7, CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7));
    }];
    
    
    
    self.resetPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.takingButton.layer.masksToBounds = YES;
//    self.takingButton.layer.cornerRadius = CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7 / 2;
//    [self.takingButton setBackgroundColor:UIColor.redColor];
    [self.resetPhotoButton setImage:[UIImage imageNamed:@"photo_reset"] forState:UIControlStateNormal];
    [self addSubview:self.resetPhotoButton];
    [self.resetPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.takingButton.mas_left).inset (50);
        make.centerY.equalTo(self.takingButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7, CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7));
    }];
}

@end
