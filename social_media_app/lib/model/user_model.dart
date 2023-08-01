import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  // final String password;
  // final String username;
  // final String email;
  // final String phoneNumber;

  // UserData({
  //   required this.password,
  //   required this.username,
  //   required this.email,
  //   required this.phoneNumber,
  // });

  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final String phoneNumber;

  const UserData(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.phoneNumber,
      required this.followers,
      required this.following});

  static UserData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserData(
      username: snapshot["username"],
      uid: snapshot["uid"],
      phoneNumber: snapshot["Phone Number"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "Phone Number": phoneNumber,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
