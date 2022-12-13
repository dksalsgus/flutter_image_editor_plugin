import 'package:flutter/material.dart';
import 'package:flutter_image_editor_plugin/flutter_image_editor_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Draw object
  final List<DrawLine> drawLines = [];

  /// Draw boundary
  final boundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _getAppbar(),
        body: _getBody(),
      ),
    );
  }

  PreferredSizeWidget _getAppbar() {
    return AppBar(
      title: const Text('Flutter Image Editor Plugin example app'),
    );
  }

  Widget _getBody() {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: RepaintBoundary(
        key: boundaryKey,
        child: CustomPaint(
          foregroundPainter: ImageEditPainter(drawLines: drawLines), // Here
          child: Image.asset('test/path'), // Image to Draw
        ),
      ),
    );
  }

  /// Start Draw
  void onPanStart(DragStartDetails details) {
    final box = boundaryKey.currentContext!.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    // You can custom paint line
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 10; // ..etc
    setState(() {
      drawLines.add(DrawLine(path: Path(), drawPoint: List.generate(1, (index) => point), paint: paint));
    });
  }

  /// Drawing
  void onPanUpdate(DragUpdateDetails details) {
    final box = boundaryKey.currentContext!.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    setState(() {
      drawLines.last.drawPoint!.add(point);
    });
  }

  /// Draw End
  void onPanEnd(DragEndDetails details) {
    setState(() {});
  }
}
