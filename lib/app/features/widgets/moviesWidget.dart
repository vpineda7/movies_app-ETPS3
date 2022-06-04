import 'package:flutter_movies_app/app/features/login/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/app/features/models/movies.dart';

class MoviesWidget extends StatelessWidget {

  final List<Movie> movies; 

  MoviesWidget({required this.movies});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {

        final movie = movies[index];
         double w = MediaQuery.of(context).size.width;
         double h = MediaQuery.of(context).size.height;
        return ListTile(
          title: Row(children: [
            SizedBox(
              width: 100, 
              child: ClipRRect(
                child: Image.network(movie.poster), 
                borderRadius: BorderRadius.circular(10),
              )
             
            ), 
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: [
                  Text(movie.title),
                  Text(movie.year)
              ],),
                ),
            ),
            GestureDetector(
          onTap: (){
            AuthController.instance.logout();
          },
          child: Container(
            width: w * 0.5,
            height: h * 0.08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                  image: AssetImage("assets/img/loginbtn.png"),
                  fit: BoxFit.cover),
            ),
            child: const Center(
              child: Text(
                "Sign out",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        )
          ],),
          
        );
      }
    );
    
  }

}