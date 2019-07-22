//
//  XSPhotoCollectionViewCell.m
//  XSCamera
//
//  Created by 晓松 on 2019/3/6.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSPhotoCollectionViewCell.h"
#import "Masonry.h"

@interface XSPhotoCollectionViewCell ()



@end

@implementation XSPhotoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
    }
    return self;
}

- (void)createUI {
    
}

@end
