import 'package:flutter/material.dart';

class BookData extends StatefulWidget {
  const BookData({super.key});

  @override
  State<BookData> createState() => _BookDataState();
}

class _BookDataState extends State<BookData> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
        Stack(
          children: [
            // Background color or container
            Container(
              color: Colors.blueAccent, // Background color
            ),

            // Content container with rounded corners
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), // Top-left corner
                    topRight: Radius.circular(40), // Top-right corner
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 120.0), // Space below floating image
                  child: DefaultTabController(
                    length: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  "Book Name",
                                  style: TextStyle(
                                    fontSize: 26,
                                  ),
                                ),
                                Text(
                                  "Author Name",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20), // Add spacing if needed
                          TabBar(
                            isScrollable: true,
                            labelColor: Colors.amber,
                            unselectedLabelColor: Color(0xFF5E5E5E),
                            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            unselectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            dividerColor: Colors.transparent,
                            indicatorPadding: EdgeInsets.only(right: 10),
                            indicatorColor: Colors.amber,
                            tabs: [
                              Tab(text: 'About Book'),
                              Tab(text: 'About Author'),
                            ],
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*1.6,
                            child: TabBarView(
                              children: [
                                // Content for "About Book" tab
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                                color: Colors.blueAccent.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(20)


                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("300", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),),
                                                    Text("pages")
                                                  ],
                                                ),    Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("4.5", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),),
                                                    Text("Rating")
                                                  ],
                                                ),    Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Hard", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),),
                                                    Text("cover")
                                                  ],
                                                ),    Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("English", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),),
                                                    Text("language")
                                                  ],
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("Description", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),

                                      Text(
                                        "Winds of Eternity is a spellbinding journey through a magical world where time bends, secrets unravel, and courage is tested. This epic tale invites readers into the mythical land of Aralith, a place of breathtaking landscapes, ancient prophecies, and powerful enchantments. The story masterfully intertwines themes of destiny, love, and resilience, leaving readers mesmerized from the first page to the last.The protagonist, Liora Ventris, is a young woman who unknowingly holds the key to a prophecy that could either save or destroy her world. When a forgotten relic—the Amulet of Solara—is unearthed, its powers awaken a dark force that threatens to engulf Aralith. With the reluctant guidance of an exiled mage, Kaelthorn, and the loyalty of a spirited warrior, Aedric, Liora embarks on a perilous quest to restore balance.                                         Winds of Eternity is a spellbinding journey through a magical world where time bends, secrets unravel, and courage is tested. This epic tale invites readers into the mythical land of Aralith, a place of breathtaking landscapes, ancient prophecies, and powerful enchantments. The story masterfully intertwines themes of destiny, love, and resilience, leaving readers mesmerized from the first page to the last.The protagonist, Liora Ventris, is a young woman who unknowingly holds the key to a prophecy that could either save or destroy her world. When a forgotten relic—the Amulet of Solara—is unearthed, its powers awaken a dark force that threatens to engulf Aralith. With the reluctant guidance of an exiled mage, Kaelthorn, and the loyalty of a spirited warrior, Aedric, Liora embarks on a perilous quest to restore balance.",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.yellow.shade600,
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          onPressed: (){}, child: Text("Add this book",style: TextStyle(color: Colors.black),))

                                    ],
                                  ),
                                ),

                                // Content for "About Author" tab
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'This is the About Author section. Add details about the author here.',
                                    style: TextStyle(fontSize: 16),
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
              ),
            ),

            // Floating image card
            Positioned(
              top: 120, // Position the image above the container
              left: MediaQuery.of(context).size.width / 2 - 70, // Center the image
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 200,
                  width: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://media.istockphoto.com/id/654238540/photo/pencil-light-bulb.jpg?s=1024x1024&w=is&k=20&c=hMSS72-SWxO2ZQ9ErNoz7nXz4ZYwrZLC4qGOrthaLjg=",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
