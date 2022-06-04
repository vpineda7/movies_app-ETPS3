import 'package:flutter/material.dart';
import 'package:flutter_movies_app/app/features/login/controller/auth_controller.dart';
import 'dart:convert';
import 'package:flutter_movies_app/app/features/models/movies.dart';
import 'package:flutter_movies_app/app/features/widgets/moviesWidget.dart';
import 'package:http/http.dart' as http;




class WelcomePage extends StatefulWidget {
  String email;
  WelcomePage({Key? key, required this.email}) : super(key: key);

  @override 
  _App createState() => _App(); 
}

class _App extends State< WelcomePage> {

  List<Movie> _movies = <Movie>[]; 

  @override
  void initState() {
    super.initState(); 
    _populateAllMovies(); 
  }

  void _populateAllMovies() async {
    final movies = await _fetchAllMovies();
    setState(() {
      _movies = movies; 
    });
  }

  
  Future<List<Movie>> _fetchAllMovies() async {
    String apiKey="27599a97";
    final String apiEndpoint = "https://www.omdbapi.com/?apikey="+apiKey+"&s=Batman";
    final Uri url = Uri.parse(apiEndpoint);
    final response = await http.get(url);

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Error en carga de películas!");
    }

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Movies App",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Movies")
        ),
        body: MoviesWidget(movies: _movies)
      )
    );
    
  }
}




// class WelcomePage extends StatelessWidget {
//    String email;
//    WelcomePage({Key? key, required this.email}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(children: [
//         Container(
//           width: w,
//           height: h * 0.3,
//           // decoration: const BoxDecoration(
//           //   image: DecorationImage(
//           //       image: AssetImage("assets/img/loginimg.png"),
//           //       fit: BoxFit.cover),
//           // ),
//           // child: Column(children: [
//           //   SizedBox(
//           //     height: h * 0.14,
//           //   ),
//           //   const CircleAvatar(
//           //     radius: 60,
//           //     backgroundColor: Colors.white,
//           //   )
//           // ]),
//         ),
//         const SizedBox(
//           height: 70,
//         ),
//         Container(
//           width: w,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children:  [
//               const Text(
//                 'Welcome',
//                 style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               ),
//               Text(
//                 email,
//                 style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 200,),
//         GestureDetector(
//           onTap: (){
//             AuthController.instance.logout();
//           },
//           child: Container(
//             width: w * 0.5,
//             height: h * 0.08,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               image: const DecorationImage(
//                   image: AssetImage("assets/img/loginbtn.png"),
//                   fit: BoxFit.cover),
//             ),
//             child: const Center(
//               child: Text(
//                 "Sign out",
//                 style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: h * 0.08),
//       ]),
//     );
//   }
// }


