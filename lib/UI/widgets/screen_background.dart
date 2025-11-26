import 'package:flutter/material.dart';
import 'package:task_management/UI/utils/assets_path.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.background,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child)
      ],
    );
  }
}
