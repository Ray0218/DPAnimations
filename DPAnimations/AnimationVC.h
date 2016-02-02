//
//  AnimationVC.h
//  动画集合
//
//  Created by Ray on 15/3/25.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  enum {

    kAnimaRota = 0 ,
    kAnimationRadom,
    kAnimationShow,
    kAnimationScrew,
    kAnimationDrawCircle,
    kAnimationSezhi,
    kAnimationStar,
    kAnimationRuber

} AnimationType ;

@interface AnimationVC : UIViewController

- (instancetype)initWithType:(AnimationType)type ;


@end
