//
//  MainViewController.m
//  CirclePaint
//
//  Created by w91379137 on 2014/12/29.
//  Copyright (c) 2014年 w91379137. All rights reserved.
//

#import "MainViewController.h"
#import "CPSideMenuViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //畫上背景
    [baseShowImageView.image drawAtPoint:CGPointMake(0, 0)];
    theta = 0.0;
    
    buttonColor = [UIColor whiteColor];
    startDate = [NSDate date];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    //畫布設定
    UIGraphicsBeginImageContextWithOptions(basePaintView.frame.size, NO, 2.0);

    UIImage *colorPickerImage = [UIImage imageNamed:@"colorwheel_buttonpanel"];
    self.colorWheelPicker.colorWheel.image = colorPickerImage;
    self.colorWheelPicker.delegate = self;
    self.colorWheelPicker.alpha = 1;
    self.colorWheelPicker.userInteractionEnabled = YES;
    
    if (!self.backgroundTimerSource) {
        dispatch_queue_t serialQueue = dispatch_queue_create("BackgroundTimerForTableViewReload", NULL);
        dispatch_source_t newTimer = CreateDispatchTimer( (1ull * NSEC_PER_SEC) * 0.005, (1ull * NSEC_PER_SEC), serialQueue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self imageRotate];
            });
        });
        self.backgroundTimerSource = newTimer;
    }
//    aMovement = [NSTimer scheduledTimerWithTimeInterval:0.001
//                                                 target:self
//                                               selector:@selector(imageRotate)
//                                               userInfo:nil
//                                                repeats:YES];
    
    UIPanGestureRecognizer *aPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPressToMoveAction:)];

    [drawPointView addGestureRecognizer:aPanGestureRecognizer];
}

-(void)imageRotate
{
    theta = theta + (M_PI / 90 * speedSlider.value) / 2;
    //theta = speedSlider.value;
    if (paintSwitch.on) {
        CGPoint touchPoint = drawPointView.center;
        
        float x = touchPoint.x - basePaintView.bounds.size.width / 2;
        float y = -(touchPoint.y - basePaintView.bounds.size.height / 2);
        
        if (xShockSwitch.on) {
            float shock = shockSlider.value;
            shock = shock * 2;
            int k = shock / 2;
            x = x + 15 * cos([startDate timeIntervalSinceNow] * k * M_PI * 2 * speedSlider.value);
        }
        
        if (yShockSwitch.on) {
            /*
            float shock = shockSlider.value;
            shock = shock * [startDate timeIntervalSinceNow] / M_PI * 2 * speedSlider.value / 10;
            int c = shock;
            y = y + 40 * (shock - c + 0.5);
             */
            float shock = shockSlider.value;
            shock = shock * 4;
            int k = shock / 4;
            y = y + 25 * sin([startDate timeIntervalSinceNow] * k * M_PI * 2 * speedSlider.value);
            
        }
        
        drawPointView2.center = CGPointMake(x + basePaintView.bounds.size.width / 2,
                                            -y + basePaintView.bounds.size.height / 2);
        
        float new_x = cos(theta) * x - sin(theta) * y;
        float new_y = sin(theta) * x + cos(theta) * y;
        
        touchPoint = CGPointMake(new_x + basePaintView.bounds.size.width / 2,
                                 -new_y + basePaintView.bounds.size.height / 2);
        
        [self drawPoint:touchPoint];
        
    }
    drawPointView.backgroundColor = buttonColor;
    baseShowImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    baseShowImageView.layer.transform = CATransform3DMakeRotation(theta, 0, 0, 1);
}

-(void)panPressToMoveAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *targetView = [gestureRecognizer view];
    if ([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[targetView superview]];
        CGPoint newCenter = CGPointMake([targetView center].x + translation.x, [targetView center].y + translation.y);
        
        [targetView setCenter:newCenter];
        [gestureRecognizer setTranslation:CGPointZero inView:[targetView superview]];
    }
}

-(void)drawPoint:(CGPoint)point
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 0.1);
    CGContextSetStrokeColorWithColor(ctx, buttonColor.CGColor);
    CGContextSetFillColorWithColor(ctx, buttonColor.CGColor);
    
    // setup the size
    CGRect circleRect = CGRectMake(point.x - 2, point.y - 2, 4, 4);
    circleRect = CGRectInset(circleRect, 1, 1);
    
    // Fill
    CGContextFillEllipseInRect(ctx, circleRect);
    CGContextStrokeEllipseInRect(ctx, circleRect);
}

#pragma mark - ibaction
-(IBAction)shackValue:(UISlider *)sender
{
    shockValueLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
}

-(IBAction)clear:(UIButton *)sender
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect (ctx, basePaintView.bounds);
}

#pragma mark - DXColorWheelPickerDelegate
-(void)colorWheelPicker:(DXColorWheelPicker *)picker didSelectColor:(UIColor *)aColor
{
    buttonColor = aColor;
}

-(void)colorWheelPicker:(DXColorWheelPicker *)picker selectingColor:(UIColor *)aColor
{
    buttonColor = aColor;

}

-(IBAction)showSideMenuAction:(UIButton *)sender
{
    [self showLeftMenu:nil];
}

@end
