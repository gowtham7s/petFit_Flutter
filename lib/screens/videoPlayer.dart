import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key, required this.videoPath}) : super(key: key);
  final String videoPath;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {

  late VideoPlayerController _controller;
  late Future<void> _video;
  ChewieController? _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset('assets/Ayyappan.mp4'); //
    // .network('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'); //file(File(widget.videoPath));
    _video = _controller.initialize().then((value) => {
      _chewieController = ChewieController(videoPlayerController: _controller),
      setState(() {
        _controller.play();
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _video,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: _chewieVideoPlayer(),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // if (_controller.value.isPlaying) {
          //   setState(() {
          //     _controller.pause();
          //   });
          // } else {
          //   setState(() {
          //     _controller.play();
          //   });
          // }
          Navigator.pop(context);
        },
         child: const Text('Go Back', textAlign: TextAlign.center,),
        // Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  Widget _chewieVideoPlayer() {
    return _chewieController != null ?
        Chewie(controller: _chewieController!,): const Text('Loading');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController?.dispose();
  }
}
