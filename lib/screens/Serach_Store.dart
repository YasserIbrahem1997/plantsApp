import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/model/get_data_home.dart';

class SearchStore extends StatefulWidget {
  const SearchStore({Key? key}) : super(key: key);

  @override
  State<SearchStore> createState() => _SearchStoreState();
}

class _SearchStoreState extends State<SearchStore> {
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
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Center(
            child: TextField(
              controller: searchFieldController,
              onChanged: _updateSearchQuery,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchFieldController.clear();
                    _updateSearchQuery('');
                  },
                  icon: Icon(Icons.clear),
                ),
                hintText: 'Search for plants',
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(top: 13.0),
              alignment: Alignment.centerLeft,
              child: Text(
                "LocalLanguageString().searchforproducts",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  letterSpacing: 0.27,
                  fontFamily: "Normal",
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
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
                        height: 600,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.023,
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to detail page
                                },
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 7,
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Container(
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
                                                  : Container(height: 80, width: 80),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
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
                                            SizedBox(height: 5),
                                            Text(
                                              product.planetDescriotion ?? "",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Normal",
                                                fontWeight: FontWeight.w600,
                                                decoration: product.planetDescriotion != null && product.planetDescriotion!.isNotEmpty ? TextDecoration.lineThrough : null,
                                                fontSize: 10,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
