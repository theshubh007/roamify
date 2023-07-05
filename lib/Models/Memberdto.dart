class Memberdto {
  String Uid;
  String name;
  String email;
  String contactNumber;
  String city;
  String country;
  String pincode;
  

  Memberdto(
      {required this.Uid,
      required this.name,
      required this.email,
      required this.contactNumber,
      required this.city,
      required this.country,
      required this.pincode});

  factory Memberdto.fromJson(Map<String, dynamic> json) {
    return Memberdto(
      Uid: json['uid'].toString(),
      name: json['name'],
      email: json['email'],
      contactNumber: json['contactNumber'],
      city: json['city'],
      country: json['country'],
      pincode: json['pincode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': Uid,
      'name': name,
      'email': email,
      'contactNumber': contactNumber,
      'city': city,
      'country': country,
      'pincode': pincode,
    };
  }
}
