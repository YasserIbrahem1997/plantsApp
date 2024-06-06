import 'package:flutter/material.dart';

class SearchStore extends StatelessWidget {
  const SearchStore({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Container(
          
          height: 40,
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(2) ),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(onPressed: (){}, 
                  icon: Icon(Icons.clear),),
                  hintText: 'Search for plants', 

                ),
              ),
            ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xffbdeac4)],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            
          ),
          
        ),
      ),
    );
  }
}