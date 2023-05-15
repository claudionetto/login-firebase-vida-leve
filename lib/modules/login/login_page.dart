import 'package:flutter/material.dart';
import 'login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final controller = LoginController(() {
    Navigator.pushNamed(context, "/home");
  }, () {
    setState(() {});
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => controller.validateEmail(value),
                onSaved: (value) => controller.email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) => controller.validatePassword(value),
                onSaved: (value) => controller.password = value!,
                obscureText: true,
              ),
              SizedBox(height: 32),
              if (controller.error.isNotEmpty)
                Text(
                  controller.error,
                  style: TextStyle(color: Colors.red),
                ),
              if (controller.isLoading)
                CircularProgressIndicator()
              else
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      if (controller.validate()) {
                        controller.login();
                      }
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
