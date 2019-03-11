//
//  XSCaptureBottomView.m
//  XSCamera
//
//  Created by 晓松 on 2019/2/19.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSCaptureBottomView.h"
#import "Masonry.h"
#import "XSUIMacro.h"

@interface XSCaptureBottomView ()



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
    
    self.resetTakingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.resetTakingButton.hidden = YES;
    [self.resetTakingButton setImage:[UIImage imageNamed:@"photo_reset"] forState:UIControlStateNormal];
    [self addSubview:self.resetTakingButton];
    [self.resetTakingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7, CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7));
    }];
    
    self.takingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.takingButton.layer.masksToBounds = YES;
    self.takingButton.layer.cornerRadius = CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7 / 2;
//    [self.takingButton setBackgroundColor:UIColor.redColor];
    [self.takingButton setImage:[UIImage imageNamed:@"video_album_record"] forState:UIControlStateNormal];
    [self.takingButton setImage:[UIImage imageNamed:@"savePhoto"] forState:UIControlStateSelected];
    [self addSubview:self.takingButton];
    [self.takingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7, CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7));
    }];
    
    self.chooseFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.chooseFilterButton setImage:[UIImage imageNamed:@"photo_reset"] forState:UIControlStateNormal];
    [self.chooseFilterButton setTitle:@"滤镜" forState:UIControlStateNormal];
    self.chooseFilterButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.chooseFilterButton setTitleColor:HEXCOLOR(0x18cdfa) forState:UIControlStateNormal]; //
    [self addSubview:self.chooseFilterButton];
    [self.chooseFilterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset (15);
        make.top.equalTo(self.mas_top).offset(13);
    }];
    
    self.choosePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [choosePhotoButton setImage:[UIImage imageNamed:@"photo_reset"] forState:UIControlStateNormal];
    [self.choosePhotoButton setTitle:@"相册" forState:UIControlStateNormal];
    self.choosePhotoButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.choosePhotoButton setTitleColor:HEXCOLOR(0x18cdfa) forState:UIControlStateNormal]; //
    [self addSubview:self.choosePhotoButton];
    [self.choosePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(13);
    }];
    
    self.closeFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [self.chooseFilterButton setImage:[UIImage imageNamed:@"photo_reset"] forState:UIControlStateNormal];
    [self.closeFilterButton setTitle:@"取消" forState:UIControlStateNormal];
    self.closeFilterButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.closeFilterButton setTitleColor:HEXCOLOR(0x18cdfa) forState:UIControlStateNormal];
    [self addSubview:self.closeFilterButton];
    [self.closeFilterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset (15);
        make.bottom.equalTo(self.mas_bottom).inset(8.5);
    }];
    self.closeFilterButton.hidden = YES;
}

//拍照完改变UI
- (void)takedUI {
    self.takingButton.layer.cornerRadius = CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7 / 2;
    [self.takingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7, CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7));
    }];
    
    self.resetTakingButton.hidden = NO;
    [self.resetTakingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.takingButton.mas_left).inset (50);
        make.centerY.equalTo(self.takingButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7, CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7));
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)reTakingUI {
    
    [self.resetTakingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7, CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7));
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.resetTakingButton.hidden = YES;
    }];
}

- (void)showCloseButton {
    self.resetTakingButton.hidden = YES;
    self.closeFilterButton.hidden = NO;
    self.takingButton.layer.cornerRadius = (CAPTURE_BOTTOM_VIEW_BOTTOM_PADDING - 14) / 2;
    [self.takingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).inset(4);
        make.size.mas_equalTo(CGSizeMake(CAPTURE_BOTTOM_VIEW_BOTTOM_PADDING - 14, CAPTURE_BOTTOM_VIEW_BOTTOM_PADDING - 14));
    }];
}

- (void)hideCloseButton {
    self.resetTakingButton.hidden = NO;
    self.closeFilterButton.hidden = YES;
    self.takingButton.layer.cornerRadius = CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7 / 2;
    [self.takingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7, CAPTURE_BOTTOM_VIEW_HEIGHT / 2.7));
    }];
}

@end
