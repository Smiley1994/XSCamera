//
//  XSCaptureBottomView.h
//  XSCamera
//
//  Created by 晓松 on 2019/2/19.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

//static CGFloat const CAPTURE_BOTTOM_VIEW_HEIGHT = 220.0;

@interface XSCaptureBottomView : UIView

@property (nonatomic, strong) UIButton *takingButton;
@property (nonatomic, strong) UIButton *resetTakingButton;

@property (nonatomic, strong) UIButton *chooseFilterButton;
@property (nonatomic, strong) UIButton *closeFilterButton;

- (void)takedUI;
- (void)reTakingUI;
- (void)showCloseButton;
- (void)hideCloseButton;

@end

NS_ASSUME_NONNULL_END
