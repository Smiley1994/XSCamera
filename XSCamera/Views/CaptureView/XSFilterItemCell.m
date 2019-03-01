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
#import "XSUtils.h"

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
    self.contentView.layer.shouldRasterize = YES;
    self.contentView.backgroundColor = UIColor.whiteColor;
    
//    UIView *selectedBackgroundView = [[UIView alloc] init];
//    selectedBackgroundView.backgroundColor = HEXCOLOR(0x18cdfa);
//    selectedBackgroundView.layer.cornerRadius = 4;
//    selectedBackgroundView.layer.masksToBounds = YES;
//    self.selectedBackgroundView = selectedBackgroundView;
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"FilterName";
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.textColor = HEXCOLOR(0xFFFFFF);
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom).inset(5);
    }];
    
    
    self.shadowView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.shadowView.backgroundColor = RGBA(39, 176, 248, 0.7);
    [self.contentView addSubview:self.shadowView];
    self.shadowView.hidden = YES;
    
}

- (void)setModel:(XSFilterModel *)model {
    self.titleLabel.text = model.filterName;
    self.imageView.image = [XSUtils imageAddFilterUseGPUImage:[UIImage imageNamed:@"ttt"] withFilterName:model.className];
    if (model.selected == YES) {
        self.shadowView.hidden = NO;
    } else {
        self.shadowView.hidden = YES;
    }
}


@end
