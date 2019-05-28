import 'package:flutter/material.dart';
import 'regtrabajo.dart';

class Myprincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asys 2019',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: {

      },
    );
  }
}

class MyPrincipalPage extends StatefulWidget {
  MyPrincipalPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MyPrincipalState createState() => MyPrincipalState();
}
TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);


  class MyPrincipalState extends State<MyPrincipalPage> {
    @override
    Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            new Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Color(0xff01A0C7),
              child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/regtrabajo');
                },
                child: Text("Trabajo Normal",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            BotonRPRTCD,
            SizedBox(
              height: 20.0,
            ),
            BotonPausar,
            SizedBox(
              height: 20.0,
            ),
            BotonReanudar,
            SizedBox(
              height: 20.0,
            ),
            BotonIncidencia
          ],
        ),
      )
    );
  }

    final BotonRPRTCD = Material (
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("RT, RD, CaDi",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final BotonPausar = Material (
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Pausar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final BotonReanudar = Material (
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Reanudar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final BotonIncidencia = Material (
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Incidencias",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
}