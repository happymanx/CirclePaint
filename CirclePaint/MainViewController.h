//
//  MainViewController.h
//  CirclePaint
//
//  Created by w91379137 on 2014/12/29.
//  Copyright (c) 2014年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXColorWheelPicker.h"
#import "NSObject+GCDBackgroundTimer.h"

@interface MainViewController : UIViewController
<DXColorWheelPickerDelegate>
{
   
    
    NSDate *startDate;
    NSTimer *aMovement;
    float theta;
    UIColor *buttonColor;
    
    IBOutlet UIView *basePaintView;
    IBOutlet UIView *drawPointView;
    IBOutlet UIView *drawPointView2;
    
    IBOutlet UIImageView *baseShowImageView;
    IBOutlet UISlider *speedSlider;
    IBOutlet UISlider *shockSlider;
    IBOutlet UILabel *shockValueLabel;
    
    IBOutlet UISwitch *paintSwitch;
    IBOutlet UISwitch *xShockSwitch;
    IBOutlet UISwitch *yShockSwitch;
}

//https://www.facebook.com/video.php?v=10152836162626083
@property (nonatomic) dispatch_source_t backgroundTimerSource;
@property (nonatomic, weak) IBOutlet DXColorWheelPicker *colorWheelPicker;
@end
