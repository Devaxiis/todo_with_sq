import 'package:flutter/material.dart';
import 'package:sqlflite/app.dart';
import 'package:sqlflite/di/injectable.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocator();
  runApp(const MyApp());
}
