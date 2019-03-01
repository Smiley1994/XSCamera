//
//  XSCaptureTopView.m
//  XSCamera
//
//  Created by 晓松 on 2019/2/19.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSCaptureTopView.h"
#import "Masonry.h"
#import "XSUIMacro.h"

#import <AVFoundation/AVFoundation.h>

@interface XSCaptureTopView ()


@end

@implementation XSCaptureTopView

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
//    HEXCOLOR(0x18cdfa)
//    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    self.switchCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchCameraButton setImage:[UIImage imageNamed:@"switch_camera"] forState:UIControlStateNormal];
    [self addSubview:self.switchCameraButton];
    [self.switchCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(20);
        make.centerY.equalTo(self.mas_centerY);
    }];
}



@end
