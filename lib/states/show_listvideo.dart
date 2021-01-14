import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungteach/models/video_model.dart';
import 'package:ungteach/states/player_video.dart';
import 'package:ungteach/utility/my_style.dart';

class ShowListVideo extends StatefulWidget {
  @override
  _ShowListVideoState createState() => _ShowListVideoState();
}

class _ShowListVideoState extends State<ShowListVideo> {
  List<VideoModel> videoModels = [];
  List<Widget> widgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllVideo();
  }

  Future<Null> readAllVideo() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('ungvideo')
          .snapshots()
          .listen((event) {
        int index = 0;
        for (var item in event.docs) {
          print('snapshot ==> ${item.data()}');
          VideoModel model = VideoModel.fromMap(item.data());
          videoModels.add(model);
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Widget createWidget(VideoModel videoModel, int index) => GestureDetector(
        onTap: () {
          print('You Click index = $index');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayerVideo(
                model: videoModels[index],
              ),
            ),
          );
        },
        child: Card(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                child: Image.network(videoModel.cover),
              ),
              Text(videoModel.name),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.length == 0 ? MyStyle().showProgress() : buildGridView(),
    );
  }

  GridView buildGridView() {
    return GridView.extent(
      maxCrossAxisExtent: 200,
      children: widgets,
    );
  }
}
