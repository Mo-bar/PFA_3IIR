import 'package:bsites/view/crud/account_.dart';
import 'package:bsites/view/crud/add_gig.dart';
import 'package:bsites/view/crud/listing.dart';
import 'package:bsites/view/crud/home.dart';
import 'package:bsites/view/screen/auth/login_.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'contact_.dart';
import 'favorite_.dart';

class Setting extends StatefulWidget {
  final String email;
  const Setting(this.email, [Key? key]) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String email = '', passwd = '';
  @override
  void initState() {
    email = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: users.where('username', isEqualTo: email).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!(snapshot.hasData)) {
              return const Center(
                child: Text('no data'),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  margin: EdgeInsets.zero,
                  color: const Color.fromARGB(255, 203, 202, 204),
                  child: Row(
                    children: [
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                              //______ avatar
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: const Icon(
                                Icons.person_outline_rounded,
                                size: 30,
                                color: Color.fromARGB(255, 54, 54, 54),
                              ))),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.docs[0]['username'].toString().toUpperCase(),
                            style: const TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 0.7),
                          ),
                          const Text(
                            'mouradbarkouch@gmail.com',
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 16, letterSpacing: 0.7),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(padding: const EdgeInsets.only(top: 10, left: 20), child: const Text('My bSites', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 0.7))),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  ListTile(
                    //____________________________Account button
                    title: Text('Account', style: Theme.of(context).textTheme.titleMedium),
                    leading: const Icon(
                      Icons.accessibility,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Color.fromARGB(255, 207, 207, 207)),
                    contentPadding: const EdgeInsets.only(top: 8, left: 20, right: 10),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => Account(email))));
                    },
                  ),
                  ListTile(
                    //____________________________My listing
                    title: Text('My listing', style: Theme.of(context).textTheme.titleMedium),
                    leading: const Icon(Icons.menu_outlined),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Color.fromARGB(255, 207, 207, 207)),
                    contentPadding: const EdgeInsets.only(top: 8, left: 20, right: 10),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => Listing(
                                email,
                              ))));
                    },
                  ),
                  ListTile(
                    //____________________________Favorite
                    title: Text('Favorite', style: Theme.of(context).textTheme.titleMedium),
                    leading: const Icon(Icons.favorite_outline),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Color.fromARGB(255, 207, 207, 207)),
                    contentPadding: const EdgeInsets.only(top: 8, left: 20, right: 10),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => Favorite(
                                email: email,
                              ))));
                    },
                  ),
                  ListTile(
                    //____________________________Add_to_cart
                    title: Text('Shopping cart', style: Theme.of(context).textTheme.titleMedium),
                    leading: const Icon(Icons.shopping_cart_outlined),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Color.fromARGB(255, 207, 207, 207)),
                    contentPadding: const EdgeInsets.only(top: 8, left: 20, right: 10),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => Listing(
                                email,
                              ))));
                    },
                  ),
                  ListTile(
                    //____________________________Contact
                    title: Text('Contact', style: Theme.of(context).textTheme.titleMedium),
                    leading: const Icon(Icons.call),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Color.fromARGB(255, 207, 207, 207)),
                    contentPadding: const EdgeInsets.only(top: 8, left: 20, right: 10),
                    onTap: () {
                      if (mounted) {
                        Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const Contact())));
                      }
                    },
                  ),
                  ListTile(
                    //____________________________Log out
                    title: Text('Log out', style: Theme.of(context).textTheme.titleMedium),
                    leading: const Icon(Icons.logout_outlined, color: Colors.red),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Color.fromARGB(255, 207, 207, 207)),
                    contentPadding: const EdgeInsets.only(top: 8, left: 20, right: 10),
                    onTap: () {
                      if (mounted) {
                        Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const Login())));
                      }
                    },
                  ),
                ]),
              ],
            );
          },
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
            child: const Icon(Icons.add, size: 28, color: Colors.black)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            //__________BottomAppBar
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.grey, size: 28),
                  onPressed: () {
                    if (mounted) {
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Home(email))));
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Color.fromARGB(255, 243, 201, 87), size: 28),
                  onPressed: () {
                    if (mounted) {
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Setting(email))));
                    }
                  },
                )
              ],
            )));
  }
}
