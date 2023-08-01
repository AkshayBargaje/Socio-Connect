import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/frontend/Main_screen.dart';
import 'package:social_media_app/frontend/responsive_layout.dart';
import 'package:social_media_app/provider/user_provider.dart';
import 'package:social_media_app/utils/colors.dart';
import 'frontend/login_screen.dart';
import 'frontend/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBuLbkwIr132Okj-E2r3siplb1UTe1YzUM",
        appId: "1:964213022638:android:a3e91ab4b190e5e6da323f",
        messagingSenderId: "964213022638  ",
        projectId: "socio-connect-ee19d",
        storageBucket: 'socio-connect-ee19d.appspot.com'),
  );
  ChatOptions options =
      ChatOptions(appKey: "411007778#1177172", autoLogin: false);
  await ChatClient.getInstance.init(options);
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return ResponsiveLayout();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return LoginScreen();
          },
        ),
      ),
    );
  }
}
