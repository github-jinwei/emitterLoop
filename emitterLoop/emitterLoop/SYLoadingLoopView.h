//
//  SYLoadingLoopView.h
//  emitterLoop
//
//  Created by Mac on 16/3/14.
//  Copyright © 2016年 shaiba. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    SYLoadingLoopViewStyleClockWise =0,//顺时针旋转
    SYLoadingLoopViewStyleAntiClockWise = 0>>1//逆时针旋转
} SYLoadingLoopViewStyle;
@protocol SYLoadingLoopViewDelegate <NSObject>

-(void)endLoadingLoopViewAnimate;

@end
@interface SYLoadingLoopView : UIImageView
@property (nonatomic, assign)id<SYLoadingLoopViewDelegate> delegate;
@property (nonatomic, assign)SYLoadingLoopViewStyle *viewStyle;
@property (nonatomic, assign)CFTimeInterval roundDuration;//旋转一圈所用时间.
@property (nonatomic)BOOL isDefaultEndAnimation;
/**
 *  停止旋转动画
 */
-(void)endAnimation;

@end
