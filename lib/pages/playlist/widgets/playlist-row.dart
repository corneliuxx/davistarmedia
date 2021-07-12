import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davistar_media/pages/playlist/models/playlist.dart';
import '../screens/videos.dart';

class PlaylistRow extends StatelessWidget {
  final Playlist playlist;

  const PlaylistRow({
    Key key,
    this.playlist
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Videos(playlist: playlist,);
          }),
        );
      },
      child: Row(
        children: [
        Image(
        width: 190.0,
        image: NetworkImage(playlist.image),
        ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:0.0),
                child: Text(
                  playlist.title,
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
              Text(playlist.description),
              SizedBox(
                height: 42,
              ),
              Row(
                children: [
                  Text('Davistar Mata Media' , style: TextStyle(fontSize: 14.0),),
                   Icon(Icons.check_circle, color: Colors.black , size: 14),

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}