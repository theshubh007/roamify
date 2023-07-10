import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../Color_const.dart';

class TourRowCardTileAdmin extends StatelessWidget {
  String tourname;
  String location;
  int days;
  String? tourimage;
  String price;
  TourRowCardTileAdmin(
      {super.key,
      required this.tourname,
      required this.location,
      required this.days,
      this.tourimage,
      required this.price});

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;

    Uint8List? imageBytes;
    ImageProvider? imageProvider;
    if (tourimage != null) {
      imageBytes = base64Decode(tourimage!);
      imageProvider = MemoryImage(imageBytes);
    }

    return Container(
      height: ht * 0.12,
      // color: ColorConstant.gray600,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 18,
            offset: const Offset(0, 18), // changes position of shadow
          ),
        ],
        color: ColorConstant.whiteA700,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10)),
      ),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 0,
                  blurRadius: 18,
                  offset: const Offset(0, 18), // changes position of shadow
                ),
              ],
              image: (tourimage != null && tourimage!.isNotEmpty)
                  ? DecorationImage(
                      image: imageProvider!,
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage("assets/images/tourdemo.jpg"),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tourname,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Expanded(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.greenteal,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$days days',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.greenteal,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$price Rs',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: ColorConstant.greenteal,
                  ),
                  Text(location,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ],
              ))
            ],
          ))
        ],
      ),
    );
  }
}
