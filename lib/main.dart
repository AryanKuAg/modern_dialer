import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_dialer/contactScreen.dart';
import 'package:modern_dialer/favoriteScreen.dart';
import 'package:modern_dialer/phoneScreen.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(NeumorphicApp(
      theme: NeumorphicThemeData(
        textTheme: GoogleFonts.bubblegumSansTextTheme(),
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      debugShowCheckedModeBanner: false,
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: NeumorphicAppBar(
          title: TabBar(
            physics: BouncingScrollPhysics(),
            indicatorColor: Colors.greenAccent,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                child: Text(
                  'Phone',
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
              Tab(
                child: Text(
                  'Contacts',
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
              Tab(
                child: Text(
                  'Favorites',
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [PhoneScreen(), ContactScreen(), FavoriteScreen()],
        ),
      ),
    );
  }
}
