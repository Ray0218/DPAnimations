//
//  ChartViewController.m
//  DPAnimations
//
//  Created by Ray on 15/5/8.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

#import "ChartViewController.h"
#import "UUChart.h"

@interface ChartViewController ()<UITableViewDelegate,UITableViewDataSource>{

    UITableView *_tableView ;

}

@end

@implementation ChartViewController


-(void)setup{

    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate =self ;
    _tableView.dataSource =self ;
    _tableView.rowHeight = 150 ;
    [self.view addSubview:_tableView];
}

#pragma tableViewDleegate And Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20 ;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentify = @"reuseIdentify" ;
    ChartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentify] ;
    if (cell == nil) {
        cell = [[ChartViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
    }
    [cell configUI:indexPath];
    
    return cell ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
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

@interface ChartViewCell (){

    UUChart *_chartView ;
    NSIndexPath *_indexPath ;
    
}

@end
@implementation ChartViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        
       
    }
    return self;
}


-(NSArray*)getRandom{

    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:6];
    float num = 0.0; ;
    for (int i=0; i<6; i++) {
        num  = arc4random()%10+1 ;
        [arr addObject:[NSString stringWithFormat:@"%.2f",num/10.0]] ;


    }
    
    return arr ;
}
- (void)configUI:(NSIndexPath *)indexPath
{
    if (_chartView) {
        [_chartView removeFromSuperview];
        _chartView = nil ;
    }
    
    _indexPath = indexPath ;
    
    _chartView = [[UUChart alloc]initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, CGRectGetHeight(self.contentView.frame)-20)];
    
    [_chartView createBars:[self getRandom] withHight:130];
    [_chartView showInView:self.contentView];
    
    
}

@end


