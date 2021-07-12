import 'package:flutter/material.dart';
import 'package:davistar_media/video_list.dart';
import 'package:davistar_media/uimodels/youtube_model.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VideoList(listData: youtubeData,);
  }
}
