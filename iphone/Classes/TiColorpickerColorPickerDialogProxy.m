//
//  TiColorpickerColorPickerDialogProxy.m
//  ti.colorpicker
//
//  Created by Hans Knöchel on 10.09.21.
//

#import "TiColorpickerColorPickerDialogProxy.h"

API_AVAILABLE(ios(14))
@implementation TiColorpickerColorPickerDialogProxy

- (void)show:(id)args
{
  ENSURE_SINGLE_ARG(args, NSDictionary);
  
  UIColor *selectedColor = [TiUtils colorValue:args[@"selectionColor"]].color;

  RELEASE_TO_NIL(_onSelectCallback);
  _onSelectCallback = [args[@"onSelect"] retain];

  UIColorPickerViewController *picker = [UIColorPickerViewController new];
  picker.selectedColor = selectedColor;
  picker.delegate = self;

  [[TiApp app] showModalController:picker animated:YES];
}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController
{
  if (_onSelectCallback != nil) {
    [_onSelectCallback call:@[@{ @"color": [TiUtils hexColorValue:viewController.selectedColor] }] thisObject:self];
    RELEASE_TO_NIL(_onSelectCallback);
  }
}

@end
