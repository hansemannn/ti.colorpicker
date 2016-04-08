/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiColorpickerColorPickerView.h"
#import "TiColorpickerColorPickerViewProxy.h"

@implementation TiColorpickerColorPickerView


#ifdef TI_USE_AUTOLAYOUT
-(void)initializeTiLayoutView
{
    [super initializeTiLayoutView];
    [self setDefaultHeight:TiDimensionAutoSize];
    [self setDefaultWidth:TiDimensionAutoSize];
}
#endif

- (TiColorpickerColorPickerViewProxy*)colorPickerViewProxy
{
    return (TiColorpickerColorPickerViewProxy*)self.proxy;
}

-(RSColorPickerView*)colorPicker
{
    if (_colorPicker == nil) {
        _colorPicker = [[RSColorPickerView alloc] initWithFrame:[self bounds]];
        _colorPicker.delegate = self;
        
        [_colorPicker setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [_colorPicker setContentMode:[self contentModeForColorPickerView]];
        
        [self addSubview:_colorPicker];
    }
    
    return _colorPicker;
}

#pragma mark Cleanup

-(void)dealloc
{
    RELEASE_TO_NIL(_colorPicker);
    
    [super dealloc];
}

#pragma mark Public APIs

-(void)setWidth_:(id)width_
{
    width = TiDimensionFromObject(width_);
    [self updateContentMode];
}

-(void)setHeight_:(id)height_
{
    height = TiDimensionFromObject(height_);
    [self updateContentMode];
}

#pragma mark Layout helper

-(void)updateContentMode
{
    if (_colorPicker != nil) {
        [_colorPicker setContentMode:[self contentModeForColorPickerView]];
    }
}

-(UIViewContentMode)contentModeForColorPickerView
{
    if (TiDimensionIsAuto(width) || TiDimensionIsAutoSize(width) || TiDimensionIsUndefined(width) ||
        TiDimensionIsAuto(height) || TiDimensionIsAutoSize(height) || TiDimensionIsUndefined(height)) {
        return UIViewContentModeScaleAspectFit;
    }
    else {
        return UIViewContentModeScaleToFill;
    }
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    for (UIView *child in [self subviews])
    {
        [TiUtils setView:child positionRect:bounds];
    }
    
    [super frameSizeChanged:frame bounds:bounds];
}


-(CGFloat)contentWidthForWidth:(CGFloat)suggestedWidth
{
    if (autoWidth > 0)
    {
        //If height is DIP returned a scaled autowidth to maintain aspect ratio
        if (TiDimensionIsDip(height) && autoHeight > 0) {
            return roundf(autoWidth*height.value/autoHeight);
        }
        return autoWidth;
    }
    
    CGFloat calculatedWidth = TiDimensionCalculateValue(width, autoWidth);
    if (calculatedWidth > 0)
    {
        return calculatedWidth;
    }
    
    return 0;
}

-(CGFloat)contentHeightForWidth:(CGFloat)width_
{
    if (width_ != autoWidth && autoWidth>0 && autoHeight > 0) {
        return (width_*autoHeight/autoWidth);
    }
    
    if (autoHeight > 0)
    {
        return autoHeight;
    }
    
    CGFloat calculatedHeight = TiDimensionCalculateValue(height, autoHeight);
    if (calculatedHeight > 0) {
        return calculatedHeight;
    }
    
    return 0;
}

-(UIViewContentMode)contentMode
{
    if (TiDimensionIsAuto(width) || TiDimensionIsAutoSize(width) || TiDimensionIsUndefined(width) ||
        TiDimensionIsAuto(height) || TiDimensionIsAutoSize(height) || TiDimensionIsUndefined(height)) {
        return UIViewContentModeScaleAspectFit;
    } else {
        return UIViewContentModeScaleToFill;
    }
}

#pragma mark Delegates

-(void)colorPickerDidChangeSelection:(RSColorPickerView *)colorPicker
{
    [[self colorPickerViewProxy] fireEvent:@"selection" withObject:@{
        @"color": [self hexStringFromColor:[colorPicker selectionColor]]
    }];
}

#pragma mark Utilities

// CREDITS: http://stackoverflow.com/a/26341062/5537752
- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

@end
