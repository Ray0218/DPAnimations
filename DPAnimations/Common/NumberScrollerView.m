//
//  NumberScrollerView.m
//  动画集合
//
//  Created by Ray on 15/3/26.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import "NumberScrollerView.h"

@interface NumberScrollerView (){
    NSMutableArray *numbersText;
    NSMutableArray *blueNumbersText;

    NSMutableArray *scrollLayers;
    NSMutableArray *scrollLabels;
}

@end

@implementation NumberScrollerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
   
    return self;
}


- (void)commonInit
{
    
    self.redNumber = 6 ;
    self.blueNumber = 1 ;
    self.duration = 5;
    
    self.durationOffset = .2;
    self.density = 33;
    self.densityBlue =16 ;
    self.minLength = 0;
    self.isAscending = NO;
    
    self.font = [UIFont systemFontOfSize:16];
    
    
    self.textColor = [UIColor blackColor];
    
    numbersText = [NSMutableArray new];
    blueNumbersText = [NSMutableArray new] ;
    scrollLayers = [NSMutableArray new];
    scrollLabels = [NSMutableArray new];
}

#pragma mark- 获得随机数字

-(void)createValueString{
    
    
    NSMutableSet * setArr = [[NSMutableSet alloc]initWithCapacity:self.redNumber];
    
    do {
        int a = arc4random()%self.density+1 ;
        [setArr addObject:[NSString stringWithFormat:@"%02d",a] ];
        NSLog( @"count === %lu",(unsigned long)setArr.count) ;
    } while (setArr.count<self.redNumber);
    
    
    NSArray *sortArra = @[[[NSSortDescriptor alloc]initWithKey:nil ascending:YES] ];
    NSArray * arr = [setArr sortedArrayUsingDescriptors:sortArra] ;
    [numbersText addObjectsFromArray:arr];
    
    
    NSMutableSet * blueSet= [[NSMutableSet alloc]initWithCapacity:self.blueNumber];
    
    do {
        int a = arc4random()%self.densityBlue+1 ;
        [blueSet addObject:[NSString stringWithFormat:@"%02d",a] ];
        NSLog( @"count === %lu",(unsigned long)blueSet.count) ;
    } while (blueSet.count<self.blueNumber);
    
    
    NSArray *sortBlueArra = @[[[NSSortDescriptor alloc]initWithKey:nil ascending:YES] ];
    NSArray * blueArr = [blueSet sortedArrayUsingDescriptors:sortBlueArra] ;
    [blueNumbersText addObjectsFromArray:blueArr];

    
    NSLog(@"%@ == %@",setArr,arr) ;
    
    
}


- (void)startAnimation
{
    [self prepareAnimations];
    [self createAnimations];
}

- (void)stopAnimation
{
    for(CALayer *layer in scrollLayers){
        [layer removeAnimationForKey:@"NumberScrollAnimatedView"];
    }
}

- (void)prepareAnimations
{
    for(CALayer *layer in scrollLayers){
        [layer removeFromSuperlayer];
    }
    
    [numbersText removeAllObjects];
    [blueNumbersText removeAllObjects];
    [scrollLayers removeAllObjects];
    [scrollLabels removeAllObjects];
    
    
    [self createValueString];
    [self createScrollLayers];
    
    
}


- (void)createScrollLayers
{
    CGFloat width = roundf((CGRectGetWidth(self.frame)-20) / (numbersText.count+blueNumbersText.count));
    CGFloat height = CGRectGetHeight(self.frame);
    
    CALayer *bgLayer = [CALayer layer] ;
    bgLayer.contents = (__bridge id)([UIImage imageNamed:@"bg_yew.png"].CGImage) ;
    bgLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame)+10, height+10);
    [self.layer addSublayer:bgLayer];
    
    for(NSUInteger i = 0; i < numbersText.count+blueNumbersText.count; ++i){
        CAScrollLayer *layer = [CAScrollLayer layer];
        
        layer.frame = CGRectMake(roundf(i * width)+10, 0, width, height);
        [scrollLayers addObject:layer];
        [self.layer addSublayer:layer];
    }
    
    for(NSUInteger i = 0; i < numbersText.count+blueNumbersText.count; ++i){
        CAScrollLayer *layer = scrollLayers[i];
        NSString *numberText ;
        if (i<numbersText.count) {
             numberText = numbersText[i];
            [self createContentForLayer:layer withNumberText:numberText isBlue:NO];

        }else{
            numberText = blueNumbersText[i-numbersText.count] ;
            [self createContentForLayer:layer withNumberText:numberText isBlue:YES];

        }
       
    }
}

- (void)createContentForLayer:(CAScrollLayer *)scrollLayer withNumberText:(NSString *)numberText isBlue:(BOOL)isBlue
{
    NSInteger number = [numberText integerValue];
    NSMutableArray *textForScroll = [NSMutableArray new];
    
    if (isBlue) {
        for(NSUInteger i = 0; i < self.densityBlue*2 ; ++i){
            [textForScroll addObject:[NSString stringWithFormat:@"%02ld", (number + i) % self.densityBlue == 0?self.densityBlue:(number + i) % self.densityBlue]];
        }

    }else{
    
        for(NSUInteger i = 0; i < self.density ; ++i){
            [textForScroll addObject:[NSString stringWithFormat:@"%02ld", (number + i) % self.density == 0?self.density:(number + i) % self.density]];
        }

    }
    
    [textForScroll addObject:numberText];
    
    if(!self.isAscending){
        textForScroll = [[[textForScroll reverseObjectEnumerator] allObjects] mutableCopy];
    }
    
    
    CGFloat height = 0;
    for(NSString *text in textForScroll){
        UILabel * textLabel = [self createLabel:text isBlue:isBlue];
        textLabel.frame = CGRectMake(0, height, CGRectGetWidth(scrollLayer.frame)-0.5, CGRectGetHeight(scrollLayer.frame));
        [scrollLayer addSublayer:textLabel.layer];
        scrollLayer.backgroundColor =[UIColor clearColor].CGColor ;
        [scrollLabels addObject:textLabel];
        height = CGRectGetMaxY(textLabel.frame);
    }
}


//- (void)createContentForLayer:(CAScrollLayer *)scrollLayer withNumberText:(NSString *)numberText
//{
//    NSInteger number = [numberText integerValue];
//    NSMutableArray *textForScroll = [NSMutableArray new];
//    
//    for(NSUInteger i = 0; i < self.density ; ++i){
//        [textForScroll addObject:[NSString stringWithFormat:@"%02ld", (number + i) % self.density == 0?self.density:(number + i) % self.density]];
//    }
//    
//    [textForScroll addObject:numberText];
//    
//    if(!self.isAscending){
//        textForScroll = [[[textForScroll reverseObjectEnumerator] allObjects] mutableCopy];
//    }
//    
//    
//    CGFloat height = 0;
//    for(NSString *text in textForScroll){
//        UILabel * textLabel = [self createLabel:text];
//        textLabel.frame = CGRectMake(0, height, CGRectGetWidth(scrollLayer.frame)-0.5, CGRectGetHeight(scrollLayer.frame));
//        [scrollLayer addSublayer:textLabel.layer];
//        scrollLayer.backgroundColor =[UIColor purpleColor].CGColor ;
//        [scrollLabels addObject:textLabel];
//        height = CGRectGetMaxY(textLabel.frame);
//    }
//}

- (UILabel *)createLabel:(NSString *)text isBlue:(BOOL)isBlue
{
    UILabel *view = [UILabel new];
    
//    view.textColor = self.textColor;
    view.textColor = isBlue?[UIColor blueColor]:[UIColor redColor];

    view.font = self.font;
    view.textAlignment = NSTextAlignmentCenter;
    view.backgroundColor = [UIColor clearColor] ;
    view.text = text;
    
    return view;
}

- (void)createAnimations
{
    CFTimeInterval duration = self.duration - ((numbersText.count +blueNumbersText.count) * self.durationOffset);
    CFTimeInterval offset = 0;
    
    for(CALayer *scrollLayer in scrollLayers){
        CGFloat maxY = [[scrollLayer.sublayers lastObject] frame].origin.y;
       
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
        
        animation.duration = duration + offset;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        if(self.isAscending){
            animation.fromValue = [NSNumber numberWithFloat:-maxY];
            animation.toValue = @0;
        }
        else{
            animation.fromValue = @0;
            animation.toValue = [NSNumber numberWithFloat:-maxY];
        }
        
        [scrollLayer addAnimation:animation forKey:@"NumberScrollAnimatedView"];
        
        offset += self.durationOffset;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
