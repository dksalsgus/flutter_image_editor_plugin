import 'dart:ui';

class DrawLine {
  DrawLine({this.path, this.drawPoint, this.paint});
  @override
  Path? path;
  @override
  List<Offset>? drawPoint;
  Paint? paint;
}
