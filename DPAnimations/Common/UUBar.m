//
//  UUBar.m
//  DPAnimations
//
//  Created by Ray on 15/5/8.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import "UUBar.h"

@implementation UUBar

- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [self init_:frame];
    }
    return self;
}

-(void)init_:(CGRect)frame{

    _chartLine = [CAShapeLayer layer] ;
    _chartLine.lineCap = kCALineCapSquare ;
    _chartLine.lineWidth = self.frame.size.width ;
    _chartLine.fillColor = [UIColor greenColor].CGColor ;
    _chartLine.strokeEnd = 0.0 ;
    [self.layer addSublayer:_chartLine];
    
    _chartLine.anchorPoint = CGPointMake(0.5, 1) ;
//    UIBezierPath *path= [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 20, 10) cornerRadius:3] ;
//    _chartLine.path = path.CGPath ;
    
    self.clipsToBounds = YES ;
    self.layer.cornerRadius = 2.0 ;

}
-(void)setChartHight:(float)chartHight{

//    NSURLFileSizeKey
    
     if (chartHight == 0) {
        return ;
    }
    
    _chartHight = chartHight ;
    
    UIBezierPath *path  = [UIBezierPath bezierPath] ;
    [path moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height+30)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height*(1-chartHight)+15)];
    path.lineWidth = 2 ;
    path.lineCapStyle = kCGLineCapSquare ;
    

    _chartLine.path = path.CGPath ;
    _chartLine.strokeColor = [UIColor greenColor].CGColor ;
    
     CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"] ;
    animation.duration = 1.5 ;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] ;
    animation.fromValue = [NSNumber numberWithFloat:0.0f] ;
    animation.toValue = [NSNumber numberWithFloat:1] ;
    animation.autoreverses = NO ;
    animation.removedOnCompletion = NO ;
    animation.fillMode = kCAFillModeForwards ;
    [_chartLine addAnimation:animation forKey:@"key"];
    _chartLine.strokeEnd = 2.0 ;
}

-(void)drawRect:(CGRect)rect{
    //画背景色
    CGContextRef context  =UIGraphicsGetCurrentContext() ;
    CGContextSetFillColorWithColor(context, [UIColor brownColor].CGColor);
    CGContextFillRect(context, rect) ;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
