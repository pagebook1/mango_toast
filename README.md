
# MangoToast

MangoToast is a custom Flutter widget that displays a toast message on the screen. It supports different types of messages like success, error, and warning. Each type of message is displayed with a different color.

## Usage

To display a warning message, you can use the `MangoToast.warning` method. This method takes a string message and an optional position parameter. The position parameter determines the alignment of the toast on the screen. It can be `toastPosition.left`, `toastPosition.right`, or `toastPosition.center`.

Here's an example of how to use it:

```dart
MangoToast.warning('Warning message', position: toastPosition.left).show(context);
