import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  // "!" indica que el valor no serà null.
  //    No ho és perquè si ho fos, no ens hauria redirigit cap 
  //    aquesta pàgina el auth_page.dart.

  void signUserOut() {

    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut, 
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Logged in as: " + user.email!,
          style: TextStyle(fontSize: 20),
        ),
      ),
      // Provar aquí de mostrar què passa si no hi posem el "!".
    );
  }
}