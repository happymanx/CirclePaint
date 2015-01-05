//
//  CPSideMenuViewController.m
//  CirclePaint
//
//  Created by Jason on 2015/1/5.
//  Copyright (c) 2015年 Zoaks. All rights reserved.
//

#import "AppDelegate.h"

#import "CPSideMenuViewController.h"
#import "PPRevealSideViewController.h"

#import "CPTableViewCell.h"

static NSString *const ZSLeftMenuImage = @"ZSLeftMenuImage";
static NSString *const ZSLeftMenuBlock = @"ZSLeftMenuBlock";
static NSString *const ZSLeftMenuTitle = @"ZSLeftMenuTitle";

@implementation PPRevealSideViewController (StatusbarColor)

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end

@implementation UIViewController (WTRevealSideViewController)
-(void)showLeftMenu:(id)sender
{
    PPRevealSideViewController *pp = [AppDelegate sharedAppDelegate].revealSideViewController;
    
    CPSideMenuViewController *leftVC = [CPSideMenuViewController sharedViewController];
    leftVC.navigationController.navigationBarHidden = YES;
    [pp pushViewController:leftVC onDirection:PPRevealSideDirectionLeft animated:YES];
}
@end

@interface CPSideMenuViewController ()

@end

@implementation CPSideMenuViewController

+(CPSideMenuViewController *)sharedViewController
{
    static CPSideMenuViewController *sharedViewController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedViewController = [[CPSideMenuViewController alloc] init];
    });
    return sharedViewController;
}

- (id)init
{
    self = [super initWithNibName:@"CPSideMenuViewController" bundle:nil];
    if (self) {
        titleAndActionsBlock = @[
                                 @{ZSLeftMenuImage: @"zoaks.png",
                                   ZSLeftMenuTitle: @"關於我們",
                                   ZSLeftMenuBlock:^{
                                       
                                       //                                       GGAboutUsViewController *leftFirstVC = [[GGAboutUsViewController alloc] init];
                                       //                                       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:leftFirstVC];
                                       //                                       nav.navigationBar.hidden = YES;
                                       //                                       [[GGAppDelegate sharedAppDelegate].revealSideViewController popViewControllerWithNewCenterController:nav animated:YES];
                                   }},
                                 
                                 @{ZSLeftMenuImage: @"zoaks2.png",
                                   ZSLeftMenuTitle: @"資料來源",
                                   ZSLeftMenuBlock:^{
                                   }},
                                 
                                 @{ZSLeftMenuImage: @"zoaks3.png",
                                   ZSLeftMenuTitle: @"移除廣告",
                                   ZSLeftMenuBlock:^{
                                   }},
                                 
                                 @{ZSLeftMenuImage: @"zoaks4.png",
                                   ZSLeftMenuTitle: @"使用教學",
                                   ZSLeftMenuBlock:^{
                                       
                                   }}
                                 ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleAndActionsBlock count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPTableViewCell *cell = [CPTableViewCell cell];
    cell.iconImageView.image = [UIImage imageNamed:titleAndActionsBlock[indexPath.row][ZSLeftMenuImage]];
    cell.titleLabel.text = titleAndActionsBlock[indexPath.row][ZSLeftMenuTitle];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    void (^block)(void) = titleAndActionsBlock[indexPath.row][ZSLeftMenuBlock];
    block();
}

@end
