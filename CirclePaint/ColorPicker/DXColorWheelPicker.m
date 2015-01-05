//
//  DXColorWheelPicker.m
//  DXLight
//
//  Created by LEE CHIEN-MING on 10/4/12.
//  Copyright (c) 2012 LEE CHIEN-MING. All rights reserved.
//

#import "DXColorWheelPicker.h"

@implementation DXColorWheelPicker
#pragma mark - Private Methods
-(void)setupComponents
{
    self.backgroundColor = [UIColor clearColor];
    
    _colorWheel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colorwheel"]];
    _colorWheel.userInteractionEnabled = NO;
}

- (DXPickyColor)getRGBAFromImage:(UIImage *)image atX:(int)xx andY:(int)yy
{
    DXPickyColor pickedColor = {1.0, 1.0, 1.0};
//    DXPickyColor pickedColor = {1.0, 1.0, 1.0, 1.0};

    CGImageRef imageRef = [image CGImage];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    
    int width = CGImageGetWidth(imageRef) / screenScale;
    int height = CGImageGetHeight(imageRef) / screenScale;
    
    //從image的data buffer中取得影像，放入格式化後的rawData中
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    //將XY座標轉成一維陣列
    unsigned long byteIndex = (bytesPerRow * yy) + (bytesPerPixel * xx);
    
    //取得RGBA位元的資料並轉成0~1的格式
    pickedColor.red   = (float)(rawData[byteIndex]) / 255;
    pickedColor.green = (float)rawData[byteIndex + 1] / 255;
    pickedColor.blue  = (float)rawData[byteIndex + 2] / 255;
    
    free(rawData);
    
    return pickedColor;
}

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupComponents];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupComponents];
    }
    
    return self;
}

#pragma mark - UIKit Methods
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [_colorWheel setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    [self addSubview:_colorWheel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _colorWheel.frame = self.bounds;
    [_colorWheel setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
}

#pragma mark - Touches Interactions
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint aPt = [touch locationInView:self];
    aPt = [self convertPoint:aPt toView:self.colorWheel];
    
    double xLength = pow(aPt.x - self.colorWheel.frame.size.width/2, 2);
    double yLength = pow(aPt.y - self.colorWheel.frame.size.height/2, 2);
    
    CGFloat length = sqrt(xLength + yLength);
    if (length < self.colorWheel.frame.size.width/2) {
       DXPickyColor aColor = [self getRGBAFromImage:_colorWheel.image atX:aPt.x andY:aPt.y];
        //輸出至colorView上
        [self.delegate colorWheelPicker:self selectingColor:[UIColor colorWithRed:aColor.red green:aColor.green blue:aColor.blue alpha:1.0]];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint aPt = [touch locationInView:self];
    aPt = [self convertPoint:aPt toView:self.colorWheel];
    
    double xLength = pow(aPt.x - self.colorWheel.frame.size.width/2, 2);
    double yLength = pow(aPt.y - self.colorWheel.frame.size.height/2, 2);
    
    CGFloat length = sqrt(xLength + yLength);
    if (length < self.colorWheel.frame.size.width/2) {
        DXPickyColor aColor = [self getRGBAFromImage:_colorWheel.image atX:aPt.x andY:aPt.y];
        //輸出至colorView上
        [self.delegate colorWheelPicker:self selectingColor:[UIColor colorWithRed:aColor.red green:aColor.green blue:aColor.blue alpha:1.0]];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint aPt = [touch locationInView:self];
    aPt = [self convertPoint:aPt toView:self.colorWheel];
    
    double xLength = pow(aPt.x - self.colorWheel.frame.size.width/2, 2);
    double yLength = pow(aPt.y - self.colorWheel.frame.size.height/2, 2);
    
    CGFloat length = sqrt(xLength + yLength);
    if (length < self.colorWheel.frame.size.width/2) {
        DXPickyColor aColor = [self getRGBAFromImage:_colorWheel.image atX:aPt.x andY:aPt.y];
        [self.delegate colorWheelPicker:self didSelectColor:[UIColor colorWithRed:aColor.red green:aColor.green blue:aColor.blue alpha:1.0]];
    }
}
@end
