import 'dart:ffi';

class Tourdto {
  int tId;
  String tourName;
  String location;
  String description;
  int days;
  double chargePerPerson;
  int maxPerson;
  bool approved;
  int minPerson;
  DateTime createdDateTime;
  DateTime dueDateTime;
  String tourProfileImage;
  DateTime tourstartdate;

  Tourdto({
    required this.tId,
    required this.tourName,
    required this.location,
    required this.description,
    required this.days,
    required this.chargePerPerson,
    required this.maxPerson,
    required this.approved,
    required this.minPerson,
    required this.createdDateTime,
    required this.dueDateTime,
    required this.tourProfileImage,
    required this.tourstartdate,
  });

  //write factory from json
  factory Tourdto.fromJson(Map<String, dynamic> json) {
    return Tourdto(
      tId: json['tId'] as int,
      tourName: json['tourName'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      days: json['days'] as int,
      chargePerPerson: json['chargePerPerson'] as double,
      maxPerson: json['maxPerson'] as int,
      approved: json['approved'] as bool,
      minPerson: json['minPerson'] as int,
      createdDateTime: DateTime.parse(json['createdDateTime'] as String),
      dueDateTime: DateTime.parse(json['dueDateTime'] as String),
      tourProfileImage: json['tourProfileImage'] as String,
      tourstartdate: DateTime.parse(json['tourstartdate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tId': tId,
      'tourName': tourName,
      'location': location,
      'description': description,
      'days': days,
      'chargePerPerson': chargePerPerson,
      'maxPerson': maxPerson,
      'approved': approved,
      'minPerson': minPerson,
      'createdDateTime': createdDateTime.toIso8601String(),
      'dueDateTime': dueDateTime.toIso8601String(),
      'tourProfileImage': tourProfileImage,
      'tourstartdate': tourstartdate.toIso8601String(),
    };
  }
}
