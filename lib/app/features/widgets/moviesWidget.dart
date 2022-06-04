import 'package:flutter_movies_app/app/features/login/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/app/features/models/movies.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class MoviesWidget extends StatefulWidget {
 // Principal({Key? key}) : super(key: key); ya que lo usamos de manera estatica lo podemos quitar 

  @override
  State<MoviesWidget> createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  int activeTab=0;
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 218, 228),
      bottomNavigationBar: 
      botoneFooter(), 
      body: getPaginas(),

    );//en vez de container

  }

  Widget getPaginas(){
    print("activeTab:"+activeTab.toString());
    if (activeTab  == 3) {
       AuthController.instance.logout();
      //  activeTab=0; 
      
    }
    return IndexedStack(
      index: activeTab,
      
      children: [        
        // PaginaPrincipal(),
        listMovies(),       
      ],
    );
  }
  Widget listMovies() {
    return Container(
          child: ListView.builder(
            itemCount: _movies.length,
            itemBuilder: (context, index) {

              final movie = _movies[index];
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
                        Text(movie.year),
                        Text(movie.type)
                    ],),
                      ),
                  ),
              
                ],),

              );
            }
          ),
        );

  }
  Widget botoneFooter(){
    List items=[//creamos un array con la lista de los iconos que necesitamos
        FeatherIcons.home,
        FeatherIcons.search,
        FeatherIcons.heart,
        FeatherIcons.logOut,
    ];
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Color.fromARGB(255, 250, 251, 251)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index){//indicamos la cantidad de botones
            return IconButton(
              onPressed: (){//metodo onclick                            
              setState(() {
                activeTab=index;//creamos una variable llamada ativitab y la inicilializamos con 0
              });
            }
            , icon: Icon(//llamamos los botones a utilizar
              items[index], 
             color: activeTab==index ? Color.fromARGB(255, 178, 55, 170) : Colors.black,)
             );
          }),
        ),
        
      ),
      
    );
  }
}