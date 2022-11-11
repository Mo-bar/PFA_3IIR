import 'package:bsites/view/crud/add_gig.dart';
import 'package:bsites/view/screen/gigs/gig.dart';
import 'package:bsites/view/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String email;
  const Home(this.email, [Key? key])
      : super(
          key: key,
        );
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  GlobalKey<FormState> homeKey = GlobalKey();
  String email = '';
  String prob = '';
  static const List<Tab> tabs = [
    Tab(text: 'All'),
    Tab(text: 'Logos'),
    Tab(text: 'Web-site'),
    Tab(text: 'Mobile-app'),
    Tab(text: 'Mock-up'),
    Tab(text: 'UI-UX design'),
  ];
  @override
  initState() {
    email = widget.email;
    super.initState();
  }

  List userinfo = [];
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: tabs.length,
        initialIndex: tabIndex,
        key: homeKey,
        child: Builder(
          builder: (context) {
            return Scaffold(
                appBar: AppBar(
                  //...............AppBar.............
                  title: const Text('Category',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 40,
                          letterSpacing: 1.3,
                          fontFamily: 'Satisfy')),
                  centerTitle: true,
                  leading: IconButton(
                    //...............leading.............
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    onPressed: (() {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    }),
                  ),
                  backgroundColor: const Color.fromARGB(0, 243, 201, 87),
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.black),
                ),
                body: Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Stack(children: [
                    //...............Stack.............
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TabBarView(
                        //...............TabBarView.............
                        children: <Gigs>[
                          Gigs(email: email, tabIndex: 0),
                          Gigs(email: email, tabIndex: 1),
                          Gigs(email: email, tabIndex: 2),
                          Gigs(email: email, tabIndex: 3),
                          Gigs(email: email, tabIndex: 4),
                          Gigs(email: email, tabIndex: 4),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 30,
                        width: screenWidth - 20,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 203, 202, 204),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TabBar(
                            labelColor: Colors.black,
                            isScrollable: true,
                            indicatorWeight: 4,
                            tabs: tabs,
                            indicator: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ),
                    ),
                  ]),
                ),
                floatingActionButton: FloatingActionButton(
                    //____________________ floating button
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Addproduct(
                                email: email,
                              )));
                    },
                    child:
                        const Icon(Icons.add, size: 28, color: Colors.black)),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: BottomAppBar(
                    shape: const CircularNotchedRectangle(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.home,
                              color: Color.fromARGB(255, 243, 201, 87),
                              size: 28),
                          onPressed: () {
                            if (mounted) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => Home(email))));
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings,
                              color: Colors.grey, size: 28),
                          onPressed: () {
                            if (mounted) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => Setting(email))));
                            }
                          },
                        )
                      ],
                    )));
          },
        ));
  }
}
