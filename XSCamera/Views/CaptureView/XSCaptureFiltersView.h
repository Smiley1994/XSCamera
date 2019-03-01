//
//  XSCaptureFiltersView.h
//  XSCamera
//
//  Created by 晓松 on 2019/2/26.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CaptureFiltersDelegate <NSObject>

- (void)selectedFilterWithIndex: (NSInteger)index;

@end

@interface XSCaptureFiltersView : UIView

@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) id<CaptureFiltersDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
