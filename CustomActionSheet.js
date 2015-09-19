'use strict';

var React = require('react-native');
var NativeModules = React.NativeModules;

var PressEffect = {
  'Fades': NativeModules.CustomActionSheet.FadeOnPress,
  'ReversesColors': NativeModules.CustomActionSheet.ReversesColorsOnPress,
  'Shrinks': NativeModules.CustomActionSheet.ShrinksOnPress,
  'Highlight': NativeModules.CustomActionSheet.HighlightOnPress,
}

class CustomActionSheet {
  constructor() {

  }

  showActionSheetWithOptions(options, callback) {
    options = Object.assign({node: 1}, options);
    NativeModules.CustomActionSheet.showActionSheetWithOptions(options, callback);
  }
}

var actionSheet = new CustomActionSheet;
actionSheet.PressEffect = PressEffect;

module.exports = actionSheet;
