# Ti.ColorPicker

Support color pickers in Titanium Mobile. This module bridges [RSColorPicker](https://github.com/RSully/RSColorPicker), thank you @RSully!

## Usage

```js
var win = Ti.UI.createWindow();
var ColorPicker = require("ti.colorpicker");

var picker = ColorPicker.createColorPickerView({
    width: 300,
    height: 300,
    top: 30,
// -- Colorpicker-specific properties
//  opacity: 1.0,
//  brightness: 1.0,
//  cropToCircle: false,
//  showLoupe: true
});

picker.addEventListener("selection", function(e) {
    Ti.API.warn(e.color);
    result.setBackgroundColor(e.color);
});

var result = Ti.UI.createView({
    bottom: 20,
    height: 50,
    width: 300,
    backgroundColor: "lightgray"
});

win.add(result);
win.add(picker);
win.open();
```