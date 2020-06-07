import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  // String _nome;

  _salvarNome(nome) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("nome", nome);
    prefs.setBool("logado", true);
  }

  _login() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Image.asset(
                "lib/assets/images/logo.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                // onChanged: (value) => _nome = value,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Insert your name",
                ),
                validator: (nome) {
                  if (nome.isEmpty) {
                    return "Insert your name here";
                  } else if (nome.trim() == "") {
                    return "Please, inform your name";
                  }
                  return null;
                },
                onSaved: _salvarNome,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text("Log In"),
                  onPressed: _login,
                ),
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
