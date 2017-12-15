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
    [[[self colorPickerView] colorPicker] setSelectionColor:[[TiUtils colorValue:value] _color]];
}


#pragma mark Helper

USE_VIEW_FOR_CONTENT_WIDTH

USE_VIEW_FOR_CONTENT_HEIGHT

- (TiDimension)defaultAutoWidthBehavior:(id)unused
{
    return TiDimensionAutoFill;
}

- (TiDimension)defaultAutoHeightBehavior:(id)unused
{
    return TiDimensionAutoFill;
}

@end
