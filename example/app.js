var win = Ti.UI.createWindow();
var ColorPicker = require("ti.colorpicker");
var picker = ColorPicker.createColorPickerView({
    width: 300,
    height: 300,
    top: 30
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