//
//  XSPhotoAlbumNaviagtionView.m
//  XSCamera
//
//  Created by 晓松 on 2019/3/6.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSPhotoAlbumNaviagtionView.h"
#import "Masonry.h"
#import "XSUIMacro.h"

@interface XSPhotoAlbumNaviagtionView ()

@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *albumButton;

@end

@implementation XSPhotoAlbumNaviagtionView

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton setTitleColor:HEXCOLOR(0x333) forState:UIControlStateNormal];
    self.closeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(12);
        make.bottom.equalTo(self.mas_bottom).inset(8);
        make.height.mas_equalTo(29);
    }];
    
    self.albumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.albumButton setTitle:@"全部照片" forState:UIControlStateNormal];
    [self.albumButton setTitleColor:HEXCOLOR(0x333) forState:UIControlStateNormal];
    self.albumButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.albumButton];
    [self.albumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).inset(8);
        make.height.mas_equalTo(29);
    }];
    
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishButton setTitle:@"  完成  " forState:UIControlStateNormal];
    [self.finishButton setBackgroundColor:HEXCOLOR(0x333)];
    [self.finishButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.finishButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.finishButton.layer.cornerRadius = 4;
    self.finishButton.layer.masksToBounds = YES;
    [self addSubview:self.finishButton];
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).inset(12);
        make.bottom.equalTo(self.mas_bottom).inset(8);
        make.height.mas_equalTo(29);
    }];
    
}

- (void)closeClick {
    if ([self.delegate respondsToSelector:@selector(close)]) {
        [self.delegate close];
    }
}

@end
