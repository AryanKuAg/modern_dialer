import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: const EdgeInsets.all(20),
            child: Image.asset('assets/ayush.png')),
        Text(
          '❤ Made By AYUSH AGARWAL ❤',
          style: TextStyle(
              fontSize: textScaleFactor * 20, fontWeight: FontWeight.bold),
        )
      ],
    ));
  }
}
