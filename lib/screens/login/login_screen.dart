import 'package:e_commerce_estudo/constants.dart';
import 'package:e_commerce_estudo/models/user_model.dart';
import 'package:e_commerce_estudo/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Entrar"),
          centerTitle: true,
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text(
                "Criar conta".toUpperCase(),
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || !text.contains('@'))
                        return "E-mail inválido";
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha inválida";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty)
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content:
                                Text("Insira seu e-mail para recuperação!"),
                            backgroundColor: kPrimaryColor,
                            duration: Duration(seconds: 2),
                          ));
                        else {
                          model.recoverPass(_emailController.text);

                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Confira seu e-mail!"),
                            backgroundColor: kPrimaryColor,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            model.signIn(
                                email: _emailController.text,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          }
                        },
                        child: model.isLoading
                            ? Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                "Entrar",
                                style: TextStyle(fontSize: 18),
                              ),
                        textColor: Colors.white,
                        color: kPrimaryColor,
                      ))
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao entrar!"),
      backgroundColor: kPrimaryColor,
      duration: Duration(seconds: 2),
    ));
  }
}
