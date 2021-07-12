import 'package:flutter/material.dart';
import 'package:davistar_media/models/channel_model.dart';
import 'package:davistar_media/models/video_model.dart';
import 'package:davistar_media/screens/video_screen.dart';
//import 'package:davistar_media/screens/video_screen2.dart';
import 'package:davistar_media/services/api_service.dart';
//import 'package:davistar_media/clone/screens/video_screen.dart';


class YoutubeScreen2 extends StatefulWidget {
  @override
  _YoutubeScreen2State createState() => _YoutubeScreen2State();
}

class _YoutubeScreen2State extends State<YoutubeScreen2> {
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCF2cSn7wWcjATHmQVMvK6Vw');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container();
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        padding: EdgeInsets.all(0.0),
        height: 120.0,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Theme.of(context).hintColor))
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 200.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _channel != null
          ? NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollDetails) {
          if (!_isLoading &&
              _channel.videos.length != int.parse(_channel.videoCount) &&
              scrollDetails.metrics.pixels ==
                  scrollDetails.metrics.maxScrollExtent) {
            _loadMoreVideos();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: 1 + _channel.videos.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _buildProfileInfo();
            }
            Video video = _channel.videos[index - 1];
            return _buildVideo(video);
          },
        ),
      )
          : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
