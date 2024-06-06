import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_6/screens/Addpost.dart';
import 'package:flutter_application_6/screens/Searchbar.dart';
import 'package:flutter_application_6/screens/auth/login.dart';
import 'package:flutter_application_6/screens/profilepicture.dart';
import 'package:flutter_application_6/widgets/bottombar.dart';
import 'package:flutter_application_6/widgets/background-color.dart';
//import 'package:flutter_application_6/screens/Addpost.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CommunityPage extends StatefulWidget {

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _selectedIndex = 1;
  bool isFavorite1 = false;
  bool isFavorite2 = false;
  bool isFavorite3 = false;
  bool isFavorite4 = false;
  bool isFavorite5 = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String privacy = 'Public';

  String postContent = '';

  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0.0,
        leading: Container(
          padding: EdgeInsets.all(1),
          child: Image.asset('assets/logo1.png'),
        ),
        
        actions: [
          IconButton(
              
              icon: Icon(
                Icons.search,
                size: 30,
                color: Color.fromARGB(255, 5, 77, 59),
              ),
              onPressed: ()  {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
              },

              ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                size: 30,
                color: Color.fromARGB(255, 5, 77, 59),
              )),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Color.fromARGB(255, 5, 77, 59),
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // Open the end drawer
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xFF054D3B),
        child: ListView(
          children: <Widget>[
            GestureDetector( onTap: () {
             //Navigate to another page when the ListTile is tapped
              Navigator.push(
                   context,
            MaterialPageRoute(builder: (context) => ProfilePicure()),
                    );
                // Handle tap on Settings
                 },
            
            child:
            ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
              ),
              title: Text('My Account',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            
            ),),
            GestureDetector( onTap: () {
             //Navigate to another page when the ListTile is tapped
              Navigator.push(
                   context,
            MaterialPageRoute(builder: (context) => AddPost()),
                    );
                // Handle tap on Settings
                 },
            
            child:ListTile(
              leading: Icon(
                Icons.post_add,
                color: Colors.white,
              ),
              title: Text('Post',
                  style: TextStyle(
                    color: Colors.white,
                  ),),),
            
            ),
            ListTile(
              leading: Icon(
                Icons.people_outlined,
                color: Colors.white,
              ),
              title: Text('Friends',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onTap: () {
                // Handle tap on Settings
              },
            ),
            ListTile(
              leading: Icon(
                Icons.people_alt,
                color: Colors.white,
              ),
              title: Text('Community',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onTap: () {
                // Handle tap on Settings
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text('Settings',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onTap: () {
                // Handle tap on Settings
              },
            ),
          GestureDetector( onTap: () {
             //Navigate to another page when the ListTile is tapped
              Navigator.push(
                   context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                // Handle tap on Settings
                 },
            child:ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text('Log Out',
                  style: TextStyle(
                    color: Colors.white,
                  )
                  ),
              
            ),
          ),
            // Add more ListTiles for additional sidebar items
          ],
        ),
      ),



body: Stack(
  children: [
    BackgroundColor(),
    SingleChildScrollView(
  child:   Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 365,
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(156, 198, 210, 211),
                  borderRadius: BorderRadius.circular(20),
                ),
                 child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_picture.png'),
                        radius: 30,
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Add New Post',
                            fillColor: Color.fromRGBO(5, 77, 59, 100),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    
                   Material(
                      color: Colors.transparent,
                       child: InkWell(
                        onTap: () {
                             getImage();
                                  },
      child:Image(image: AssetImage('assets/Mask group44.png'))


      ),
    ),

                  ],
              ),
            ),
            ),
         
          SizedBox(height: 8), 
          
          Container(
                  
              width: 400,
              height: 210,
              decoration: BoxDecoration(
                color: Colors.transparent, // Example color
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF054D3B))
              ),
              
              
                child:Column(
                
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Row(children:
                 [ 
                   CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_picture.png'),
                        radius: 30,
                      ),
                      SizedBox(width: 5,),
                      
                      Text('UserName',
                      style: TextStyle(
                        fontSize: 20, 
                        color: 
                          Color(0xFF054D3B),
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      

                ],
              
                mainAxisAlignment: MainAxisAlignment.start,
                
                ) ,
                Spacer(),
            Row(
             children: [
               IconButton(
            icon: Icon(isFavorite1
                      ? Icons.favorite
                      : Icons.favorite_outline_outlined,
                  size: 30,
                  color: isFavorite1 ? Colors.red : null, // Change color when tapped
                ),
            onPressed: () {
              setState(() {
                    isFavorite1 = !isFavorite1;
                  });
              // Implement your love button functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.comment_outlined,
            size: 30,),
            onPressed: () {
              // Implement your comments button functionality here
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
                  
                  ],
                )
              
          
                ),
              SizedBox(height: 10,),
              Container(
                  
              width: 400,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.transparent, // Example color
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF054D3B))
              ),
              
              
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children:
                 [ 
                   CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_picture.png'),
                        radius: 30,
                      ),
                      SizedBox(width: 5,),
                      
                      Text('UserName',
                      style: TextStyle(
                        fontSize: 20, 
                        color: 
                          Color(0xFF054D3B),
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      

                ],
              
                mainAxisAlignment: MainAxisAlignment.start,
                
                ),
         Spacer(),
          Row(
        children: [
          IconButton(
            icon: Icon(isFavorite2
                      ? Icons.favorite
                      : Icons.favorite_outline_outlined,
                  size: 30,
                  color: isFavorite2 ? Colors.red : null, // Change color when tapped
                ),
            onPressed: () {
              setState(() {
                    isFavorite2 = !isFavorite2;
                  });
              // Implement your love button functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.comment_outlined,
            size: 30,),
            onPressed: () {
              // Implement your comments button functionality here
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ), 
                  ],
                ),
          
                ),
                SizedBox(height: 10,),
                Container(
                  
              width: 400,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.transparent, // Example color
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF054D3B))
              ),
              
              
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children:
                 [ 
                   CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_picture.png'),
                        radius: 30,
                      ),
                      SizedBox(width: 5,),
                      
                      Text('UserName',
                      style: TextStyle(
                        fontSize: 20, 
                        color: 
                          Color(0xFF054D3B),
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      

                ],
              
                mainAxisAlignment: MainAxisAlignment.start,
                
                ),
                Spacer(),
                  Row(
                 children: [
                  IconButton(
            icon: Icon(isFavorite3
                      ? Icons.favorite
                      : Icons.favorite_outline_outlined,
                  size: 30,
                  color: isFavorite3 ? Colors.red : null, // Change color when tapped
                ),
            onPressed: () {
              setState(() {
                    isFavorite3 = !isFavorite3;
                  });
              // Implement your love button functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.comment_outlined,
            size: 30,),
            onPressed: () {
              // Implement your comments button functionality here
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
                
                  ],
                ), 
          
                ),
                SizedBox(height: 10,),
                Container(
                  
              width: 400,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.transparent, // Example color
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF054D3B))
              ),
              
              
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children:
                 [ 
                   CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_picture.png'),
                        radius: 30,
                      ),
                      SizedBox(width: 5,),
                      
                      Text('UserName',
                      style: TextStyle(
                        fontSize: 20, 
                        color: 
                          Color(0xFF054D3B),
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      

                ],
              
                mainAxisAlignment: MainAxisAlignment.start,
                
                ),
          Spacer(),
          Row(
        children: [
          
          IconButton(
            icon: Icon(isFavorite4
                      ? Icons.favorite
                      : Icons.favorite_outline_outlined,
                  size: 30,
                  color: isFavorite4 ? Colors.red : null, // Change color when tapped
                ),
            onPressed: () {
              setState(() {
                    isFavorite4 = !isFavorite4;
                  });
              // Implement your love button functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.comment_outlined,
            size: 30,),
            onPressed: () {
              // Implement your comments button functionality here
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ), 
                  ],
                ),
          
                ),
          
           

          ],
    )
    ),
  ],

),

        bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    
    );
  }


}