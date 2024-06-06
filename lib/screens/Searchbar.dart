import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/recommendation_screens/Recommendation_screen.dart';
import 'package:flutter_application_6/widgets/background-color.dart';
//import 'package:flutter_application_6/widgets/background-color.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon:Icon(Icons.arrow_back_ios, 
           size: 50, 
           color:  Color.fromARGB(255, 5, 77, 59),
           weight:300, ),
           onPressed: () {
        Navigator.pop(context); // Navigate back
      },
        ),
    actions: [
      Image.asset('assets/logo1.png'),
    ],
    ),
    
    body: Stack(
      children: [
        BackgroundColor(),
        
        ListView(
          children: [
            Padding(
              padding:const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0),
                    borderSide: BorderSide(width: 0.8,),
              
              
                  ),
                  hintText: 'Search for plants',
                  prefixIcon: Icon(
                  Icons.search,
                   size: 30.0,),
                   suffixIcon: 
                   IconButton(
                    onPressed: (){
                      Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => Recommendation()), // Replace NextScreen() with the screen you want to navigate to
                       );
                    },
                    icon: Icon(Icons.sort),
                    )
                ),
              ),
            )
          ],
        )
      ],
    ),
    );
  }
}
