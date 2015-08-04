# react-native-custom-actsheet

flexible custom ActionSheet for react-native.

This modules is wrapper for [IBActionSheet](https://github.com/ianb821/IBActionSheet) , which does all real work.

## ScreenShot

![Standard](https://raw.github.com/guodong000/react-native-custom-actsheet/master/Pictures/standard.png)
![colored](https://raw.github.com/guodong000/react-native-custom-actsheet/master/Pictures/colored.png)

## Example

```
ActionSheet.showActionSheetWithOptions({
  node: React.findNodeHandle(this.refs['view']),  // default is RCTRootContentView's react tag
  title: 'This is a title',
  destructiveButtonTitle: 'Destructive',
  cancelButtonTitle: 'Cancel',
  buttonTextColor: 'yellow',
  buttonBackgroundColor: 'green',
  pressEffect: ActionSheet.PressEffect.Highlight,
  shouldCancelOnTouch: false,
  blurBackground: false,
  font: {
    fontFamily: 'Bradley Hand',
    fontSize: 14,
    fontWeight: 'normal' | 'bold' | '100' | '200' | '300' | '400' | '500' | '600' | '700' | '800' | '900',
    fontStyle: 'normal' | 'italic' | 'oblique',
  }
  buttons: [
    {title: 'button1', textColor: 'black'},
    {title: 'button2', backgroundColor: 'red'},
    {title: 'button3', highlightTextColor: 'red', highlightBackgroundColor: 'orange'},
  ]
});
```
