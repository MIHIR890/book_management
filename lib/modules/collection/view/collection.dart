import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:dashboard/main.dart';
// import 'package:dashboard/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Collection extends StatefulWidget {
  const Collection({super.key});

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 1);
  // Sample list of collections with names and IDs
  final List<Map<String, String>> collections = [
    {'id': '1', 'name': 'Collection 1'},
    {'id': '2', 'name': 'Collection 2'},
    {'id': '3', 'name': 'Collection 3'},
    {'id': '4', 'name': 'Collection 4'},
    {'id': '5', 'name': 'Collection 5'},
    {'id': '6', 'name': 'Collection 6'},
    {'id': '7', 'name': 'Collection 7'},
    {'id': '8', 'name': 'Collection 8'},
    {'id': '9', 'name': 'Collection 9'},
    {'id': '10', 'name': 'Collection 10'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Collection",
        )),
        body: GridView.custom(
          shrinkWrap: true,
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: const [
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 2),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              final collection = collections[index];
              return Tile(
                id: collection['id']!,
                name: collection['name']!,
                color: colors[index % colors.length],
              );
            },
            childCount: collections.length,
          ),
        ),
        bottomNavigationBar: AnimatedNotchBottomBar(
          /// Provide NotchBottomBarController
          notchBottomBarController: _controller,
          color: Colors.white,
          showLabel: true,
          textOverflow: TextOverflow.visible,
          maxLine: 1,
          shadowElevation: 5,
          kBottomRadius: 28.0,

          // notchShader: const SweepGradient(
          //   startAngle: 0,
          //   endAngle: pi / 2,
          //   colors: [Colors.red, Colors.green, Colors.orange],
          //   tileMode: TileMode.mirror,
          // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
          notchColor: Colors.black87,

          /// restart app if you change removeMargins
          removeMargins: false,
          bottomBarWidth: MediaQuery.of(context).size.width,
          showShadow: false,
          durationInMilliSeconds: 300,

          itemLabelStyle: const TextStyle(fontSize: 10),

          elevation: 1,
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(
                Icons.home_filled,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.home_filled,
                color: Colors.blueAccent,
              ),
              itemLabel: 'Home',
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.star, color: Colors.blueGrey),
              activeItem: Icon(
                Icons.star,
                color: Colors.blueAccent,
              ),
              itemLabel: 'Collection',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.settings,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.settings,
                color: Colors.pink,
              ),
              itemLabel: 'Page 3',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.person,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.person,
                color: Colors.yellow,
              ),
              itemLabel: 'Page 4',
            ),
          ],
          onTap: (index) {
            print('current selected index $index');
            // _pageController.jumpToPage(index);
            switch (index) {
              case 0:
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Dashboard()),
                // );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Collection()),
                );
                break;
              case 3:
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfileScreen()),
                // );
                break;
            }
          },
          kIconSize: 24.0,
        ));
  }
}

class Tile extends StatelessWidget {
  final String id;
  final String name;
  final Color color;

  const Tile(
      {required this.id, required this.name, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('ID: $id, Collection Name: $name');
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// List of colors for tile backgrounds
const List<Color> colors = [
  Color(0xffC75B7A), // Midnight Blue
  Color(0xFF333333), // Charcoal
  Color(0xFF2F4F4F), // Dark Slate Gray
  Color(0xFFD9ABAB), // Crimson
  Color(0xFF4682B4), // Steel Blue
  Color(0xffe7e8d83), // Olive Drab
  Color(0xFFAF8260), // Dim Gray
  Color(0xFFB22222), // Firebrick
  Color(0xFF708090), // Slate Gray
  Color(0xFF2E8B57), // Sea Green
];
