//
//  CustomerLayer.m
//  动画效果
//
//  Created by Ray on 15/3/6.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import "CustomerLayer.h"

@implementation CustomerLayer

+(CABasicAnimation
  *)opacityForever_Animation:(float)time
//永久闪烁的动画

{
    
    CABasicAnimation
    *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber
                         numberWithFloat:1.0];
    
    animation.toValue=[NSNumber
                       numberWithFloat:0.0];
    
    animation.autoreverses=YES;
    
    animation.duration=time;
    
    animation.repeatCount=FLT_MAX;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}

+(CABasicAnimation
  *)opacityTimes_Animation:(float)repeatTimes
durTimes:(float)time
//有闪烁次数的动画

{
    
    CABasicAnimation
    *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber
                         numberWithFloat:1.0];
    
    animation.toValue=[NSNumber
                       numberWithFloat:0.4];
    
    animation.repeatCount=repeatTimes;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction
                              functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=YES;
    
    animation.cumulative = YES ;//属性是指定累计
    
    return  animation;
    
}



+(CABasicAnimation
  *)moveX:(float)time
X:(NSNumber *)x //横向移动

{
    
    CABasicAnimation
    *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animation.toValue=x;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CABasicAnimation
  *)moveY:(float)time
Y:(NSNumber *)y //纵向移动

{
    
    CABasicAnimation
    *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.toValue=y;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CABasicAnimation
  *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time
Rep:(float)repeatTimes
//缩放

{
    
    CABasicAnimation
    *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue=orginMultiple;
    
    animation.toValue=Multiple;
    
    animation.duration=time;
    
    animation.autoreverses=YES;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CAAnimationGroup
  *)groupAnimation:(NSArray *)animationAry durTimes:(float)time
Rep:(float)repeatTimes
//组合动画

{
    
    CAAnimationGroup
    *animation=[CAAnimationGroup animation];
    
    animation.animations=animationAry;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CAKeyframeAnimation
  *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time
Rep:(float)repeatTimes
//路径动画

{
    
    CAKeyframeAnimation
    *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path=path;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction
                              functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=NO;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    return animation;
    
}



+(CAAnimation
  *)movepoint:(CGPoint )point //点移动

{
    
    CABasicAnimation
    *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    
    animation.toValue=[NSValue
                       valueWithCGPoint:point];
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



+(CAAnimation
  *)rotation:(float)dur
degree:(float)degree
direction:(int)direction
repeatCount:(int)repeatCount
//旋转

{
    
    
    
//    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
//
//    CABasicAnimation* animation2;
//    
//    animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
//    
//    
//    
//    animation2.toValue=
//    [NSValue valueWithCATransform3D:rotationTransform];
//    
//    animation2.duration=
//    dur;
//    
//    animation2.autoreverses=
//    NO;
//    
//    animation2.cumulative=
//    YES;
//    
//    animation2.removedOnCompletion=NO;
//    
//    animation2.fillMode=kCAFillModeForwards;
//    
//    animation2.repeatCount=
//    repeatCount;
//    return animation2 ;
//    
//    // 对Y轴进行旋转（指定Z轴的话，就和UIView的动画一样绕中心旋转）
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    
//    // 设定动画选项
//    animation.duration = 2.5; // 持续时间
//    animation.repeatCount = 100; // 重复次数
//    
//    // 设定旋转角度
//    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
//    animation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
//    
//    return animation ;
    
   
    CATransform3D
//    rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    rotationTransform2   =  CATransform3DMakeRotation(M_PI , 0,1, 0);
    CABasicAnimation*
    animation;
    
    animation
    = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    
    animation.byValue = [NSValue valueWithCATransform3D:rotationTransform2];
//    animation.toValue=
//    [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration=dur;
    
    animation.autoreverses= NO ;//// 结束后执行逆动画
    animation.cumulative= YES ; //有无阻力
    
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;

    animation.repeatCount= repeatCount;
//
    animation.delegate=self;
    
    return animation ;

    
    
//    CATransform3D
//    //    rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
//    rotationTransform2  = CATransform3DMakeRotation(degree,direction,0, 0);
//    
//    CABasicAnimation*
//    animation2;
//    
//    animation2
//    = [CABasicAnimation animationWithKeyPath:@"transform"];
//    
//    
//    
//    animation2.toValue=
//    [NSValue valueWithCATransform3D:rotationTransform2];
//    
//    animation2.duration=
//    dur;
//    
//    animation2.autoreverses=
//    NO;
//    
//    animation2.cumulative=
//    YES;
//    
//    animation2.removedOnCompletion=NO;
//    
//    animation2.fillMode=kCAFillModeForwards;
//
//    animation2.repeatCount=
//    repeatCount;
////
//    
//    
//    //动画组合
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.delegate = self;
//    group.duration = dur;
//    group.repeatCount = repeatCount ;
//
//    group.fillMode = kCAFillModeForwards;
//    group.removedOnCompletion = NO;
//
//    group.animations = @[animation2, animation];
//
//    
//    return group;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
