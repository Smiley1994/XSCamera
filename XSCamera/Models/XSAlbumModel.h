//
//  XSAlbumModel.h
//  XSCamera
//
//  Created by 晓松 on 2019/3/5.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSAlbumModel : NSObject

//相册名称
@property (copy, nonatomic) NSString *title;

//相册资源集
@property (strong, nonatomic) NSArray *assets;

//相册集
@property (strong, nonatomic) PHAssetCollection *assetCollection;

//相册内资源数
@property (assign, nonatomic) NSInteger count;

//在该相册中选择了多少张图片
@property (assign, nonatomic) NSInteger selected_count;

@end

NS_ASSUME_NONNULL_END
