import 'package:flutter/material.dart';

enum ContentLineType { oneLine, twoLines, threeLines }

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({super.key, required this.lineType});

  int get lineCount {
    switch (lineType) {
      case ContentLineType.oneLine:
        return 1;
      case ContentLineType.twoLines:
        return 2;
      case ContentLineType.threeLines:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(lineCount, (index) {
          return Container(
            height: 14,
            margin: const EdgeInsets.only(bottom: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          );
        }),
      ),
    );
  }
}
