import 'package:e_commerce/screens/main_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color _visitorButtonColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          _mainImage(height, width),
          _backgroundEffect(),
          _title(height),
          Positioned(
            top: height * 0.75,
            child: Column(
              children: [
                _visitorButton(),
                _loginButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainImage(height, width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/shop01.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _backgroundEffect() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
          colors: [Colors.blue[900].withOpacity(0.5), Colors.transparent],
        ),
      ),
    );
  }

  Widget _title(height) {
    return Positioned(
      top: height * 0.15,
      child: Text(
        "E-Commerce",
        style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
        ),
      ),
    );
  }

  Widget _visitorButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: RaisedButton(
        color: Colors.white,
        highlightColor: _visitorButtonColor,
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        onPressed: () {
          setState(() {
            _visitorButtonColor = Colors.purple;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          });
        },
        child: Text(
          "Proceed as a Visitor",
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return FlatButton(
      child: Text(
        "Have an account?",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
  }
}
