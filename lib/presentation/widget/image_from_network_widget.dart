import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ImageFromNetwork extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const ImageFromNetwork(
      {Key? key,
      required this.imageUrl,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageProvider>(
      future: _getImageProvider(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Image(
          image: snapshot.data!,
          fit: BoxFit.cover,
          width: width,
          height: height,
        );
      },
    );
  }

  Future<ImageProvider> _getImageProvider(String url) async {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MemoryImage(response.bodyBytes);
    } else {
      throw Exception('Failed to load image from network');
    }
  }
}
