//
//  XSGPUImageBeautyFilter.h
//  XSCamera
//
//  Created by 晓松 on 2019/2/25.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "GPUImageFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSGPUImageBeautyFilter : GPUImageFilter

/** 美颜程度 */
@property (nonatomic, assign) CGFloat beautyLevel;
/** 美白程度 */
@property (nonatomic, assign) CGFloat brightLevel;
/** 色调强度 */
@property (nonatomic, assign) CGFloat toneLevel;

@end

NS_ASSUME_NONNULL_END
