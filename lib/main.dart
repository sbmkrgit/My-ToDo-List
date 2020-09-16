import 'package:flutter/material.dart';

import 'homepage.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigoAccent,
          accentColor: Colors.indigoAccent),
      home: HomePage(),
    ));

