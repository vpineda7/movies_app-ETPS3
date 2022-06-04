import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_movies_app/app/features/login/controller/auth_controller.dart';
import 'package:flutter_movies_app/app/features/login/view/login_page.dart';

import 'app/features/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController())); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_movies_app/models/movies.dart';
// import 'package:flutter_movies_app/widgets/moviesWidget.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(App());
// }




// class App extends StatefulWidget {
//   @override 
//   _App createState() => _App(); 
// }

// class _App extends State<App> {

//   List<Movie> _movies = <Movie>[]; 

//   @override
//   void initState() {
//     super.initState(); 
//     _populateAllMovies(); 
//   }

//   void _populateAllMovies() async {
//     final movies = await _fetchAllMovies();
//     setState(() {
//       _movies = movies; 
//     });
//   }

  
//   Future<List<Movie>> _fetchAllMovies() async {
//     String apiKey="27599a97";
//     final String apiEndpoint = "https://www.omdbapi.com/?apikey="+apiKey+"&s=Batman";
//     final Uri url = Uri.parse(apiEndpoint);
//     final response = await http.get(url);

//     if(response.statusCode == 200) {
//       final result = jsonDecode(response.body);
//       Iterable list = result["Search"];
//       return list.map((movie) => Movie.fromJson(movie)).toList();
//     } else {
//       throw Exception("Error en carga de películas!");
//     }

//   }

//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       title: "Movies App",
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Movies")
//         ),
//         body: MoviesWidget(movies: _movies)
//       )
//     );
    
//   }
// }
