import 'package:flutter/material.dart';
import 'package:roamify/Utils/Color_const.dart';

class UserTypeTile extends StatelessWidget {
  const UserTypeTile({
    Key? key,
    required this.data,
    required this.isSelected,
    required this.width,
    required this.height,
    required this.radius,
  }) : super(key: key);
  final String data;

  final bool isSelected;
  final double? width;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : ColorConstant.grayblack,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(radius),
        color: isSelected
            ? //blue color with light opacity
            Colors.blue.withOpacity(0.3)
            : ColorConstant.blueGray300,
      ),
      padding: const EdgeInsets.all(14),
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            data,
            maxLines: 1,
            style: TextStyle(
              fontSize: 20,
              color: ColorConstant.whiteA700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
