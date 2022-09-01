import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget> [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if(email ==null || email.isEmpty) {
                      return 'Por favor, digite seu e-mail.';
                    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(_emailController.text)) {
                      return 'Por favor, digite um e-mail correto.';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(labelText: 'senha'),
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Por favor, digite sua senha';
                    } else if (senha.length < 6) {
                      return 'Por favor, digite uma senha maior que 6 caracteres'; 
                    }
                  },
                ),

                ElevatedButton(onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  
                  if(_formKey.currentState!.validate()) {
                    bool logged = await login();
                    if(!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

                    if(logged) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const HomePage()),);
                    } else {
                      _passwordController.clear();
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }

                }, child: const Text('Entrar'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  final snackBar = const SnackBar(
      content: Text(
        'e-mail ou senha são inválidos',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.redAccent);

  Future<bool> login() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    //var url = Uri.parse("URLASLDKASLDKA");

    //var resposta = await http.post(url, body: {
    //  'username': _emailController.text,
    //  'password': _passwordController.text
    //});

    //if(resposta.statusCode == 200) {
    //  sharedPreferences.setString('token', (resposta as dynamic)['token']);
    //  return true;
    //} else {
    //  return false;
   //}
    sharedPreferences.setString('token', 'laskdlajd');
    return true;

  }
}
