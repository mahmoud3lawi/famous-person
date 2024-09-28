import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:traning_project/constant.dart';

class ImageScreen extends StatefulWidget {
  final String imageUrl;

  const ImageScreen({super.key, required this.imageUrl});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Future<void> downloadImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/${url.split('/').last}';
        await File(filePath).writeAsBytes(bytes);
        print('Image downloaded to: $filePath');
      } else {
        print('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image Details',
          style: TextStyle(
            fontFamily: 'Sofadi One',
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: KBackGroundColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.download,
              color: kPrimaryColor,
            ),
            onPressed: () {
              downloadImage(widget.imageUrl);
            },
          ),
        ],
      ),
      body: Center(
        child: InstaImageViewer(
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
