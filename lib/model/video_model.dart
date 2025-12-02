class VideoModel {
    List<Video> videos;

    VideoModel({
        required this.videos,
    });

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    };
}

class Video {
    String description;
    List<String> sources;
    String subtitle;
    String thumb;
    String title;

    Video({
        required this.description,
        required this.sources,
        required this.subtitle,
        required this.thumb,
        required this.title,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        description: json["description"] ?? '',
        sources: json["sources"] != null ? List<String>.from(json["sources"].map((x) => x)) : [],
        subtitle: json["subtitle"] ?? '',
        thumb: json["thumb"] ?? '',
        title: json["title"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "sources": List<dynamic>.from(sources.map((x) => x)),
        "subtitle": subtitle,
        "thumb": thumb,
        "title": title,
    };
}
