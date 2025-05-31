import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsi_prak_mob/models/BookmarkModel.dart';
import 'package:responsi_prak_mob/services/BookmarkService.dart';
import 'package:responsi_prak_mob/views/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // inisialisasi Hive di Flutter
  Hive.registerAdapter(BookmarkPhoneAdapter()); // daftar adapter

  await BookmarkService.openBox();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()
    );
  }
}
