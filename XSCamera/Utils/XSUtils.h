//
//  XSUtils.h
//  XSCamera
//
//  Created by 晓松 on 2019/2/27.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSUtils : NSObject


+ (void)saveImageToPhotoLibrary:(UIImage *)image complate:(void(^)(NSString *localIdentifier, BOOL success))complate;

+ (UIImage *)imageAddFilterUseGPUImage:(UIImage *)image withFilterName:(NSString *)filterName;

@end

NS_ASSUME_NONNULL_END
