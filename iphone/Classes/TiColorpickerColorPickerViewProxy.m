/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2016 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiColorpickerColorPickerViewProxy.h"
#import "TiColorpickerColorPickerView.h"
#import "TiUtils.h"

@implementation TiColorpickerColorPickerViewProxy

- (TiColorpickerColorPickerView*)colorPickerView
{
    return (TiColorpickerColorPickerView*)self.view;
}

#pragma mark Public APIs

-(void)setBrightness:(id)value
{
    ENSURE_TYPE(value, NSNumber);
    [[[self colorPickerView] colorPicker] setBrightness:[TiUtils floatValue:value]];
}

-(void)setOpacity:(id)value
{
    ENSURE_TYPE(value, NSNumber);
    [[[self colorPickerView] colorPicker] setOpacity:[TiUtils floatValue:value]];
}

-(void)setCropToCircle:(id)value
{
    ENSURE_TYPE(value, NSNumber);
    [[[self colorPickerView] colorPicker] setCropToCircle:[TiUtils boolValue:value def:NO]];
}

-(void)setShowLoupe:(id)value
{
    ENSURE_TYPE(value, NSNumber);
    [[[self colorPickerView] colorPicker] setShowLoupe:[TiUtils boolValue:value def:YES]];
}


-(void)setSelectionColor:(id)value
{
    ENSURE_TYPE(value, NSString);
    [[[self colorPickerView] colorPicker] setSelectionColor:[
                                                             self colorWithHexString:value
     ]];
    
}


#pragma mark Helper

USE_VIEW_FOR_CONTENT_WIDTH

USE_VIEW_FOR_CONTENT_HEIGHT

-(TiDimension)defaultAutoWidthBehavior:(id)unused
{
    return TiDimensionAutoFill;
}

-(TiDimension)defaultAutoHeightBehavior:(id)unused
{
    return TiDimensionAutoFill;
}
     

#pragma mark Utilities
     
 // CREDITS: http://stackoverflow.com/a/26341062/5537752
 - (UIColor *) colorWithHexString: (NSString *)hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    
    NSLog(@"colorString :%@",colorString);
    CGFloat alpha, red, blue, green;
    
    // #RGB
    alpha = 1.0f;
    red   = [self colorComponentFrom: colorString start: 0 length: 2];
    green = [self colorComponentFrom: colorString start: 2 length: 2];
    blue  = [self colorComponentFrom: colorString start: 4 length: 2];
    
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}


@end
