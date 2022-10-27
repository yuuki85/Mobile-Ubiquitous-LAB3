// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateCourse extends StatefulWidget {
  const RateCourse({Key? key}) : super(key: key);
  @override
  RateCourseState createState() => RateCourseState();
}

class RateCourseState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Course'),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          height: 175,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child: Stack(
              children: [
                Positioned(
                    left: 20,
                    top: 20,
                    child: Text(
                      "MOBILE & \n"
                      "UBIQUITOUS COMPUTING",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
