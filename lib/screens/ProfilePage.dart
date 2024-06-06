import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_6/screens/Addpost.dart';
import 'package:flutter_application_6/screens/auth/login.dart';
import 'package:flutter_application_6/screens/profilepicture.dart';
import 'package:flutter_application_6/widgets/background-color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_6/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfilePage extends StatefulWidget {


  @override
  _ProfilePageState createState() => _ProfilePageState();
  
  
  void setState(Null Function() param0) {}
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
    int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showFollowers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FollowersPage()),
    );
  }

  void _showFollowing() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FollowingPage()),
    );
  }

  void _openHighlight(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => 
          HighlightDetailPage(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        leading: Image.asset('assets/logo1.png'),
        centerTitle: true,
        actions: [
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
      body:Stack(children: [
        BackgroundColor(),
       SingleChildScrollView(
        
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture Section
            Container(
              padding: const EdgeInsets.all(0.0),
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const NetworkImage('https://your-default-image-url.com')
                          as ImageProvider,
                  child: _image == null
                      ? const Icon(Icons.add_a_photo, size: 50)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _showFollowing,
                  child: Column(
                    children: const [
                      Text(
                        'Following',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '150',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 150),
                GestureDetector(
                  onTap: _showFollowers,
                  child: Column(
                    children: const [
                      Text(
                        'Followers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '1000',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 0),
            const Text(
              '@username',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 0),
            Center(
              child: const Text(
                'My Name is Sejal. I like dancing in the rain and travelling all around the world',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Highlights Section
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _openHighlight('Story'),
                    child: Story(
                      imageUrl: 'https://via.placeholder.com/150',
                      title: 'Story',
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => _openHighlight('Story'),
                    child: Story(
                      imageUrl: 'https://via.placeholder.com/150',
                      title: 'Story',
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => _openHighlight('Story'),
                    child: Story(
                      imageUrl: 'https://via.placeholder.com/150',
                      title: 'Story',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                     backgroundColor: Color.fromRGBO(88, 187, 128, 100),
                    shadowColor: Color.fromRGBO(13, 152, 106, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                          color: Color.fromRGBO(88, 187, 128, 100), width: 2),
                    ),
                  ),
                  child: const Text('Follow'),
                ),
              ],
            ),

            const Divider(),
            // Posts Section
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: 30, // عدد الصور أو البوستات
              itemBuilder: (context, index) {
                return Image.network(
                  'https://your-post-image-url.com', // استبدل هذا بالرابط الخاص بصورتك
                  fit: BoxFit.cover,
                );
              },
            ),
          ],
        ),
      ),
      ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      
    );
  }

  Column _buildStatColumn(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class Story extends StatelessWidget {
  final String imageUrl;
  final String title;

  Story({required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class HighlightDetailPage extends StatelessWidget {
  final String title;

  HighlightDetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Content for $title',
          style: TextStyle(fontSize: 24),
        ),
      ),
      
    );
  }
}

class FollowersPage extends StatefulWidget {
  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  static const _pageSize = 20;
  final PagingController<int, String> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = List.generate(
          _pageSize, (index) => 'Follower ${pageKey + index + 1}');
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
      ),
      body: PagedListView<int, String>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<String>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(item),
          ),
        ),
      ),
      
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  static const _pageSize = 20;
  final PagingController<int, String> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = List.generate(
          _pageSize, (index) => 'Following ${pageKey + index + 1}');
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following'),
      ),
      body: PagedListView<int, String>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<String>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(item),
          ),
        ),
      ),
      
    );
    
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}


