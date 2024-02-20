import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/components/my_button.dart';
import 'package:flutter_firebase_auth/components/my_textfield.dart';
import 'package:flutter_firebase_auth/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void signUserUp() async {

    // Mostrar cercle de càrrega (feedback per l'usuari)
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Posem el mètode de signIn en un try/catch, 
    //    per si posen unes credencials incorrectes.
    try {
      // Check both password input texts.
      if (passwordController.text == confirmPasswordController.text) {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text,
        );

      } else {
        // Error: els dos camps de password no coincideixen.
        wrongCredencialsMessage("Passwords don't match");
      }

      

      // Traiem el cercle de càrrega (pop, com en una pila).
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {

      // Traiem el cercle de càrrega (pop, com en una pila).
      Navigator.pop(context);

      //print("Error amb les credencials: " + e.toString());

      wrongCredencialsMessage("The email and/or password are not correct.");
    }
  }

  void wrongCredencialsMessage(String text) {

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text(text,),
        );
      },
    );
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
            
                // Logo.
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
            
                const SizedBox(
                  height: 50,
                ),
            
                // Welcome back message.
                Text(
                  "Let's create an account",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
            
                const SizedBox(
                  height: 25,
                ),
            
                // Username field.
                MyTextField(
                  controller: emailController,
                  hintText: "Username",
                  obscureText: false,
                ),
            
                const SizedBox(
                  height: 25,
                ),
            
                // Password field.
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
            
                const SizedBox(
                  height: 10,
                ),

                // Confirm password.
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm password",
                  obscureText: true,
                ),
            
                const SizedBox(
                  height: 25,
                ),
            
                // Sign in button
                MyButton(
                  onTap: signUserUp,
                  text: "Sign up",
                ),
            
                const SizedBox(
                  height: 50,
                ),
            
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(
                  height: 50,
                ),
            
                // Google or Apple Sign in buttons.
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google button.
                    SquareTile(imagePath: "lib/images/google.png"),
            
                    SizedBox(
                      width: 25,
                    ),
            
                    // Apple button.
                    SquareTile(imagePath: "lib/images/apple.png"),
                  ],
                ),
            
                const SizedBox(
                  height: 50,
                ),
            
                // Not a member? Register now.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a member?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
