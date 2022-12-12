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
  final drawLines = [];
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
          foregroundPainter: ImageEditPainter(
            drawLines: drawLines,
          ),
          child: Image.network(url),
        ),
      ),
    );
  }

  void onPanStart(DragStartDetails details) {
    final box = globalKey.currentContext!.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    setState(() {
      drawLines.add(DrawLine(path: Path(), drawPoint: List.generate(1, (index) => point), paint: paint));
    });
  }

  void onPanUpdate(DragUpdateDetails details) {
    final box = globalKey.currentContext!.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    setState(() {
      drawLines.last.drawPoint.add(point);
    });
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      // drawLines.add(DrawLine(Path(), []));
    });
  }
}
