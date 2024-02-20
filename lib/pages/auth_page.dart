import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/pages/home_page.dart';
import 'package:flutter_firebase_auth/pages/login_or_register.dart';
import 'package:flutter_firebase_auth/pages/login_page.dart';

// Classe utilitzada per comprovar si l'usuari té sessió iniciada o no.
// ====================================================================
// Si no està la sessió iniciada, mostra la pàgina de Login.
// Si està la sessió iniciada, mostra la Home page.

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // El "stream" escolta canvis en l'estat de l'autenticació.
        //    En aquest cas, si l'usuari té sessió iniciada o no.
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          
          // Usuari amb sessió iniciada:
          if (snapshot.hasData) {
            return HomePage();
          }

          // Usuari amb sessió no iniciada:
          else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}