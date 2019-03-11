//
//  XSPHAsset.h
//  XSCamera
//
//  Created by 晓松 on 2019/3/5.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSPHAsset : NSObject

@property (strong, nonatomic) UIImage *localImage;

@property (strong, nonatomic) PHAsset *asset;

@property (assign, nonatomic) BOOL isSelected;;

//用于视频
@property (strong, nonatomic) AVURLAsset *urlAsset;


@end

NS_ASSUME_NONNULL_END
