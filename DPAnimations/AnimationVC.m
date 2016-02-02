//
//  AnimationVC.m
//  动画集合
//
//  Created by Ray on 15/3/25.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import "AnimationVC.h"
#import "CustomerLayer.h"
#import "NumberScrollerView.h"
#import "iCarousel.h"
#import "RubberBandView.h"
#import "Common/JTSlideShadowAnimation/JTSlideShadowAnimation.h"


@interface SWTextView : UITextView

@end

@implementation SWTextView

- (BOOL)canBecomeFirstResponder {
    return NO;
}
@end

@interface AnimationVC ()<iCarouselDataSource,iCarouselDelegate>
{

    CATextLayer *layers ;
    NumberScrollerView * _numberScrollView ;
    iCarousel *_carousel;
    UIImageView *imgArrowView ;
    
    UIImageView *image1 ,*image2,*image3 ;
    UIImageView *dong1,*dong2,*dong3;

    UIView *_coverView ;
    
    RubberBandView *_rubberBandView;
    
    AnimationType _type ;
    
    
    CGPoint _prevPoint ;
    CGPoint _currentPoint ;
    CGPoint _lastPoint ;
    
    UIImageView *_ballImgView ;
    CAKeyframeAnimation *_ballAnimation ;
    
    UIImageView *_lineImgView ;
    CAKeyframeAnimation *_lineAnimation ;
}

@property (nonatomic, strong) CALayer *colorLayer;


@end

@implementation AnimationVC

- (instancetype)initWithType:(AnimationType)type
{
    self = [super init];
    if (self) {
        
        _type = type ;
    }
    return self;
}

-(void)laoutViewWithType:(AnimationType)type{

    switch (type) {
        case kAnimaRota:
        {
        
            UILabel* lab3 =({
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(150, 250, 100,100)];
                lab.backgroundColor = [UIColor clearColor] ;
                lab.userInteractionEnabled = YES ;
                
                layers = [CATextLayer layer] ;
                layers.bounds = lab.bounds ;
                
                //choose a font
                UIFont *font = [UIFont systemFontOfSize:15];
                //set layer font
                CFStringRef fontName = (__bridge CFStringRef)font.fontName;
                CGFontRef fontRef = CGFontCreateWithFontName(fontName);
                layers.font = fontRef;
                layers.fontSize = font.pointSize;
                CGFontRelease(fontRef);
                layers.alignmentMode = kCAAlignmentCenter ;
                layers.wrapped = YES;
                layers.string = @"旋转" ;
                layers.backgroundColor = [UIColor blueColor].CGColor ;
                CAAnimation * anim =[CustomerLayer rotation:0.15 degree:M_PI direction:6 repeatCount:31] ;
                anim.delegate =self ;
                [layers addAnimation:anim forKey:@"labeltransform"];
                
                layers.masksToBounds = YES ;
                layers.contents = (id)[UIImage imageNamed:@"1.jpg"].CGImage ;
                [lab.layer addSublayer:layers];
                lab ;
                
            });
            [self.view addSubview:lab3];

        }
            break;
           
        case kAnimationRadom:{
        
            _numberScrollView = [[NumberScrollerView alloc]initWithFrame:CGRectMake(10, 100, 280, 100)];
            _numberScrollView.textColor = [UIColor whiteColor];
            _numberScrollView.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24];
            _numberScrollView.minLength = 3;
            _numberScrollView.clipsToBounds = NO ;
            _numberScrollView.isAscending = YES ;
            [self.view addSubview:_numberScrollView];
            
            
            _lineImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gan.png"]];
            _lineImgView.backgroundColor = [UIColor greenColor] ;

            _lineImgView.frame = CGRectMake(303, 87, 7, 80);
            [self.view addSubview:_lineImgView];
            
           
            
            CATransform3D transform = CATransform3DIdentity ;
            transform.m34 = -1.0/200.0 ;
            _lineImgView.layer.anchorPoint = CGPointMake(0.5, 1) ;
            transform = CATransform3DRotate(transform, M_PI_4*1, 1, 0, 0) ;
            _lineImgView.layer.transform = transform ;
            
            
        
            
            _lineAnimation  = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.x"] ;
            _lineAnimation.values = @[[NSValue valueWithCATransform3D:transform],[NSValue valueWithCATransform3D:CATransform3DRotate(transform, -M_PI_4, 1, 1, 0)]] ;
            _lineAnimation.keyTimes =@[[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:1]] ;
            _lineAnimation.calculationMode = kCAAnimationCubicPaced ;
            _lineAnimation.duration = 2 ;
            _lineAnimation.cumulative = YES ;
            _lineAnimation.autoreverses = YES ;
//            _lineAnimation.fillMode = kCAFillModeForwards ;
//            _lineAnimation.removedOnCompletion = NO ;
            

            
//            _ballImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ball.png"]];
//            _ballImgView.frame = CGRectMake(300, 85, 15, 15);
//            [self.view addSubview:_ballImgView];
//            _ballAnimation  = [CAKeyframeAnimation animationWithKeyPath:@"position.y"] ;
//            _ballAnimation.values = @[[NSNumber numberWithFloat:85+7.5],[NSNumber numberWithFloat:135],[NSNumber numberWithFloat:85+7.5]] ;
//            _ballAnimation.keyTimes =@[[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:1]] ;
//            _ballAnimation.calculationMode = kCAAnimationLinear ;
//            _ballAnimation.duration = 2 ;
//            _ballAnimation.fillMode = kCAFillModeForwards ;
//            _ballAnimation.removedOnCompletion = NO ;
//            
            
            
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem] ;
            [btn setTitle:@"点击机选" forState:UIControlStateNormal];
            btn.frame =  CGRectMake(100, 400, 100, 40) ;
            [btn addTarget:self action:@selector(pvt_number) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
        
        }
            break ;
            
        case kAnimationShow:{
        
        
            _carousel = [[iCarousel alloc]initWithFrame:self.view.bounds];
            _carousel.delegate =self ;
            _carousel.dataSource = self ;
            [self.view addSubview:_carousel];
        }
            break ;
        case kAnimationScrew:{
            [self pvt_createCircleAnimation] ;
        }
            break ;
            case kAnimationDrawCircle:
            [self drawCircle];
            break ;
        case kAnimationSezhi:{
            [self pvt_testBoBing];
        }
            break ;
        case kAnimationStar:{
            [self drawStar];
        }
            break ;
        case kAnimationRuber:{
            [self testRubber];
        }break ;
        default:
            break;
    }
}

-(void)pvt_number{

//    if ([_ballImgView.layer animationForKey:@"ballAnimation"]  == nil) {
//        [_ballImgView.layer addAnimation:_ballAnimation forKey:@"ballAnimation"];
//    }else{
//        [_ballAnimation runActionForKey:@"position.y" object:_ballImgView.layer arguments:nil];
//
//    }
    
    if ([_lineImgView.layer animationForKey:@"lineAnimation"] == nil) {
        [_lineImgView.layer addAnimation:_lineAnimation forKey:@"lineAnimation"];
    }else{
        [_lineAnimation runActionForKey:@"transform.rotation.x" object:_lineImgView.layer arguments:nil];
    }
    
   
    [_numberScrollView prepareAnimations];

    [_numberScrollView startAnimation];

}

#pragma mark- 橡皮筋动画
-(void)testRubber{
    
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 300, 100, 100);
self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
    
    

_rubberBandView = [[RubberBandView alloc]initWithFrame:CGRectMake(10, 200, 300, 20) layerProperty:MakeRBProperty(0, 0, 40, 4, 40)];
_rubberBandView.backgroundColor =[UIColor brownColor] ;
    _rubberBandView.fillColor = [UIColor redColor];
    _rubberBandView.duration = 0.5;
    
    [self.view addSubview:_rubberBandView];
    
    _rubberBandView.startAction = ^(){
        
        NSLog(@"====startAction==== ") ;
    } ;
    
    [self pvtTestShadow];
    
    [self testMark];

}

#pragma mark- 蒙版测试

-(void)testMark{

    
//    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 420, 300, 40)];
//    lable.text = @"Test layer mask layer with animation" ;
//    [self.view addSubview:lable];
//    lable.textAlignment = NSTextAlignmentCenter ;
//    lable.textColor = [UIColor whiteColor] ;
//    lable.backgroundColor =[UIColor colorWithWhite:0.4 alpha:1] ;
    
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn setTitle:@"Test layer mask layer with animation" forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 420, 300, 40) ;
    btn.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1] ;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];

    
       //蒙版层
    CAGradientLayer *markLayer = [CAGradientLayer layer] ;
    markLayer.shadowColor = [UIColor greenColor].CGColor;
    markLayer.shadowOffset = CGSizeMake(60, 50) ;
    
    markLayer.frame = btn.bounds;
    markLayer.anchorPoint = CGPointMake(0.5, 0.5) ;
    
    CGFloat gradientSize = 40.0 / 300.0 ;

    markLayer.colors = @[(id)[UIColor colorWithWhite:1 alpha:0.3].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor colorWithWhite:1 alpha:0.3].CGColor] ;
    markLayer.locations = @[@0,
                            [NSNumber numberWithFloat:(gradientSize/2.0)],
                            [NSNumber numberWithFloat:gradientSize]
                            ];
    markLayer.startPoint = CGPointMake(0.0-gradientSize, 0.) ;
    markLayer.endPoint = CGPointMake(1+gradientSize, 0.) ;
    btn.layer.mask = markLayer ;
    
     CABasicAnimation *animatio = [CABasicAnimation animationWithKeyPath:@"locations"] ;
    animatio.fromValue =   @[@0,
    [NSNumber numberWithFloat:(gradientSize/2.0)],
    [NSNumber numberWithFloat:gradientSize]
    ];
    animatio.toValue = @[
                         [NSNumber numberWithFloat:(1-gradientSize)],
                         [NSNumber numberWithFloat:(1-gradientSize/2.0)],@1
                         ];
    animatio.repeatCount = FLT_MAX ;
    animatio.duration = 2 ;
    animatio.removedOnCompletion = NO ;
    animatio.delegate = self ;
    animatio.fillMode = kCAFillModeForwards ;
    [markLayer addAnimation:animatio forKey:@"animateGradient"];
    

}


#pragma mark- 滑动
-(void)pvtTestShadow{
    
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn setTitle: @"Click to start or stop the animation" forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 480, 300, 40) ;
    btn.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1] ;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
 
    JTSlideShadowAnimation *shadowView = [JTSlideShadowAnimation new] ;
    shadowView.animatedView = btn ;
    shadowView.shadowWidth = 40 ;
    
    [self.view addSubview:btn];
    [shadowView start];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject] ;
    
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //check if we've tapped the moving layer
    if ([self.colorLayer.presentationLayer hitTest:point]) {

        //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / FLT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
        //otherwise (slowly) move the layer to new position
        [CATransaction begin];
//        [CATransaction setDisableActions:YES];
        [CATransaction setAnimationDuration:4.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
    
    
    _prevPoint = [touch previousLocationInView:self.view] ;
    
//    NSLog(@"prevPoint =%@,point = %@",prevPoint,point) ;
    
    NSLog(@"=== aaaaaaaaaaa touchesBegan ==") ;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@" === bbbbbbbbbb touchesEnded == ") ;
    _lastPoint = [[touches anyObject]locationInView:self.view];
    [_rubberBandView recoverStateAnimation];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    NSLog(@"==dddddddddd touchesMoved ==") ;
    
    UITouch *touch = [touches anyObject] ;

    _currentPoint = [touch locationInView:self.view] ;

    CGFloat offSet = _currentPoint.x - _prevPoint.x;

    [_rubberBandView pullWithOffSet:offSet*0.5];

}

#pragma mark- 星星动画
-(void)drawStar{

    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 320 - 0, 360 - 0);
    CGPathAddCurveToPoint(path, NULL, 320 - 50.0, 320 - 100.0, 320 - 50.0, 320 - 120.0, 320 - 50.0, 320 - 155.0);
    CGPathAddCurveToPoint(path, NULL, 320 - 50.0, 320 - 275.0, 320 - 150.0, 320 - 275.0, 160.0, 160.0);

//    CAShapeLayer *shapLayer = [CAShapeLayer layer] ;
//    shapLayer.path  = path ;
//    [self.view.layer addSublayer:shapLayer];
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer] ;
//    emitterLayer.backgroundColor = [UIColor greenColor].CGColor ;
    emitterLayer.bounds = self.view.bounds ;
    emitterLayer.position = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    emitterLayer.emitterPosition = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);    // 坐标
//
    emitterLayer.emitterSize = self.view.bounds.size ;
    emitterLayer.emitterMode = kCAEmitterLayerPoints ;
    emitterLayer.renderMode = kCAEmitterLayerAdditive ;
    emitterLayer.emitterShape = kCAEmitterLayerSphere;      // 粒子形状（球状）

    
    [self.view.layer addSublayer:emitterLayer];
    
    
    CAEmitterCell *cell = ({
    
        CAEmitterCell * cell = [CAEmitterCell emitterCell] ;
        cell.scale = 0.3 ;
        cell.scaleRange = 0.1 ;
        cell.birthRate = 120 ;
        cell.lifetime = 1 ;
        cell.spin = 12 ;
        cell.velocity = 50 ;
        cell.emissionLongitude = M_PI*2;
        cell.emissionRange = M_PI*2;
        cell.velocityRange = 100;
        cell.contents = (id)[[UIImage imageNamed:@"starIcon.jpg"] CGImage] ;
        cell ;
    });
    emitterLayer.emitterCells = @[cell] ;
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"emitterPosition"] ;
    animation.path = path ;
    animation.repeatCount = MAXFLOAT ;
    animation.duration = 4 ;
    [emitterLayer addAnimation:animation forKey:nil];
    
    
    CGMutablePathRef path2 = CGPathCreateMutable();
    
    CGPathMoveToPoint(path2, NULL, 0, 70);
    CGPathAddCurveToPoint(path2, NULL, 50.0, 205.0, 150.0, 375.0, 160.0, 160.0);
    
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.bounds = self.view.bounds ;
    emitter.renderMode = kCAEmitterLayerAdditive ;
//   emitter.emitterMode = kCAEmitterLayerPoints ;

    emitter.position =
    emitter.emitterPosition=CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    emitter.emitterSize = self.view.bounds.size ;
    
    
   
    emitter.emitterCells = @[cell] ;
    [self.view.layer addSublayer:emitter];
    
    
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"emitterPosition"] ;
    animation2.path = path2 ;
    animation2.repeatCount = MAXFLOAT ;
    animation2.duration = 4 ;
    [emitter addAnimation:animation2 forKey:nil];

}


#pragma mark- 画圆
-(void)drawCircle{
    
    
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    //    //画弧
    //    [path moveToPoint:CGPointMake(0, 350)];
    //    [path addQuadCurveToPoint:CGPointMake(320, 350) controlPoint:CGPointMake(160, 150)];
    
    //    画圆
    [path addArcWithCenter:CGPointZero radius:60 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    
    CAShapeLayer* shapLayer = [CAShapeLayer layer] ;
    shapLayer.backgroundColor  = [UIColor clearColor].CGColor ;
    shapLayer.fillColor = [UIColor clearColor].CGColor ;
    shapLayer.path = path.CGPath ;
    shapLayer.strokeColor = [UIColor brownColor].CGColor ;
    shapLayer.lineWidth = 10 ;
    shapLayer.position = CGPointMake(240, 230) ;
    shapLayer.anchorPoint = CGPointMake(0.5, 0.5) ;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration =4 ;
    animation.fromValue = [NSNumber numberWithInt:0] ;
    animation.toValue = [NSNumber numberWithInt:1] ;
    animation.delegate = self ;
    [shapLayer addAnimation:animation forKey:@"key"];
      
    [self.view.layer addSublayer:shapLayer];
    
    
    UIImageView * imgView =[[UIImageView alloc]initWithFrame:CGRectMake(40, 70, 80, 80)];
    [self.view addSubview:imgView];
    
    imgView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"1.jpg"], [UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.jpg"],[UIImage imageNamed:@"4.jpg"],[UIImage imageNamed:@"5.jpg"],[UIImage imageNamed:@"6.jpg"],[UIImage imageNamed:@"7.jpg"],nil] ;
    imgView.animationDuration = 2 ;
    imgView.animationRepeatCount = 2000 ;
    [imgView startAnimating];
    
    
    
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 =- 1.0 / 400.0;
//    transform = CATransform3DTranslate(transform, 0, 0, -100);

    transform = CATransform3DRotate(transform, 60.0f * M_PI / 180.0f, 1.f, 0.0f, 0.0f);
    
    
    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    backgroundView.userInteractionEnabled = YES ;
    backgroundView.frame =CGRectMake(40, 300, 250, 200) ;
//    [self.view addSubview:backgroundView];
    
    
    
    

    SWTextView *textView = [[SWTextView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)] ;
//    textView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0) ;
    textView.showsVerticalScrollIndicator = NO ;
    textView.showsHorizontalScrollIndicator = NO ;
    textView.backgroundColor = [UIColor yellowColor] ;
    textView.textColor = [UIColor redColor] ;
//    textView.scrollEnabled = NO ;
 
    textView.text = @" CATransform3D transform = CATransform3DIdentity transform.m34 = - 1 / 500;transform = CATransform3DRotate(transform, 60.0f * M_PI / 180.0f, 1.f, 0.0f, 0.0f); imgView.layer.transform = transform; imgView.layer.zPosition = 500 ; imgView.layer.position = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/3);CATransform3D transform = CATransform3DIdentity transform.m34 = - 1 / 500;transform = \n  \n \nCATransform3DRotate(transform, 60.0f * M_PI / 180.0f, 1.f, 0.0f, 0.0f); imgView.layer.transform = transform; imgView.layer.zPosition = 500 ; imgView.layer.position = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/3);CATransform3D transform = CATransform3DIdentity transform.m34 = - 1 / 500;transform = CATransform3DRotate(transform, 60.0f * M_PI / 180.0f, 1.f, 0.0f, 0.0f); imgView.layer.transform = transform; imgView.layer.zPosition = 500 ; imgView.layer.position = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/3);CATransform3D transform = CATransform3DIdentity transform.m34 = - 1 / 500;transform = \n  \n \nCATransform3DRotate(transform, 60.0f * M_PI / 180.0f, 1.f, 0.0f, 0.0f); imgView.layer.transform = transform; imgView.layer.zPosition = 500 ; imgView.layer.position = CGPointMake([[UIScreen 底部结束" ;
    [self.view addSubview:textView];
    
    
    self.view.layer.transform = transform ;
    self.view.layer.zPosition = 500;
    textView.layer.position = CGPointMake(160, 400);

    
    
}
#pragma mark-色子动画
-(void)pvt_testBoBing{
    
    _coverView = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)]; ;
    _coverView.layer.borderWidth = 2 ;
    _coverView.layer.borderColor = [UIColor blueColor].CGColor ;
    _coverView.backgroundColor  = [UIColor greenColor] ;
    [self.view addSubview:_coverView];
    
    //逐个添加骰子
    UIImageView *_image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1@2x.png"]];
    _image1.frame = CGRectMake(15.0, 30.0, 45.0, 45.0);
    image1 = _image1;
    [_coverView addSubview:image1];
//    [self.view addSubview:_image1];
    UIImageView *_image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2@2x.png"]];
    _image2.frame = CGRectMake(75.0,25.0, 45.0, 45.0);
    image2 = _image2;
    [_coverView addSubview:_image2];
    UIImageView *_image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3@2x.png"]];
    _image3.frame = CGRectMake(95.0, 70.0, 45.0, 45.0);
    image3 = _image3;
    [_coverView addSubview:_image3];
    
    //添加按钮
    UIButton *btn_bobing = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn_bobing setTitle:@"点击" forState:UIControlStateNormal];
    [btn_bobing addTarget:self action:@selector(bobing)  forControlEvents:UIControlEventTouchUpInside];
    btn_bobing.frame = CGRectMake(100.0, 400.0, 80.0, 50.0);
    [self.view addSubview:btn_bobing];
    
    
    
}
- (void)bobing
{
    
    //隐藏初始位置的骰子
    image1.hidden = YES;
    image2.hidden = YES;
    image3.hidden = YES ;
    
    dong1.hidden = YES;
    dong2.hidden = YES;
    dong3.hidden = YES;
    //转动骰子的载入
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"dong1@2x.png"],
                         [UIImage imageNamed:@"dong2@2x.png"],
                         [UIImage imageNamed:@"dong3@2x.png"],nil];
    //骰子1的转动图片切换
    UIImageView *dong11 = [[UIImageView alloc]initWithFrame:CGRectMake(15.0, 30.0, 45.0, 45.0)];
    dong11.animationImages = myImages;
    dong11.animationDuration = 0.5;
    [dong11 startAnimating];
    [_coverView addSubview:dong11];
    dong1 = dong11;
    //骰子2的转动图片切换
    UIImageView *dong12 = [[UIImageView alloc]initWithFrame:CGRectMake(75.0,25.0, 45.0, 45.0)];
    dong12.animationImages = myImages;
    dong12.animationDuration = 0.5;
    [dong12 startAnimating];
    [_coverView addSubview:dong12];
    dong2 = dong12;
    //骰子3的转动图片切换
    UIImageView *dong13 = [[UIImageView alloc] initWithFrame:CGRectMake(95.0, 70.0, 45.0, 45.0)];
    dong13.animationImages = myImages;
    dong13.animationDuration = 0.5;
    [dong13 startAnimating];
    [_coverView addSubview:dong13];
    dong3 = dong13;
    
    //******************旋转动画******************
    //设置动画
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    [spin setByValue:[NSNumber numberWithFloat:M_PI]];
    [spin setToValue:[NSNumber numberWithFloat:M_PI * 16.0]];
    [spin setDuration:4];
    
    
    //******************位置变化******************
    //骰子1的位置变化
    
    CGPoint p1 = CGPointMake(25.0,30.0);
    CGPoint p2 = CGPointMake(175.0, 146.0);
    CGPoint p3 = CGPointMake(80.0, 96.0);
    CGPoint p4 = CGPointMake(140.0, 176.0);

    CGPoint p5 = CGPointMake(60.0, 100.0);
    NSArray *keypoint = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:p1],[NSValue valueWithCGPoint:p2],[NSValue valueWithCGPoint:p3],[NSValue valueWithCGPoint:p4],[NSValue valueWithCGPoint:p5], nil];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setValues:keypoint];
    [animation setDuration:4.0];
    
    [animation setDelegate:self];
    [dong11.layer setPosition:CGPointMake(60.0, 100.0)];
    
    //骰子2的位置变化
    CGPoint p21 = CGPointMake(75.0, 25.0);
    CGPoint p22 = CGPointMake(160.0,110.0);
    CGPoint p23 = CGPointMake(85.0, 90.0);
    CGPoint p24 = CGPointMake(100.0, 75.0);
    NSArray *keypoint2 = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:p21],[NSValue valueWithCGPoint:p22],[NSValue valueWithCGPoint:p23],[NSValue valueWithCGPoint:p24], nil];
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation2 setValues:keypoint2];
    [animation2 setDuration:4.0];
    [animation2 setDelegate:self];
    [dong12.layer setPosition:CGPointMake(100.0, 100.0)];
    //骰子3的位置变化
    CGPoint p31 = CGPointMake(95.0, 35.0);
    CGPoint p32 = CGPointMake(75.0, 95.0);
    CGPoint p33 = CGPointMake(140.0, 120.0);
    CGPoint p34 = CGPointMake(130.0, 100.0);
    NSArray *keypoint3 = [[NSArray alloc] initWithObjects:[NSValue valueWithCGPoint:p31],[NSValue valueWithCGPoint:p32],[NSValue valueWithCGPoint:p33],[NSValue valueWithCGPoint:p34], nil];
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation3 setValues:keypoint3];
    [animation3 setDuration:4.0];
    [animation3 setDelegate:self];
    [dong13.layer setPosition:CGPointMake(130.0,100.0)];
    
    //******************动画组合******************
    //骰子1的动画组合
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects: animation,spin,nil];
    animGroup.duration = 4;
    [animGroup setDelegate:self];
    animGroup.fillMode = kCAFillModeForwards ;
    animGroup.removedOnCompletion = NO ;
    [[dong11 layer] addAnimation:animGroup forKey:@"position"];
    //骰子2的动画组合
    CAAnimationGroup *animGroup2 = [CAAnimationGroup animation];
    animGroup2.animations = [NSArray arrayWithObjects: animation2,spin,nil];
    animGroup2.duration = 4;
    [animGroup2 setDelegate:self];
    [[dong12 layer] addAnimation:animGroup2 forKey:@"position"];
    
    
    //骰子3的动画组合
    CAAnimationGroup *animGroup3 = [CAAnimationGroup animation];
    animGroup3.animations = [NSArray arrayWithObjects:animation3, spin,nil];
    animGroup3.duration = 4;
    [animGroup3 setDelegate:self];
    [[dong13 layer] addAnimation:animGroup3 forKey:@"position"];
    
    if (imgArrowView.layer.speed) {
        [self pauseLayer:imgArrowView.layer];
    }else{
        [self resumeLayer:imgArrowView.layer];
    }
    
    
}


#pragma mark- 螺旋动画


-(void)pvt_Pause{
    
  
    if (imgArrowView.layer.speed) {
        [self pauseLayer:imgArrowView.layer];
    }else{
        [self resumeLayer:imgArrowView.layer];
    }
}

#pragma mark- 动画的暂停
//暂停layer上面的动画
- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}


//继续layer上面的动画
- (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

-(void)pvt_createCircleAnimation{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem] ;
    [btn setTitle:@"暂停/开始" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(100, 100, 100, 40) ;
    [btn addTarget:self action:@selector(pvt_Pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
    imgArrowView =[[UIImageView alloc]initWithFrame:CGRectMake(100, 250, 40, 40)];
    imgArrowView.image = [UIImage imageNamed:@"plane.jpg"] ;
    [self.view addSubview:imgArrowView];
    
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"] ;
    
 
    UIBezierPath *path = [UIBezierPath bezierPath] ;
    [path moveToPoint:CGPointMake(310, 350)];
    
    float radius = 150 ;
    float endAngel = M_PI/20 ;
    [path addArcWithCenter:CGPointMake(160, 350) radius:radius startAngle:0 endAngle:endAngel clockwise:YES];
    for (int i=1; i<400; i++) {
        
        [path addArcWithCenter:CGPointMake(160, 350) radius:radius-i*0.25 startAngle:endAngel endAngle:endAngel+M_PI/20 clockwise:YES];
        endAngel+=M_PI/20 ;
    }
    keyAnimation.rotationMode = kCAAnimationRotateAuto ;
    keyAnimation.path = path.CGPath ;
    
    
    keyAnimation.duration = 20 ;
    keyAnimation.autoreverses = NO ;
    keyAnimation.removedOnCompletion = NO ;
    keyAnimation.fillMode =  kCAFillModeForwards ;
    keyAnimation.repeatCount = FLT_MAX ;
    keyAnimation.delegate =self ;
    
    [imgArrowView.layer addAnimation:keyAnimation forKey:@"key"];
    
    [keyAnimation runActionForKey:@"" object:nil arguments:nil];
    CAShapeLayer *layer = [CAShapeLayer layer] ;
    layer.backgroundColor  = [UIColor greenColor].CGColor ;
    layer.fillColor = [UIColor clearColor].CGColor ;
    layer.path = path.CGPath ;
    layer.borderWidth = 3 ;
    layer.strokeColor = [UIColor brownColor].CGColor ;

    [self.view.layer addSublayer:layer];
    
    

    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1] ;
    [self laoutViewWithType:_type];

    
}

#pragma mark- CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim{

    layers.contents = (id)[UIImage imageNamed:@"1.jpg"].CGImage ;

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    if (_type == kAnimaRota) {
        layers.contents = (id)[UIImage imageNamed:@"7.jpg"].CGImage ;

    }else  if (_type == kAnimationSezhi) {
        //停止骰子自身的转动
        [dong1 stopAnimating];
        [dong2 stopAnimating];
        [dong3 stopAnimating];
        
        
        //*************产生随机数，真正博饼**************
        srand((unsigned)time(0));  //不加这句每次产生的随机数不变
        //骰子1的结果
        int result1 = (rand() % 5) +1 ;  //产生1～6的数
        switch (result1) {
            case 1:dong1.image = [UIImage imageNamed:@"1@2x.png"];break;
            case 2:dong1.image = [UIImage imageNamed:@"2@2x.png"];break;
            case 3:dong1.image = [UIImage imageNamed:@"3@2x.png"];break;
            case 4:dong1.image = [UIImage imageNamed:@"4@2x.png"];break;
            case 5:dong1.image = [UIImage imageNamed:@"5@2x.png"];break;
            case 6:dong1.image = [UIImage imageNamed:@"6@2x.png"];break;
        }
        //骰子2的结果
        int result2 = (rand() % 5) +1 ;  //产生1～6的数
        switch (result2) {
            case 1:dong2.image = [UIImage imageNamed:@"1@2x.png"];break;
            case 2:dong2.image = [UIImage imageNamed:@"2@2x.png"];break;
            case 3:dong2.image = [UIImage imageNamed:@"3@2x.png"];break;
            case 4:dong2.image = [UIImage imageNamed:@"4@2x.png"];break;
            case 5:dong2.image = [UIImage imageNamed:@"5@2x.png"];break;
            case 6:dong2.image = [UIImage imageNamed:@"6@2x.png"];break;
        }
        //骰子3的结果
        int result3 = (rand() % 5) +1 ;  //产生1～6的数
        switch (result3) {
            case 1:dong3.image = [UIImage imageNamed:@"1@2x.png"];break;
            case 2:dong3.image = [UIImage imageNamed:@"2@2x.png"];break;
            case 3:dong3.image = [UIImage imageNamed:@"3@2x.png"];break;
            case 4:dong3.image = [UIImage imageNamed:@"4@2x.png"];break;
            case 5:dong3.image = [UIImage imageNamed:@"5@2x.png"];break;
            case 6:dong3.image = [UIImage imageNamed:@"6@2x.png"];break;
        }
        
        
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"] ;
        animation.toValue = [NSNumber numberWithFloat:0.5] ;
        animation.duration = 2 ;
        CAKeyframeAnimation *opcAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"] ;
        opcAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0], [NSNumber numberWithFloat:0],nil] ;
        opcAnimation.keyTimes = [NSArray arrayWithObjects:
                                 [NSNumber numberWithFloat:0.8],
                                 [NSNumber numberWithFloat:1.0], nil];
        opcAnimation.duration = 2;
        
        CAAnimationGroup *group = [CAAnimationGroup animation] ;
        group.animations = @[animation] ;
        group.duration = 2 ;
        group.autoreverses=NO;
        group.removedOnCompletion=NO;
        group.fillMode=kCAFillModeForwards;
        [dong1.layer addAnimation:group forKey:nil];
        [dong2.layer addAnimation:group forKey:nil];
        [dong3.layer addAnimation:group forKey:nil];
        
        
        
//        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"] ;
//        
//        keyAnimation.values = [NSArray arrayWithObjects:(id)[UIImage imageNamed:@"1.jpg"].CGImage, (id)[UIImage imageNamed:@"7.jpg"].CGImage,nil] ;
//        keyAnimation.keyTimes = [NSArray arrayWithObjects:
//                                 [NSNumber numberWithFloat:0.95],
//                                 [NSNumber numberWithFloat:1.0], nil];
//        keyAnimation.duration = 4 ;
//        keyAnimation.repeatCount = 1 ;
//        keyAnimation.fillMode = kCAFillModeForwards ;
//        keyAnimation.removedOnCompletion = NO ;
//        
//        
//        layers.contents = (id)[UIImage imageNamed:@"7.jpg"].CGImage ;
//        
//        CATransform3D transfor = CATransform3DIdentity ;
//        transfor.m34 = -1/500 ;

    }else if (_type == kAnimationRuber) {
}

}
#pragma mark -iCarouselDataSource

-(NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    return 30 ;
}

-(UIView*)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index{
    
    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%lu.jpg",(unsigned long)index]]] ;
    
    view.frame = CGRectMake(70, 80, 180, 260);
    view.backgroundColor = [UIColor greenColor] ;
    return view;
    
}

-(NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel{
    
    return 30 ;
}
-(NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel{
    return 0 ;
}

#pragma mark -iCarouselDelegate
- (BOOL)carouselShouldWrap:(iCarousel *)carousel{
    
    return YES ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
