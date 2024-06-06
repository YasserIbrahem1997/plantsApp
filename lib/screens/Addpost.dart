import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_6/screens/Community.dart';
import 'package:flutter_application_6/widgets/background-color.dart';
import 'package:flutter_application_6/widgets/bottombar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';


class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 50,
            color: Color.fromARGB(255, 5, 77, 59),
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: Text(
          'Add post',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
          color: Color(0xff58BB80),
      borderRadius: BorderRadius.circular(20)),
          child:TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
            builder: (context) {
           return CommunityPage();
          },
            )
            );
          },
          
           child: Text('Post', style: TextStyle(fontSize: 18,
            color:Color.fromARGB(255, 5, 77, 59),
            fontWeight: FontWeight.bold ),
            )
            )
            ),
        ],
      ),
      body: Stack(
        children: [
          BackgroundColor(),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/user_image.png'),
                      radius: 40,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 4, 84, 64)),
                        ),
                        DropdownButton<String>(
                          value: privacy,
                          onChanged: (String? newValue) {
                            setState(() {
                              privacy = newValue!;
                            });
                          },
                          items: <String>['Public', 'Private']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    child: TextField(
                      onChanged: (value) {
                        postContent = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'What Do You Want To Share With People?...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                      ),
                      maxLines: null,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (_image != null) ...[
                  Image.file(_image!),
                  SizedBox(height: 20),
                ],
              ],
            ),
          ),
    Positioned(
  bottom: 20,
  right: 20, // تحديد الموقع على اليمين
  child: Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        getImage();
      },
      child: Image(image: AssetImage('assets/Mask group44.png'))

    //  child: Image.asset(
    //    '',
      //  width: 20, // تغيير عرض الزر
      //  height: 20, // تغيير ارتفاع الزر
      ),
    ),
  ),
//),
        ],
      ),
    

    );
  }
}