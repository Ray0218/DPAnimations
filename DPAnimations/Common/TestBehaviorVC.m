//
//  TestBehaviorVC.m
//  DPAnimations
//
//  Created by Ray on 15/5/11.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import "TestBehaviorVC.h"
#import "PaneBehavior.h"

@class DraggableView ;
@protocol DraggableProtocol <NSObject>


- (void)draggableViewBeganDragging:(DraggableView *)view ;

- (void)draggableView:(DraggableView *)view draggingEndedWithVelocity:(CGPoint)velocity ;


@end

@interface DraggableView : UIView


@property(nonatomic,weak)id<DraggableProtocol>delegate ;

@end


@implementation DraggableView

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];

    }
    return self;
}

-(void)setUP{

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pvt_pan:)];
    [self addGestureRecognizer:pan];
}

-(void)pvt_pan:(UIPanGestureRecognizer*)pan{


    CGPoint point = [pan translationInView:self.superview] ;
    self.center = CGPointMake(self.center.x, self.center.y+point.y) ;
    
    [pan setTranslation:CGPointZero inView:self.superview];
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [pan velocityInView:self.superview];
        velocity.x = 0 ;
        [self.delegate draggableView:self draggingEndedWithVelocity:velocity];
    }else if (pan.state == UIGestureRecognizerStateBegan){
        [self.delegate draggableViewBeganDragging:self];
    }
}


@end


@interface TestBehaviorVC ()<DraggableProtocol>{

    DraggableView *_dragView ;
    
    UIDynamicAnimator *_animator ;
    
    DragState _state ;
    
    
}
@property(nonatomic,strong)PaneBehavior *behavior ;

//@property(nonatomic)CGPoint targetPoint ;

@end

@implementation TestBehaviorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor] ;
    
    CGSize size = self.view.bounds.size;
    _dragView = [[DraggableView alloc]initWithFrame:CGRectMake(0, size.height * .75, size.width, size.height)];
    _dragView.backgroundColor = [UIColor greenColor] ;
    _dragView.delegate =self ;
    [self.view addSubview:_dragView];
    
    
    
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];

 
}
-(CGPoint)targetPoint{
    CGSize size = self.view.bounds.size;

    return _state == StateClose >0?CGPointMake(size.width/2, size.height * 1.25) :CGPointMake(size.width/2, size.height/2 + 150) ;
}
#pragma mark DraggableViewDelegate

- (void)draggableViewBeganDragging:(DraggableView *)view
{
    [_animator removeAllBehaviors];

}
- (void)draggableView:(DraggableView *)view draggingEndedWithVelocity:(CGPoint)velocity
{

    DragState stat = velocity.y>=0 ?StateClose :StateOpen ;
    _state = stat ;
    
    [self animatePaneWithInitialVelocity:velocity] ;

}

-(void)animatePaneWithInitialVelocity:(CGPoint)velocity{


    if (!self.behavior) {
        self.behavior = [[PaneBehavior alloc]initWithItem:_dragView];
    }
    
    self.behavior.velocity = velocity ;
    self.behavior.targetPoint = self.targetPoint ;
    [_animator addBehavior:self.behavior];
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
