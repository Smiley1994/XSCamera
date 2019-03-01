//
//  XSFilterItemCell.h
//  XSCamera
//
//  Created by 晓松 on 2019/2/26.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSFilterModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const XSFilterItemCellId = @"XSFilterItemCellId";

@interface XSFilterItemCell : UICollectionViewCell

@property (nonatomic, strong) XSFilterModel *model;
//- (void)setModel:(XSFilterModel *)model;

@end

NS_ASSUME_NONNULL_END
