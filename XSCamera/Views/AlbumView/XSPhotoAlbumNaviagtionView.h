//
//  XSPhotoAlbumNaviagtionView.h
//  XSCamera
//
//  Created by 晓松 on 2019/3/6.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XSPhotoAlbumNavigationDelegate <NSObject>

- (void)close;
- (void)finish;

@end

@interface XSPhotoAlbumNaviagtionView : UIView

@property (nonatomic, weak) id<XSPhotoAlbumNavigationDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
