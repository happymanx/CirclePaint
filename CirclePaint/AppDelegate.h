//
//  AppDelegate.h
//  CirclePaint
//
//  Created by w91379137 on 2014/12/29.
//  Copyright (c) 2014年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedAppDelegate;

@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;

@end

