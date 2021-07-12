import 'package:flutter/material.dart';
import 'package:davistar_media/models/channel_model.dart';
import 'package:davistar_media/models/video_model.dart';
import 'package:davistar_media/screens/video_screen.dart';
import 'package:davistar_media/screens/video_screen2.dart';
import 'package:davistar_media/services/api_service.dart';
import 'package:davistar_media/uimodels/youtube_model.dart';
import 'package:davistar_media/uiscreens/video_detail.dart';
import 'package:davistar_media/helper/Constant.dart';

class YoutubeScreen extends StatefulWidget {
  @override
  _YoutubeScreenState createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UC6ay3S1iIp-Jz8gD4nNYe-A');
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

        decoration: BoxDecoration(
            color: Colors.white,

            ),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,

              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(video.thumbnailUrl),
                    fit: BoxFit.cover),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                //image: new DecorationImage(
                //image: AssetImage("images/appbar.jpg"), // change App bar background image
                // fit: BoxFit.cover,
                // ),
                // To use Gradient Instead uncheck this section and quote the above
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[primary, secondary],
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                dense: true,
                leading:CircleAvatar(
                  backgroundImage: NetworkImage(_channel.profilePictureUrl),
                ),

                title: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(video.title ,style: TextStyle(

                      color: videotextcolor
                  ), ),
                ),

                trailing: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Icon(Icons.more_vert)),
              ),
            ),



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
