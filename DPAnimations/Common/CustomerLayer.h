//
//  CustomerLayer.h
//  动画效果
//
//  Created by Ray on 15/3/6.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerLayer : UIView

+(CABasicAnimation
  *)opacityForever_Animation:(float)time;
//永久闪烁的动画

+(CABasicAnimation
  *)opacityTimes_Animation:(float)repeatTimes
durTimes:(float)time;
//有闪烁次数的动画

+(CABasicAnimation
  *)moveX:(float)time
X:(NSNumber *)x ; //横向移动

+(CABasicAnimation
  *)moveY:(float)time
Y:(NSNumber *)y ;//纵向移动

+(CABasicAnimation
  *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time
Rep:(float)repeatTimes;
//缩放


+(CAAnimationGroup
  *)groupAnimation:(NSArray *)animationAry durTimes:(float)time
Rep:(float)repeatTimes;
//组合动画

+(CAKeyframeAnimation
  *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time
Rep:(float)repeatTimes;
//路径动画

+(CABasicAnimation
  *)movepoint:(CGPoint )point; //点移动


+(CABasicAnimation
  *)rotation:(float)dur
degree:(float)degree
direction:(int)direction
repeatCount:(int)repeatCount;
//旋转
@end
