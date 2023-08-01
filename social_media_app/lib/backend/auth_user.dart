import 'dart:typed_data';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:social_media_app/api/apis.dart';
// import 'package:flutter/material.dart';
import 'package:social_media_app/backend/storage_methoda.dart';
import '../model/user_model.dart' as model;

class FirebaseAuthFunction {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.UserData> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    print("gjhktvfrbuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuhbvjfdetr");
    // print(model.UserData.fromSnap(documentSnapshot).);
    // var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    // print(snapshot["bio"]);

    return model.UserData.fromSnap(documentSnapshot);
  }

  Future<String> signUpUser({
    required String email,
    required String phonenumber,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.UserData user = model.UserData(
          username: username,
          uid: cred.user!.uid,
          phoneNumber: phonenumber,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        final time = DateTime.now().millisecondsSinceEpoch.toString();

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        // Chatmodel.ChatUser __user = Chatmodel.ChatUser(image: photoUrl, about: bio, name: username, createdAt: createdAt, isOnline: isOnline, id: id, lastActive: lastActive, email: email, pushToken: pushToken)

        // adding user in our database

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
