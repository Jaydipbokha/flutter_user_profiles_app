import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/user/view/user_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserListView(),
    );
  }
}
