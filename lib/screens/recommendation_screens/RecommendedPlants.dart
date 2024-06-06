import 'package:flutter/material.dart';
import 'package:flutter_application_6/widgets/background-color.dart';

import '../../model/get_data_home.dart';
import 'datils_recmmendation.dart';

class Recommendedplants extends StatelessWidget {
  final List<Map<String, dynamic>> plants;

  const Recommendedplants({Key? key, required this.plants}) : super(key: key);

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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Recommended Plants',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 5, 77, 59)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 15),
                child: Container(
                  alignment: Alignment.center,
                  height: 2, // Height of the line
                  color: Color.fromARGB(255, 5, 77, 59), // Color of the line
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: plants.length,
                  itemBuilder: (context, index) {
                    final plant = plants[index];
                    final List<dynamic> imageUrls = plant['imageUrls'] ?? [];
                    final String imageUrl = imageUrls.isNotEmpty ? imageUrls.first : '';
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsRecommendationScreen(
                              Product: ProductHome.fromJson(plant),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          title: Text(
                            plant['planetName'] ?? 'Unknown Plant',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 5, 77, 59)),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Light: ${plant['lightNeeded']}'),
                              Text('Place: ${plant['Place']}'),
                              Text('Difficulty: ${plant['difficult']}'),
                              Text('Color: ${plant['FlowerColor']}'),
                            ],
                          ),
                          leading: Image.network(
                            imageUrl.isNotEmpty ? imageUrl : 'https://via.placeholder.com/100',
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
