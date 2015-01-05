//
//  CPTableViewCell.m
//  CirclePaint
//
//  Created by Jason on 2015/1/5.
//  Copyright (c) 2015年 Zoaks. All rights reserved.
//

#import "CPTableViewCell.h"

@implementation CPTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CPTableViewCell *)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CPTableViewCell" owner:nil options:nil] lastObject];
}

@end
