/**
 * ti.colorpicker
 *
 * Created by Hans Knöchel
 * Copyright (c) 2016-present Hans Knöchel. All rights reserved.
 */

#import "TiUIView.h"
#import "RSColorPickerView.h"

@interface TiColorpickerColorPickerView : TiUIView<RSColorPickerViewDelegate> {
    TiDimension width;
    TiDimension height;
    CGFloat autoHeight;
    CGFloat autoWidth;
}

@property(nonatomic, retain) RSColorPickerView *colorPicker;

- (RSColorPickerView*)colorPicker;

@end
