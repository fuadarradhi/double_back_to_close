# double_back_to_close

Flutter package for request double back pressed before close app/route/screen.

## Usage

Wrapping widget with DoubleBack where you want to use double back to close screen or app:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DoubleBack(
          message:"Press back again to close",
          child: Home(),
        ),
      ),
    );
  }
}
``` 