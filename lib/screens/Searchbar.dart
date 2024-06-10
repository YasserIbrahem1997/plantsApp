import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/recommendation_screens/Recommendation_screen.dart';
import 'package:flutter_application_6/widgets/background-color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application_6/model/get_data_home.dart';

import 'e-commerce_screens/Plantscreen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Query<Map<String, dynamic>>? _fetchingQuery;
  String searchText = '';
  TextEditingController searchFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchFieldController = TextEditingController();
    _fetchingQuery = _defaultFetchingQuery;
  }

  Query<Map<String, dynamic>> get _defaultFetchingQuery {
    return FirebaseFirestore.instance.collection('category');
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      searchText = newQuery;
      if (newQuery.isEmpty) {
        _fetchingQuery = _defaultFetchingQuery;
      } else {
        _fetchingQuery = FirebaseFirestore.instance
            .collection('category')
            .where('planetName', isGreaterThanOrEqualTo: newQuery)
            .where('planetName', isLessThanOrEqualTo: newQuery + '\uf8ff');
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
            weight: 300,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Image.asset('assets/logo1.png'),
        ],
      ),
      body: Stack(
        children: [
          BackgroundColor(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: searchFieldController,
                  onChanged: _updateSearchQuery,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Search for plants',
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Recommendation()),
                        );
                      },
                      icon: Icon(Icons.sort),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _fetchingQuery!.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No results found"));
                      }

                      var documents = snapshot.data!.docs;
                      List<ProductHome> products = documents.map((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                        return ProductHome.fromJson(data);
                      }).toList();

                      return GridView.builder(
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          var product = products[index];
                          return product != null
                              ? Container(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                      return Plantscreen(Product: product,);
                                    }));
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 130, // Fixed height for the image
                                        width: double.infinity,
                                        child: product.imageUrls!.isNotEmpty
                                            ? ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(4)),
                                          child: CachedNetworkImage(
                                            imageUrl: product.imageUrls![0],
                                            imageBuilder: (context, imageProvider) => Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) => Center(
                                              child: Container(
                                                child: CircularProgressIndicator(),
                                                height: 30,
                                                width: 30,
                                              ),
                                            ),
                                            errorWidget: (context, url, error) => Center(
                                              child: Icon(Icons.filter_b_and_w),
                                            ),
                                          ),
                                        )
                                            : Container(height: 150, width: double.infinity), // Placeholder container
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        product.planetName ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontFamily: "Normal",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          letterSpacing: 0.27,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${product.plantPricing} EGP",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Normal",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                              : CircularProgressIndicator();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
