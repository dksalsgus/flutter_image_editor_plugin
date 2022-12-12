import 'package:flutter/material.dart';
import 'package:flutter_image_editor_plugin/draw_line.dart';

class ImageEditPainter extends CustomPainter {
  final List<DrawLine> drawLines;

  ImageEditPainter({
    required this.drawLines,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final pathList = List.generate(drawLines.length, (index) => new Path());
    for (var index = 0; index < drawLines.length; index++) {
      final drawLine = drawLines[index];
      final path = pathList[index];
      final paint = drawLine.paint;
      for (var index2 = 0; index2 < drawLine.drawPoint!.length; index2++) {
        final point = drawLine.drawPoint![index2];
        if (point.dy < 0 || point.dx < 0 || (point.dx > size.width) || point.dy > size.height) continue;
        if (index2 == 0) {
          path.moveTo(point.dx, point.dy);
        }
        path.lineTo(point.dx, point.dy);
      }
      canvas.drawPath(path, paint!);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
