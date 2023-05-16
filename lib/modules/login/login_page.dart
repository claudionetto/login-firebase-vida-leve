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
      backgroundColor: Color.fromRGBO(0, 168, 150, 100),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.0),
                Image(
                  height: 170.0,
                  width: 170.0,
                  image: AssetImage('images/logo_vidaleve.png'),
                ),
                SizedBox(height: 10.0),
                Text(
                  'VIDA LEVE',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Digite seu email:',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) => controller.validateEmail(value),
                  onSaved: (value) => controller.email = value!,
                  onTap: () {
                    controller.clearError();
                  },
                ),
                SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Digite sua senha:',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) => controller.validatePassword(value),
                  onSaved: (value) => controller.password = value!,
                  onTap: () {
                    controller.clearError();
                  },
                ),
                SizedBox(height: 20),
                if (controller.error.isNotEmpty)
                  Text(
                    controller.error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                    ),
                  ),
                SizedBox(height: 20),
                if (controller.isLoading)
                  CircularProgressIndicator()
                else
                  SizedBox(
                    height: 50.0,
                    width: 200.0,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green)),
                        onPressed: () {
                          if (controller.validate()) {
                            controller.clearError();
                            controller.login();
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
