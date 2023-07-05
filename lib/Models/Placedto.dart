class Placedto {
  String? place_name;
  String? place_video;
  String? place_image;

  Placedto({ this.place_name, this.place_video,
      this.place_image});

      factory Placedto.fromJson(Map<String, dynamic> json) {
    return Placedto(
      place_name: json['cityName'],
      place_video: json['videoLink'],
      place_image: json['place_images'],
    );
  }

      Map<String, dynamic> toJson() {
    return {
      'cityName': place_name,
      'videoLink': place_video,
      'place_images': place_image,
    };
  }
}
