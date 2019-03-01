//
//  XSFilterItemCell.m
//  XSCamera
//
//  Created by 晓松 on 2019/2/26.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSFilterItemCell.h"
#import "Masonry.h"
#import "XSUIMacro.h"

@interface XSFilterItemCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *shadowView;

@end

@implementation XSFilterItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    self.contentView.layer.cornerRadius = 4;
    self.contentView.layer.masksToBounds = YES;
    
//    UIView *selectedBackgroundView = [[UIView alloc] init];
//    selectedBackgroundView.backgroundColor = HEXCOLOR(0x18cdfa);
//    selectedBackgroundView.layer.cornerRadius = 4;
//    selectedBackgroundView.layer.masksToBounds = YES;
//    self.selectedBackgroundView = selectedBackgroundView;
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.layer.cornerRadius = 4;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.image = [UIImage imageNamed:@"ttt"];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"FilterName";
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = HEXCOLOR(0x222);
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom).inset(13);
    }];
    
    
    self.shadowView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.shadowView.backgroundColor = RGBA(39, 176, 248, 0.2);
    self.shadowView.layer.cornerRadius = 4;
    self.shadowView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.shadowView];
    
}


@end
