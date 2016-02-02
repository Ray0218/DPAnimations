//
//  PaneBehavior.m
//  DPAnimations
//
//  Created by Ray on 15/5/7.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import "PaneBehavior.h"

@implementation PaneBehavior

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithItem:(id<UIDynamicItem>)item
{

    self = [super init];
    if (self) {
        
        self.item = item ;
        [self setup];
        
    }
    return self;


}



/*
 http://blog.csdn.net/lengshengren/article/details/12000649 //说明地址
 
 UIAttachmentBehavior配置：
 •    anchorPoint  property 锚点类型UIAttachmentBehavior的锚点。
 •    attachedBehaviorType  property (read-only) UIAttachmentBehavior的类型，枚举(UIAttachmentBehaviorTypeItems,UIAttachmentBehaviorTypeAnchor)
 •    damping  property 阻尼数值(浮点)
 •    frequency  property 震动频率(浮点)
 •    length  property 两个吸附点间的距离(浮点)
 
 UICollisionBehavior
 指定一些dynamic item可以相互碰撞或者与UICollisionBehavior的界线碰撞。步骤1.使用init方法创建UICollisionBehavior，使用addItem: 方法向其添加dynamic item 或者使用initWithItems:实例化UICollisionBehavior。2. 使用addBehavior: 方法将UICollisionBehavior加入到动力动画
 
 
 UICollisionBehavior实例化方法及管理：
 – addItem:        向UICollisionBehavior实例添加dynamic item
 – initWithItems:  使用dynamic item数组实例化UICollisionBehavior
 – removeItem:     删除dynamic item
 items  property (read-only)  返回UICollisionBehavior实例中的dynamic item数组
 
 
 
 
UIDynamicItemBehavior
基本的动力动画描述，每一个属性重写了对应的默认值。
步骤1.使用init方法创建UICollisionBehavior，使用addItem: 方法向其添加dynamic item 或者使用initWithItems:实例化UIDynamicItemBehavior。2. 使用addBehavior: 方法将UIDynamicItemBehavior加入到动力动画

使用allowsRotation 属性设置行为中的dynamic item是否可以循环。
使用elasticity 属性设置碰撞弹性系数。范围（0.0-1.0）
使用friction 属性设置摩擦系数。
使用resistance  property设置线性阻力系数。（0--CGFLOAT_MAX）
使用angularResistance  property设置角度阻力系数。（0--CGFLOAT_MAX）
使用density  property设置相对密度。不明白什么意思
注意： 如果向同一个动力动画添加多个UIDynamicItemBehavior实例，只会应用一套属性描述(交集？)多个UIDynamicItemBehavior实例配置同个属性时，使用最后的。

– addAngularVelocity:forItem:向dynamic item增加角速度属性。单位弧度
– addLinearVelocity:forItem: 向dynamic item增加线速度属性。单位点
angularResistance  property         UIDynamicItemBehavior的角度阻力系数。
 */
-(void)setup{

    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc]initWithItem:self.item  attachedToAnchor:CGPointZero];
    attachmentBehavior.frequency = 3.5 ; //两个吸附点间的震动频率
    attachmentBehavior.damping = 0.4 ; //阻尼大小
    attachmentBehavior.length = 0 ; //两个吸附点间的距离
    [self addChildBehavior:attachmentBehavior];
    self.attachmentBehavior = attachmentBehavior ;
    
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[self.item]] ;
    itemBehavior.density = 100 ;//密度
    itemBehavior.resistance = 10 ; //阻力
    [self addChildBehavior:itemBehavior];
    
    self.itemBehavior = itemBehavior ;

    
}

-(void)setTargetPoint:(CGPoint)targetPoint{

    _targetPoint = targetPoint ;
    self.attachmentBehavior.anchorPoint = targetPoint ;
}
-(void)setVelocity:(CGPoint)velocity{
    _velocity = velocity ;
    CGPoint currentVlocity = [self.itemBehavior linearVelocityForItem:self.item] ;
    CGPoint velocityDelta = CGPointMake(velocity.x-currentVlocity.x, velocity.y-currentVlocity.y) ;
    [self.itemBehavior addLinearVelocity:velocityDelta forItem:self.item];//增加线速度属性
}

@end
