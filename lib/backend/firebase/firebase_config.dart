import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCJS3xKlcB9ZAk_X7hqptpspfsA9M-SnjM",
            authDomain: "quizapp-a6cc12.firebaseapp.com",
            projectId: "quizapp-a6cc12",
            storageBucket: "quizapp-a6cc12.appspot.com",
            messagingSenderId: "755144957313",
            appId: "1:755144957313:web:18456635af7708edb61c80",
            measurementId: "G-5MPE4JWGNJ"));
  } else {
    await Firebase.initializeApp();
  }
}
