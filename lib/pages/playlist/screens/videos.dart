import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:davistar_media/pages/playlist/models/playlist.dart';
import 'package:davistar_media/pages/playlist/models/video.dart';
import 'package:davistar_media/pages/playlist/widgets/youtube-video-row.dart';

class Videos extends StatefulWidget {
  final Playlist playlist;

  Videos({
    Key key,
    this.playlist,
  }):super(key: key);

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  List<Video> videos = [];

  @override
  void initState() {
    super.initState();

    fetchVideos();
  }

  Future<void> fetchVideos() async {
    String url = 'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&key=AIzaSyDMDTgusq_8e3gaFwv6Lzy1_-mT5Y0tbxQ&maxResults=50&playlistId=${widget.playlist.id}';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        videos = jsonResponse['items'].map<Video>((item) {
          return Video.fromJson(item);
        }).toList();
      });
    } else {
      print('I should handle this error better: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlist.title),
      ),
      body: SafeArea(
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 50);
            },
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return YouTubeVideoRow(video: videos[index]);
            }
        ),
      ),
    );
  }
}