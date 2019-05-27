import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as global;

class Mytools extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    _getip() async {
      var _ip;
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.get('ip') == null){
        pref.setString('ip', '192.168.1.142');
        _ip = '192.168.1.142';
      } else{
        _ip = pref.get('ip');
      }
      return _ip;
    }

    _getpass() async {
      var _pass;
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.get('pass') == null){
        pref.setString('pass', '123123');
        _pass = '123123';
      } else{
        _pass = pref.get('ip');
      }
      return _pass;
    }

    _setip(String _ip) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('ip', _ip);
    }

    _setpass(String _pass) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('pass', _pass);
    }

    final controllerIP = TextEditingController();
    final controllerPass = TextEditingController();
    controllerPass.text = _getpass().toString();
    controllerIP.text = _getip().toString();



    Future<void> _salvado() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Almacenado de información'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('La inormación se almaceno exiosamente'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Regresar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _neverSatisfied() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Rewind and remember'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You will never be satisfied.'),
                  Text('You\’re like me. I’m never satisfied.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Regret'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    final _dataip = TextFormField(
      controller: controllerIP,
      obscureText: false,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      style: style,
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: "IP",
      border:
      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final _datapass = TextFormField(
      controller: controllerPass,
      obscureText: false,
      keyboardType: TextInputType.text,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final _saveconf = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if((controllerIP.text.length == 0)||(controllerPass.text.length == 0) ){
              _neverSatisfied();
          }else{
            _setip(controllerIP.text);
            _setpass(controllerPass.text);
            _salvado();
          }
          },
        child: Text("Guardar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );



    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Servidor"),
                _dataip,
                Text("Password"),
                _datapass,
                SizedBox(height: 10.0),
                _saveconf,
              ],
            ),
          ),
        ),
      ),
    );
  }
}


