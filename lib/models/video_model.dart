class Video {

  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String viewCount;

  Video({
    this.id,
    this.channelTitle,
    this.thumbnailUrl,
    this.title,
    this.viewCount,
  });

  factory Video.fromMap(Map<String,dynamic> snippet){
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['medium']['url'],
      channelTitle: snippet['channelTitle'],
      viewCount: snippet['views']
    );
  }
}