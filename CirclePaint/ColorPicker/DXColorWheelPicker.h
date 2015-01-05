//
//  DXColorWheelPicker.h
//  DXLight
//
//  Created by LEE CHIEN-MING on 10/4/12.
//  Copyright (c) 2012 LEE CHIEN-MING. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct DXPickyColor {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
//    CGFloat alpha;   // John 20140715 : Unused property
} DXPickyColor;

@protocol DXColorWheelPickerDelegate;

@interface DXColorWheelPicker : UIView
@property (nonatomic, weak) id <DXColorWheelPickerDelegate> delegate;
@property (nonatomic, strong) UIImageView *colorWheel;
@end

@protocol DXColorWheelPickerDelegate <NSObject>
-(void)colorWheelPicker:(DXColorWheelPicker *)picker didSelectColor:(UIColor *)aColor;
-(void)colorWheelPicker:(DXColorWheelPicker *)picker selectingColor:(UIColor *)aColor;
@end
