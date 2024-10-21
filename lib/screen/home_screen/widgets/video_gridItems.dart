// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoGridItem extends StatefulWidget {
//   final File videoFile;
//
//   const VideoGridItem({Key? key, required this.videoFile}) : super(key: key);
//
//   @override
//   _VideoGridItemState createState() => _VideoGridItemState();
// }
//
// class _VideoGridItemState extends State<VideoGridItem> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(widget.videoFile)
//       ..initialize().then((_) {
//         setState(() {}); // Update the UI when video is initialized
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? AspectRatio(
//       aspectRatio: _controller.value.aspectRatio,
//       child: VideoPlayer(_controller),
//     )
//         : const Center(child: CircularProgressIndicator());
//   }
// }
//
//
