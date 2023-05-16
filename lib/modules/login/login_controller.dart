import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  String email = "";
  String password = "";
  var _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    onUpdate();
  }

  var _error = "";
  String get error => _error;
  set error(String value) {
    _error = value;
    onUpdate();
  }

  void clearError() {
    error = ''; // Define o valor da propriedade error como vazio
  }

  final formKey = GlobalKey<FormState>();
  final VoidCallback onSuccessLogin;
  final VoidCallback onUpdate;

  LoginController(this.onSuccessLogin, this.onUpdate);

  void login() async {
    try {
      isLoading = true;
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLoading = false;
      if (response.user != null) {
        onSuccessLogin();
      }
    } catch (e) {
      isLoading = false;
      error = "Email e/ou senha incorretos";
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

  String? validateEmail(String? email) =>
      email != null && email.isNotEmpty ? null : "Email Invalido";

  String? validatePassword(String? password) =>
      password != null && password.length >= 6
          ? null
          : "A senha precisa ter no minimo 6 caracteres";
}
