import 'package:book_management/modules/collection/view/collection.dart';
import 'package:book_management/modules/profile/view/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  bool isSearching = false; // Add this to your StatefulWidget

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // 5 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: isSearching
                    ? Container(
                        height: 30,
                        child: TextField(
                          autofocus: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              filled: true,
                              focusColor: Colors.white,
                              fillColor: Colors.white,
                              hintText: 'Search...',
                              hintStyle: const TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          onSubmitted: (query) {
                            // Handle the search action
                          },
                        ),
                      )
                    : const Text(
                        'SliverAppBar',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                background: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://images.joseartgallery.com/100736/what-kind-of-art-is-popular-right-now.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              floating: false,
              pinned: true,
              snap: false,
              elevation: 10.0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: Icon(isSearching ? Icons.close : CupertinoIcons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                  },
                ),
                if (!isSearching) // Show more options only if not searching
                  PopupMenuButton(
                    color: Colors.white,
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      const PopupMenuItem(
                        value: 'settings',
                        child: Text(
                          'Settings',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'info',
                        child: Text(
                          'More Information',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      // Handle menu selection
                      if (value == 'settings') {
                        // Navigate to settings
                      } else if (value == 'info') {
                        // Show more information
                      }
                    },
                  ),
              ],
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100, // Fixed height for the TabBar
                width:
                    MediaQuery.of(context).size.width, // Width for the TabBar
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        tabs: List.generate(5, (index) {
                          return Tab(
                            text: 'Tab ${index + 1}', // Tab text for each tab
                          );
                        }),
                        indicatorColor:
                            Colors.blue, // Color of the active tab indicator
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: List.generate(5, (index) {
                            return Center(
                              child: Text(
                                'Content for Tab ${index + 1}',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // SliverList for vertical ListView
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       return Material(
            //         color: Colors.transparent,
            //         child: ListTile(
            //           title: Text(
            //             'Item $index',
            //             style: const TextStyle(color: Colors.blue),
            //           ),
            //         ),
            //       );
            //     },
            //     childCount: 20,
            //   ),
            // ),
          ],
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
              itemLabel: 'Profile',
            ),
          ],
          onTap: (index) {
            print('current selected index $index');
            // _pageController.jumpToPage(index);
            switch (index) {
              case 0:
                print("Home");
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Collection()),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
                break;
            }
          },
          kIconSize: 24.0,
        ));
  }
}
