//
//  XSFilterModel.h
//  XSCamera
//
//  Created by 晓松 on 2019/2/27.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSFilterModel : NSObject

@property (nonatomic, copy) NSString *filterName;
@property (nonatomic, copy) NSString *className;
//@property (nonatomic, strong) GPUImageFilter *filter;
@property (nonatomic, assign) NSInteger selected;
@property (nonatomic, assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
