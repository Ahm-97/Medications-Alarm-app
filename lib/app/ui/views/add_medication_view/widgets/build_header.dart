import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/common/constants/dimensions.dart';
import 'package:flutter_application_3/core/common/constants/font_sizes.dart';

Widget buildHeader() {
  return const Expanded(
    child: Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingMedium,
        top: Dimensions.marginSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi Ahmed',
            style: TextStyle(
              fontSize: FontSizes.extraLarge,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Dimensions.marginSmall),
          Text(
            "Lorem Ipsum is simply dummy text of the printing.",
            style: TextStyle(
              fontSize: FontSizes.medium,
              color: Color.fromARGB(255, 238, 238, 238),
            ),
          ),
        ],
      ),
    ),
  );
}
