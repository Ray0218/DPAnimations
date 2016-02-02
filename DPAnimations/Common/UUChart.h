//
//  UUChart.h
//  DPAnimations
//
//  Created by Ray on 15/5/8.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>


#define KCharWith 30 
#define kCharMargin 10
@interface UUChart : UIView

-(void)createBars:(NSArray*)barsArrar withHight:(CGFloat)high;
- (void)showInView:(UIView *)view ;


@end
