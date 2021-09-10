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
  _onHideCallback = [args[@"onHide"] retain];

  _picker = [[UIColorPickerViewController new] retain];
  _picker.selectedColor = selectedColor;
  _picker.delegate = self;
  _picker.supportsAlpha = NO;

  [[TiApp app] showModalController:_picker animated:YES];
}

- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController
{
  _picker.delegate = nil;
  RELEASE_TO_NIL(_onSelectCallback);
  RELEASE_TO_NIL(_picker);

  if (_onHideCallback != nil) {
    [_onHideCallback call:@[@{}] thisObject:self];
    RELEASE_TO_NIL(_onHideCallback);
  }
}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController
{
  if (_onSelectCallback != nil) {
    [_onSelectCallback call:@[@{ @"color": [TiUtils hexColorValue:viewController.selectedColor] }] thisObject:self];
  }
}

@end
