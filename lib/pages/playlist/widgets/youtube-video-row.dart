import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:davistar_media/pages/playlist/models/video.dart';




class YouTubeVideoRow extends StatefulWidget {
  final Video video;

  const YouTubeVideoRow({
    Key key,
    this.video
  }) : super(key: key);

  @override
  _YouTubeVideoRowState createState() => _YouTubeVideoRowState();
}

class _YouTubeVideoRowState extends State<YouTubeVideoRow> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
        ),
        builder: (context, player) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player,
              SizedBox(height: 3.0),
              ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                dense: true,
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/davistar.jpg"),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    widget.video.title,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),),
                ),
                subtitle: Row(
                  children: [
                    Row(

                      children: [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Davistar Mata Media' , style: TextStyle(fontSize: 14.0),),
                            Icon(Icons.check_circle, color: Colors.black , size: 14),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Text(
                        "2M views . New Video"),
                  ],
                ),
                trailing: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Icon(Icons.more_vert)),
              ),

              SizedBox(height: 10.0),


            ],
          );
        }
    );
  }
}