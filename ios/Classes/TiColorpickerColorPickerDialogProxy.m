//
//  TiColorpickerColorPickerDialogProxy.m
//  ti.colorpicker
//
//  Created by Hans Knöchel on 10.09.21.
//

#import "TiColorpickerColorPickerDialogProxy.h"

API_AVAILABLE(ios(14))
@implementation TiColorpickerColorPickerDialogProxy

- (void)_initWithProperties:(NSDictionary *)properties
{
  [super _initWithProperties:properties];

  _onSelectCallback = [properties[@"onSelect"] retain];
  _onHideCallback = [properties[@"onHide"] retain];
}

- (void)dealloc
{
  [super dealloc];

  RELEASE_TO_NIL(_onSelectCallback);
  RELEASE_TO_NIL(_onHideCallback);

  _picker.delegate = nil;
  RELEASE_TO_NIL(_picker);
}

- (void)show:(id)args
{
  ENSURE_SINGLE_ARG(args, NSDictionary);
  
  UIColor *selectedColor = [TiUtils colorValue:args[@"selectionColor"]].color;

  if (_picker == nil) {
    _picker = [[UIColorPickerViewController new] retain];
    _picker.delegate = self;
    _picker.supportsAlpha = NO;
  }

  _picker.selectedColor = selectedColor;

  [[TiApp app] showModalController:_picker animated:YES];
}

- (void)hide:(id)unused
{
  TiThreadPerformOnMainThread(^{
    [_picker dismissViewControllerAnimated:YES completion:nil];
  }, NO);
}

- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)viewController
{
  if (_onHideCallback != nil) {
    [_onHideCallback call:@[@{}] thisObject:self];
  }
}

- (void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)viewController
{
  if (_onSelectCallback != nil) {
    [_onSelectCallback call:@[@{ @"color": [TiUtils hexColorValue:viewController.selectedColor] }] thisObject:self];
  }
}

@end
