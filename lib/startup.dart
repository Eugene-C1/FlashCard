import 'package:flutter/material.dart';

// class Font extends StatelessWidget {
//   const Font({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(fontFamily: 'Nunito')
//     );
//   }
// }

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key, required String title}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: 70,
                      ),
                      child: Text(
                        'Learn Free',
                        style: TextStyle(
                          color: Color(0xFFB06bfad),
                          fontSize: 28,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(32),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        'We make reviewing easier. Join now and start your academic journey with us',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFB06bfad),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                margin: EdgeInsets.only(
                  bottom: 20,
                ),
                child: Center(
                  child: Image.asset('assets/images/startup.png'),
                ),
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFB06bfad),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
