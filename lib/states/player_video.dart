import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:ungteach/models/video_model.dart';
import 'package:video_player/video_player.dart';

class PlayerVideo extends StatefulWidget {
  final VideoModel model;
  PlayerVideo({Key key, this.model}) : super(key: key);
  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {
  VideoModel videoModel;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoModel = widget.model;

    videoPlayerController = VideoPlayerController.network(videoModel.video);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(videoModel.name),
      ),body: Chewie(controller: chewieController),
    );
  }
}
