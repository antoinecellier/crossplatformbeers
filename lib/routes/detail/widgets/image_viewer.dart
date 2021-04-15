import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final int beerId;
  final String imageURL;

  ImageViewer({@required this.beerId, @required this.imageURL})
      : assert(beerId != null),
        assert(imageURL != null);
  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer>
    with SingleTickerProviderStateMixin {
  double aspectRatio = 1;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: aspectRatio, end: aspectRatio),
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double size, Widget child) {
          return AspectRatio(
            aspectRatio: size,
            child: InkWell(
                child: Image.network(widget.imageURL),
                onTap: () {
                  setState(() {
                    aspectRatio == 1 ? aspectRatio = 0.52 : aspectRatio = 1;
                  });
                }),
          );
        },
      ),
    );
  }
}
