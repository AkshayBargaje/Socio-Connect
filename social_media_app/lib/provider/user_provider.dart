import 'package:flutter/widgets.dart';
import 'package:social_media_app/model/user_model.dart';

import '../backend/auth_user.dart';

class UserProvider with ChangeNotifier {
  UserData? _user;

  final FirebaseAuthFunction _authMethods = FirebaseAuthFunction();

  UserData get getUser => _user!;
  // ChatUser _user = FirebaseAuthFunction().getchatUserDetails();

  Future<void> refreshUser() async {
    UserData user = await _authMethods.getUserDetails();
    _user = user;
    // print(user.bio);

    notifyListeners();
  }
}
