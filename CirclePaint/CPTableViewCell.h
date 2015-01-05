//
//  CPTableViewCell.h
//  CirclePaint
//
//  Created by Jason on 2015/1/5.
//  Copyright (c) 2015年 Zoaks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIImageView *iconImageView;

+(CPTableViewCell *)cell;

@end
