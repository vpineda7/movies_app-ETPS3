import 'package:flutter_movies_app/app/features/login/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/app/features/models/movies.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_movies_app/app/features/login/view/login_page.dart';  

class MoviesWidget extends StatefulWidget {
 // Principal({Key? key}) : super(key: key); ya que lo usamos de manera estatica lo podemos quitar
  final List<Movie> movies; 

  MoviesWidget({required this.movies});

  @override
  State<MoviesWidget> createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  int activeTab=0;

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
    activeTab  == 3 ? AuthController.instance.logout():null; //AuthController.instance.logout
    return IndexedStack(
      index: activeTab,
      
      children: [
        // PaginaPrincipal(),
        
        // AuthController.instance.logout,
       
      ],
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
              // activeTab == 3 ? AuthController.instance.logout :null;
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