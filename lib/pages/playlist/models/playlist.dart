class Playlist {
  final String id;
  final String title;
  final String image;
  final String description;

  Playlist({
    this.id,
    this.title,
    this.image,
    this.description,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
    id: json['id'],
    title: json['snippet']['title'],
    image: json['snippet']['thumbnails']['medium']['url'],
    description: json['snippet']['description'],
  );
}