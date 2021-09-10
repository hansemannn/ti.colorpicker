//
//  TiColorpickerColorPickerDialogProxy.h
//  ti.colorpicker
//
//  Created by Hans Knöchel on 10.09.21.
//

#import <TitaniumKit/TitaniumKit.h>

API_AVAILABLE(ios(14))
@interface TiColorpickerColorPickerDialogProxy : TiProxy<UIColorPickerViewControllerDelegate> {
  KrollCallback *_onSelectCallback;
  KrollCallback *_onHideCallback;
  UIColorPickerViewController *_picker;
}

- (void)show:(id)args;

@end
