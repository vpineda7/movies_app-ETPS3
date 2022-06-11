import 'package:flutter/material.dart';
import 'package:flutter_movies_app/app/features/widgets/moviesWidget.dart';


class WelcomePage extends StatefulWidget {
  String email;
  WelcomePage({Key? key, required this.email}) : super(key: key);

  @override 
  _App createState() => _App(); 
}

class _App extends State< WelcomePage> {


  @override
  void initState() {
    super.initState(); 
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies App",
      debugShowCheckedModeBanner: false, //sale con debug
      home: Scaffold(
        appBar: AppBar(
          title: Text("Movies"),
        ),
        body: MoviesWidget()
      )
    );
    
  }
}



