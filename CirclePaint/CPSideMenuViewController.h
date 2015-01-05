//
//  CPSideMenuViewController.h
//  CirclePaint
//
//  Created by Jason on 2015/1/5.
//  Copyright (c) 2015年 Zoaks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WTRevealSideViewController)

-(void)showLeftMenu:(id)sender;

@end

@interface CPSideMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *displayTableView;
    
    NSArray *titleAndActionsBlock;
}

@property (nonatomic, strong) CPSideMenuViewController *sideMenuViewController;
+(CPSideMenuViewController *)sharedViewController;

@end
