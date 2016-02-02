//
//  RootViewController.m
//  动画集合
//
//  Created by Ray on 15/3/25.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import "RootViewController.h"
#import "AnimationVC.h"
#import "ViewController.h"
#import "PGCardTableViewCell.h"
#import "ClockViewController.h"
#import "ChartViewController.h"
#import "TestBehaviorVC.h"

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"动画效果" ;
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    btn.frame = CGRectMake(60, 200, 200, 30) ;
    btn.backgroundColor = [UIColor brownColor] ;
    [btn setTitle:@"start" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pvt_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)pvt_click{
    
    RootViewController *vc =[[RootViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView * _tableview ;
    
    NSArray *_titlesArray ;
    
    UIView *_coverView ;
    BOOL isShowAnimation;
    
}

@end

@implementation RootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"动画效果" ;
    
    
    int i= 0 ;
    i = (++i)+(i++);
    NSLog(@"i = %d",i) ;
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone ;
    }
 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pvt_edit)];
    
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.backgroundColor = [UIColor grayColor] ;
    _tableview.delegate =self ;
    _tableview.dataSource = self ;
    _tableview.rowHeight = 30 ;
    _tableview.contentInset = UIEdgeInsetsMake(50, 0, 0, 0) ;
//    _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0) ;
    [self.view addSubview:_tableview];
    
    
    if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    
    _titlesArray = [NSArray arrayWithObjects:@"旋转动画",@"机选动画",@"封面展示",@"螺旋运动",@"画圆",@"摇骰子",@"星星动画",@"橡皮筋",@"钟表动画",@"柱形图",@"力学测试",@"其他动画", nil] ;
    
    isShowAnimation = YES;
    
    
}

-(void)pvt_edit{
    
    if (!_tableview.editing) {
        [_tableview setEditing:YES animated:YES];
        
    }else
        [_tableview setEditing:NO animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 20 ;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel *lab =[[UILabel alloc]init];
    lab.text = [NSString stringWithFormat:@"ddddd%d",section] ;
    return lab ;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20 ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titlesArray.count ;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseableIdentifier = @"reuseableIdentifier" ;
    PGCardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseableIdentifier] ;
    if (cell == nil) {
        cell = [[PGCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
        cell.selectedBackgroundView = ({
        
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor clearColor] ;
            view.layer.borderColor = [UIColor redColor].CGColor ;
            view.layer.borderWidth = 1 ;
            view ;
        });
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    cell.cardView.text = [_titlesArray objectAtIndex:indexPath.row];
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row<8) {
        AnimationVC *vc = [[AnimationVC alloc]initWithType:(AnimationType)indexPath.row];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 8){
        ClockViewController *vc = [[ClockViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    
    }else if (indexPath.row == 9){
        ChartViewController *vc = [[ChartViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if (indexPath.row == 10){
        TestBehaviorVC *vc = [[TestBehaviorVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } else{
        
        ViewController * item = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [self.navigationController pushViewController:item animated:YES];
        
    }
    
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static CGFloat initialDelay = 0.2f;
    static CGFloat stutter = 0.06f;
    
    if (isShowAnimation) {
        PGCardTableViewCell *cardCell = (PGCardTableViewCell *)cell;
        [cardCell startAnimationWithDelay:initialDelay + ((indexPath.row) * stutter)];
        if (indexPath.row == 10) {
            isShowAnimation = NO;
        }
    }
    
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert ;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES ;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
