import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movies_app/models/movies.dart';
import 'package:flutter_movies_app/widgets/moviesWidget.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override 
  _App createState() => _App(); 
}

class _App extends State<App> {

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
      throw Exception("Failed to load movies!");
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
