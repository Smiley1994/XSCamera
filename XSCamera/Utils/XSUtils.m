//
//  XSUtils.m
//  XSCamera
//
//  Created by 晓松 on 2019/2/27.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSUtils.h"
#import "GPUImage.h"
#import "XSUIMacro.h"

@implementation XSUtils

+ (void)saveImageToPhotoLibrary:(UIImage *)image complate:(void (^)(NSString *localIdentifier, BOOL success))complate {
    
    __block NSString *localIdentifier;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        localIdentifier = req.placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complate(localIdentifier, success);
            });
        }
    }];
}

/**
 use GPUImage add Fitler
 @param image 源图
 @param filterName 滤镜名字 GPUImageOutput<GPUImageInput>
 @return 合成滤镜后的图片
 */

+ (UIImage *)imageAddFilterUseGPUImage:(UIImage *)image withFilterName:(NSString *)filterName {
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    GPUImageOutput<GPUImageInput> *stillImageFilter = [[NSClassFromString(filterName) alloc] init];
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    UIImage *newImage = [stillImageFilter imageFromCurrentFramebuffer];
    [[GPUImageContext sharedImageProcessingContext].framebufferCache purgeAllUnassignedFramebuffers];
    return newImage;
}

/**
 根据PHAsset获取图片
 
 @param asset PHAsset
 @param isSynchronous 同步-YES 异步-NO
 @param completion 返回图片
 */
+ (void)xs_requestImageForAsset:(PHAsset *)asset
                withSynchronous:(BOOL)isSynchronous
                     completion:(void (^)(UIImage *image))completion {
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeExact;//控制照片尺寸
    option.networkAccessAllowed = YES;
    option.synchronous = isSynchronous;
    CGFloat width  = (CGFloat)asset.pixelWidth;
    CGFloat height = (CGFloat)asset.pixelHeight;
    CGFloat scale = width/height;
    CGSize size = CGSizeMake(SCREEN_HEIGHT*scale, SCREEN_HEIGHT);
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (isSynchronous) {
            if ([info[@"PHImageResultIsDegradedKey"] boolValue] == NO) {
                completion(result);
            }
        } else {
            completion(result);
        }
    }];
}

@end
