import TiColorPicker from 'ti.colorpicker';

const window = Ti.UI.createWindow();

const picker = TiColorPicker.createColorPickerView({
    width: 300,
    height: 300,
    top: 30,
// -- Colorpicker-specific properties
//  opacity: 1.0,
//  brightness: 1.0,
//  cropToCircle: false,
//  showLoupe: true
});

picker.addEventListener('selection', ({ color }) => {
    Ti.API.warn(color);
    result.backgroundColor = color;
});

const result = Ti.UI.createView({
    bottom: 20,
    height: 50,
    width: 300,
    backgroundColor: 'lightgray'
});

window.add(result);
window.add(picker);
window.open();

// iOS 14+ example:
// const picker = TiColorPicker.createColorPickerDialog();
// picker.show({
//     selectionColor: color,
//     onSelect: ({ color }) => {
//         picker.hide();
//     }
// });
