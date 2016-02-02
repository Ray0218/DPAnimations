//
//  ClockViewController.m
//  DPAnimations
//
//  Created by Ray on 15/5/6.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import "ClockViewController.h"
#import "PaneBehavior.h"


@interface ClockFace : CAShapeLayer

@property(nonatomic,assign)NSTimeInterval StartTime ;

@property(nonatomic,strong)CAShapeLayer *hourHand ;
@property(nonatomic,strong)CAShapeLayer *minuteHand ;


@end

@implementation ClockFace
@dynamic StartTime ;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0 , 0, 200, 200) ;
        self.backgroundColor = [UIColor whiteColor].CGColor ;
//        self.path = [UIBezierPath  bezierPathWithOvalInRect:self.bounds].CGPath ;
//        self.fillColor = [UIColor whiteColor].CGColor ;
//        self.strokeColor = [UIColor blackColor].CGColor ;
//        self.lineWidth = 4.0f ;
//        
//        
//        self.hourHand = [CAShapeLayer layer] ;
//        self.hourHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-2, -70, 4, 70)].CGPath ;
//        self.hourHand.fillColor = [UIColor blackColor].CGColor ;
//        self.hourHand.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) ;
//        [self addSublayer:self.hourHand];
//        
//        self.minuteHand = [CAShapeLayer layer] ;
//        self.minuteHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -90, 2, 90)].CGPath ;
//        self.minuteHand.fillColor = [UIColor blackColor].CGColor ;
//        self.minuteHand.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) ;
//        [self addSublayer:self.minuteHand];

    }
    return self;
}


+(BOOL)needsDisplayForKey:(NSString *)key{

    if ([@"StartTime" isEqualToString:key]) {
        return YES ;
    }
    
    return [super needsDisplayForKey:key] ;
}

-(void)display{

//    NSLog(@"time : %f",[[self presentationLayer]StartTime]);
    
     // 获取时间插值
    float time = [self.presentationLayer StartTime] ;
    
    // 创建绘制上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0) ;
    CGContextRef ctx = UIGraphicsGetCurrentContext() ;
    
     // 绘制时钟面板
    CGContextSetLineWidth(ctx, 4) ;
    CGContextStrokeRect(ctx, CGRectInset(self.bounds, 2, 2)) ;
    
    //绘制时针
    CGFloat angle = time/12.0*2.0*M_PI ;
    CGPoint center =CGPointMake( self.bounds.size.width/2, self.bounds.size.height/2) ;
    CGContextSetLineWidth(ctx, 4) ;
    CGContextMoveToPoint(ctx, center.x, center.y) ;
    CGContextAddLineToPoint(ctx, center.x+sin(angle)*80, center.y-cos(angle)*80);
    CGContextStrokePath(ctx) ;
    
    //绘制分针
    
    NSLog(@"%f,==== %f",time ,(time - floor(time))) ;
    angle = (time - floor(time))*2.0*M_PI ;
    CGContextSetLineWidth(ctx, 2) ;
    CGContextMoveToPoint(ctx, center.x, center.y) ;
    CGContextAddLineToPoint(ctx, center.x+sin(angle)*90, center.y-cos(angle)*90);
    CGContextStrokePath(ctx) ;
    
    
    //set backing image 设置 contents
    self.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();

}

-(id<CAAction>)actionForKey:(NSString *)event{

    if ([event isEqualToString:@"StartTime"]) {
        
//        NSLog(@"time : %f",[[self presentationLayer]StartTime]);

        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"StartTime"] ;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear] ;
        animation.fromValue = @([[self presentationLayer]StartTime]) ;
        return  animation ;
    }
    
    return  [super actionForKey:event];
}
@end

@interface ClockViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)ClockFace *clockFace ;
@property (nonatomic, strong) IBOutlet UITextField *textField;


@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor] ;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(pvt_endEdit)] ;
    
   
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pvt_tap:)];
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pvt_pan:)];
    pan.minimumNumberOfTouches = 2 ;
    [self.view addGestureRecognizer:pan];
    
    
    
    // 添加时钟面板 Layer
    self.clockFace = [[ClockFace alloc] init];
    self.clockFace.position = CGPointMake(self.view.bounds.size.width / 2, 180);
    [self.view.layer addSublayer:self.clockFace];
//
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 300, 200, 40)];
    self.textField.delegate =self ;
    self.textField.keyboardType = UIKeyboardTypeNumberPad ;
    self.textField.backgroundColor = [UIColor brownColor] ;
    self.textField.placeholder = @"输入数字" ;
    [self.view addSubview:self.textField];

}


#pragma mark-UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.clockFace.StartTime = [textField.text floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pvt_tap:(UITapGestureRecognizer*)tap{

    CGPoint point = [tap locationInView:self.view] ;
    if ([self.clockFace.presentationLayer hitTest:point]) {
        [self.textField resignFirstResponder];
    }
}

-(void)pvt_pan:(UIPanGestureRecognizer*)pan{


}
-(void)pvt_endEdit{

//   [UIView animateWithDuration:3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//       self.textField.frame = CGRectMake(120, 450, 200, 40);
//   } completion:^(BOOL finished) {
//       
//   }];
        
}

#pragma mark - Navigation

@end
