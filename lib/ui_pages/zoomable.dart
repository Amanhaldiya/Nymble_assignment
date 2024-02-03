import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableImagePage extends StatelessWidget {
  final String imageUrl;

  ZoomableImagePage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoomable Image'),
        centerTitle: true,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }
}
