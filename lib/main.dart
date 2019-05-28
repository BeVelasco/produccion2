import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'global.dart' as globals;

import 'tools.dart';
import 'principal.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asys 2019',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Asys APP de piso'),
      routes: {
        '/tools': (context) => Mytools(),
        '/principal': (context) => Myprincipal(),
      },
    );

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class usrData {
  final String key;
  usrData(this.key);
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = true;
  String _contrasena;
  String _email;
  int _state = 0;

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 78.0,
          child: Image.asset('assets/images/logo_asys.png'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(15.0, 18.0, 0.0, 0.0),
                      child: _showLogo()
                  ),
                ],
              ),
            ),

            Container(
                padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: new Container(
                  child: new Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: _formUI(),
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }

  Widget _formUI(){
    return Column(
      children: <Widget>[
        new TextFormField(
          decoration: InputDecoration(labelText: 'Email',
              fillColor: Colors.deepOrangeAccent,
              labelStyle: TextStyle(color: Colors.black,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline) ),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String val){
            _email = val;
          },
        ),

        new TextFormField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'Contraseña',
              fillColor: Colors.deepOrangeAccent,
              labelStyle: TextStyle(color: Colors.black,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline) ),
          keyboardType: TextInputType.text,
          validator: validateContra,
          onSaved: (String val) {
            _contrasena = val;
          },
        ),

        new SizedBox(
          height: 25.0,
        ),

        new RaisedButton(
          color: Colors.lightBlueAccent,
          onPressed: (){
            setState(() {
              if((_state == 0)||(_state == 2)) {
                animateButton();
                _requestLogin();
              }
            });
          },
          child: setUpButtonChild(),
        )
      ],
    );
  }

  _requestLogin() async{
    //String url = 'http://simulador.webhop.net/simulador/api/auth/login';
    String url = 'http://192.168.100.2:8000/api/auth/login';

    try {
      Map<String, String> headers = {
        'Content-type' : 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      };
      var response = await http.post(Uri.encodeFull(url),
        body: convert.jsonEncode({"email": _email, "password": _contrasena, "remember_me": false}),
        headers: headers);
        print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        print(jsonResponse.toString());
        var key = convert.jsonDecode(convert.jsonEncode(jsonResponse));
        globals.keyUser = key['access_token'];
        globals.emailUser = _email;
        Navigator.pushNamed(context, '/principal');
      } else {
        print(response.statusCode);
        // set up the AlertDialog

        AlertDialog alert = AlertDialog(
          title: Text("Datos incorrectos"),
          content: Text("El correo o contraseña no con correctos, Verificar la información"),
          actions: [
          ],
        );
        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    }catch(Ex){
      print(Ex);
      AlertDialog alert = AlertDialog(
        title: Text("Conexión"),
        content: Text("No se localiza el servidor, verificar la conexión a Internet"),
        actions: [
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  String validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Email Invalido';
    else
      return null;
  }

  String validateContra(String value){
    if(value.length == 0)
      return 'Password debe de tener al menos un caracter';
    else
      return null;
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Login",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return new Text("Login",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),);
    }
  }

  animateButton(){
    _formKey.currentState.save();
    if (_email != null || _contrasena != null) {
      if (_email.isNotEmpty && _contrasena.isNotEmpty) {
        setState(() {
          _state = 1;
        });

        Timer(Duration(milliseconds: 10000), () {
          setState(() {
            _state = 2;
          });
        });
      }
    }
  }
}

