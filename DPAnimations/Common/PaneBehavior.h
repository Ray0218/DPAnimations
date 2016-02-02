//
//  PaneBehavior.h
//  DPAnimations
//
//  Created by Ray on 15/5/7.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaneBehavior : UIDynamicBehavior

@property(nonatomic)CGPoint targetPoint ;
@property(nonatomic)CGPoint velocity ;

@property(nonatomic,weak)id<UIDynamicItem>item ;
@property(nonatomic)UIAttachmentBehavior *attachmentBehavior ;


@property(nonatomic)UIDynamicItemBehavior *itemBehavior ;
/*
 @property (readwrite, nonatomic) CGFloat elasticity; // Usually between 0 (inelastic) and 1 (collide elastically) 弹性系数 在0~1之间
 @property (readwrite, nonatomic) CGFloat friction; // 0 being no friction between objects slide along each other 摩擦力系数
 @property (readwrite, nonatomic) CGFloat density; // 1 by default 跟size大小相关，计算物体块的质量。
 @property (readwrite, nonatomic) CGFloat resistance; // 0: no velocity damping 阻力系数
 @property (readwrite, nonatomic) CGFloat angularResistance; // 0: no angular velocity damping 旋转阻力
 @property (readwrite, nonatomic) BOOL allowsRotation; // force an item to never rotate  是否能旋转
 */


-(instancetype)initWithItem:(id<UIDynamicItem>)item  ;

@end
