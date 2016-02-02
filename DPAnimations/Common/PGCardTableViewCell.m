//
//  PGCardTableViewCell.m
//  PerfectVideoEditor
//
//  Created by zangqilong on 14/12/4.
//  Copyright (c) 2014年 zangqilong. All rights reserved.
//

#import "PGCardTableViewCell.h"

@implementation PGCardTableViewCell

- (void)awakeFromNib {
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        
        self.cardView = [[UILabel alloc]initWithFrame:self.bounds];
        self.cardView.backgroundColor = [UIColor clearColor] ;
        [self.contentView addSubview:self.cardView];
    }
    return self;
}

- (void)startAnimationWithDelay:(CGFloat)delayTime
{
    self.cardView.transform =  CGAffineTransformMakeTranslation(320, 200);
    [UIView animateWithDuration:1. delay:delayTime usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        self.cardView.transform = CGAffineTransformIdentity;
    } completion:NULL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
