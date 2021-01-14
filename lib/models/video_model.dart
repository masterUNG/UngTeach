import 'dart:convert';

class VideoModel {
  final String cover;
  final String name;
  final String video;
  VideoModel({
    this.cover,
    this.name,
    this.video,
  });

  VideoModel copyWith({
    String cover,
    String name,
    String video,
  }) {
    return VideoModel(
      cover: cover ?? this.cover,
      name: name ?? this.name,
      video: video ?? this.video,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cover': cover,
      'name': name,
      'video': video,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return VideoModel(
      cover: map['cover'],
      name: map['name'],
      video: map['video'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) => VideoModel.fromMap(json.decode(source));

  @override
  String toString() => 'VideoModel(cover: $cover, name: $name, video: $video)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is VideoModel &&
      o.cover == cover &&
      o.name == name &&
      o.video == video;
  }

  @override
  int get hashCode => cover.hashCode ^ name.hashCode ^ video.hashCode;
}
