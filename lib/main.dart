// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.green),
    initialRoute: "/login",
    routes: {
      "/login": (context) => LoginPage(),
      "/home": (context) => HomePage(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Usuário logado com sucesso")),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  var isLoading = false;
  final formKey = GlobalKey<FormState>();

  void login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    setState(() {});
    final response = await apiLogin(email: email, password: password);
    isLoading = false;
    setState(() {});
    if (response) {
      Navigator.pushNamed(context, "/home");
    }
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  String? validateEmail(String? email) => email != null && email.isNotEmpty
      ? null
      : "O email precisa ser diferente de nulo";

  String? validatePassword(String? password) =>
      password != null && password.length >= 6
          ? null
          : "A senha precisa ter no minimo 6 caracteres";

  Future<bool> apiLogin(
      {required String email, required String password}) async {
    await Future.delayed(Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => validateEmail(value),
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) => validatePassword(value),
                onSaved: (value) => password = value!,
                obscureText: true,
              ),
              SizedBox(height: 32),
              if (isLoading)
                CircularProgressIndicator()
              else
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      if (validate()) {
                        login(email: email, password: password);
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



// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   final isValid = validate(email: "email", password: "password");
//   if(isValid != null){
//     login(email: "email", password: "password");
//   }
// }

// void login({
//   required String email,
//   required String password,
// }) {
//   final response = validateLogin(email: email, password: password);
//   if(response){
//     print("Abrindo a HomePage");
//   }
// }

// String? validate({String? email, String? password}){
//   final passwordIsValid = validatePassword(password!);
//   final emailIsValid = validatePassword(email!);

//   if(passwordIsValid == false){
//     return "A Senha precisa ter 6 caracteres";
//   }

//   if(emailIsValid == false){
//     return "O email precisa ser diferente de nulo";
//   }

//   return null;
// }

// bool validateEmail(String? email) => email != null && email.length > 0;
// bool validatePassword(String password) => password != null && password.length > 6;

// bool validateLogin({required String email, required String password}) {
//   print("Conectando no servidor");
//   print("Login realizado com sucesso");
//   return true;
// }







