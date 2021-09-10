/**
 * ti.colorpicker
 *
 * Created by Hans Knöchel
 * Copyright (c) 2016-present Hans Knöchel. All rights reserved.
 */

#import "TiViewProxy.h"

@interface TiColorpickerColorPickerViewProxy : TiViewProxy {

}

- (void)setBrightness:(id)value;

- (void)setOpacity:(id)value;

- (void)setCropToCircle:(id)value;

- (void)setShowLoupe:(id)value;

- (void)setSelectionColor:(id)value;

@end
