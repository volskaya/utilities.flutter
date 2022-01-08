import 'package:flutter/material.dart';
import 'package:sliver_transform/src/rendering/render_sliver_transform.dart';

class SliverTransform extends SingleChildRenderObjectWidget {
  const SliverTransform({
    Key? key,
    required this.transform,
    this.origin,
    this.alignment,
    Widget? sliver,
  })  : assert(transform != null),
        super(key: key, child: sliver);

  SliverTransform.rotate({
    Key? key,
    required double angle,
    this.origin,
    this.alignment = Alignment.center,
    Widget? sliver,
  })  : transform = Matrix4.rotationZ(angle),
        super(key: key, child: sliver);

  SliverTransform.translate({
    Key? key,
    required Offset offset,
    Widget? sliver,
  })  : transform = Matrix4.translationValues(offset.dx, offset.dy, 0.0),
        origin = null,
        alignment = null,
        super(key: key, child: sliver);

  SliverTransform.scale({
    Key? key,
    required double scale,
    this.origin,
    this.alignment = Alignment.center,
    Widget? sliver,
  })  : transform = Matrix4.diagonal3Values(scale, scale, 1.0),
        super(key: key, child: sliver);

  final Matrix4 transform;
  final Offset? origin;
  final AlignmentGeometry? alignment;

  @override
  RenderSliverTransform createRenderObject(BuildContext context) {
    return RenderSliverTransform(
      transform: transform,
      origin: origin,
      alignment: alignment,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverTransform renderObject) {
    renderObject
      ..transform = transform
      ..origin = origin
      ..alignment = alignment
      ..textDirection = Directionality.maybeOf(context);
  }
}
