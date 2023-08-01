import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/frontend/Main_screen.dart';
import '../provider/user_provider.dart';

class ResponsiveLayout extends StatefulWidget {
  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return const MainScreen();
    });
  }
}
