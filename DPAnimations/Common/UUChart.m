//
//  UUChart.m
//  DPAnimations
//
//  Created by Ray on 15/5/8.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import "UUChart.h"
#import "UUBar.h"
@interface UUChart (){

    
}

@end

@implementation UUChart

-(void)createBars:(NSArray*)barsArrar withHight:(CGFloat)high{

    for (int i=0; i<barsArrar.count; i++) {
        CGFloat value = [[barsArrar objectAtIndex:i]floatValue];
    
    
        UUBar *bar = [[UUBar alloc]initWithFrame:CGRectMake(5+(KCharWith+kCharMargin)*i, 0, KCharWith, high)] ;
        bar.chartHight = value ;
        [self addSubview:bar];
    
    }
}
- (void)showInView:(UIView *)view
{
    [view addSubview:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
