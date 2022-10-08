import 'package:bsites/contact_.dart';
import 'package:bsites/crud/account_.dart';
import 'package:bsites/crud/add_gig.dart';
import 'package:bsites/crud/listing.dart';
import 'package:bsites/data/sqlite_.dart';
import 'package:bsites/favorite_.dart';
import 'package:bsites/screen/auth/login_.dart';
import 'package:bsites/screen/gigs/gig.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  final String email ; 
  const Home({Key? key,required this.email}) : super(key: key, );
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home>{
  List<Map> user = [];
  GlobalKey<FormState> homeKey = GlobalKey();
  TextEditingController email = TextEditingController();
  SqlDb sql = SqlDb();
  int indexCountry = -1, oldIndex = -1 ;
  Future<List> loadData()async { 
    List<Map> helper = [];
    helper.addAll( await sql.getdata('SELECT U.*, C.flag FROM User U, Country C WHERE U.email = "${email.text}" AND U.countryName = C.name '));
    return helper;
  }
  String prob = '';
  static const List<Tab> tabs = [
  Tab(text: 'Logos'),
  Tab(text: 'Web-site'),
  Tab(text: 'Mobile-app'),
  Tab(text: 'Mock-up'),
];
  @override
  initState() {
    email.text = widget.email;
    loadData();
    super.initState();
  }

  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: tabIndex,
      key: homeKey,
      child: Builder(
        builder: (context) {
        return Scaffold(
            appBar: AppBar( //*Appbar
              title: const Text('Category', style: TextStyle(color: Colors.white, fontSize: 30)),
              backgroundColor: Theme.of(context).colorScheme.primary,
              iconTheme: const IconThemeData(color: Colors.white),
              actions: <Widget>[
                IconButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>  Favorite(
                        email: email.text,
                      ))));
                    },
                    icon: const Icon(Icons.shopping_cart_outlined)
                ),
                IconButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>  const Login())));
                },
                    icon: const Icon(Icons.logout_outlined))
              ],
              bottom: const TabBar(
                indicatorColor:  Color.fromARGB(255, 255, 255, 255),
                isScrollable: true,
                indicatorWeight: 4,
                tabs: tabs,
                labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'serif'),
              ),
            ),
            floatingActionButton: FloatingActionButton
              ( //* floating button
                backgroundColor: Colors.greenAccent,
                onPressed: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Addproduct(
                  email: email.text,
                )));},
                child: const Icon(Icons.add,size:22)
            ),
            drawer: FutureBuilder(
                future: loadData(),
                builder: (context,AsyncSnapshot snapshot)
                {
                  if(snapshot.connectionState == ConnectionState.none || snapshot.hasError )
                  {
                    prob = 'No connection';
                  }else
                  {
                    if(snapshot.hasData == false){prob = 'No Data';}
                    else
                    {
                      return Drawer(
                        child: ListView
                          (
                            children:
                            <Widget>[
                              Container(
                                color: const Color.fromARGB(255, 50, 133, 250),
                                child: Column
                                  (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        height: 80,
                                        width: 80,
                                        margin: const EdgeInsets.only(top: 30,left: 20),
                                        child:   CircleAvatar(
                                            backgroundColor: Theme.of(context).colorScheme.primary,
                                            child: Text( snapshot.hasData ? snapshot.data![0]['userName'].substring(0,2).toString().toUpperCase() : 'UR',
                                              style: const TextStyle(fontSize: 32,fontFamily: 'serif', fontWeight: FontWeight.bold,color: Colors.white),)
                                        )
                                    ),
                                    ListTile(
                                      title: Row(children: <Widget>[
                                        const Icon(Icons.person_outline,color:Colors.white,size: 25,),
                                        const SizedBox(width: 6,),Text( snapshot.hasData ? snapshot.data[0]['userName'].toString().toUpperCase() : 'null', style: const TextStyle(color: Colors.white,fontFamily: 'serif',fontWeight: FontWeight.bold, fontSize: 21,)),
                                      ]),
                                      subtitle: Row(children: <Widget>[const Icon(Icons.email_outlined,size:25,color: Colors.white,),const SizedBox(width: 6,),Text(email.text, style: const TextStyle(color: Colors.white,fontFamily: 'serif', fontSize: 16, decoration: TextDecoration.underline),),]),
                                      trailing: Text( snapshot.hasData ? "${snapshot.data[0]['flag']}" : 'flag',style: const TextStyle(fontSize: 26),),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(color: Colors.black, thickness: 3,height: 3,),
                              ListTile(//*Account button_____________________________
                                title:  Text('Account',style: Theme.of(context).textTheme.headline1),
                                leading: const Icon(Icons.accessibility),
                                contentPadding: const EdgeInsets.only(top: 8, left: 20),
                                onTap: () {
                                  if(snapshot.hasData)
                                  {
                                    setState(() {
                                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Account(
                                        email: email.text,
                                        userName: "${snapshot.data[0]['userName']}",
                                        country: "${snapshot.data[0]['countryName']}",
                                        passwd: "${snapshot.data[0]['passwd']}",
                                      ))));
                                    });
                                  }

                                },
                              ),
                              const Divider(color: Colors.black, thickness: 1,height: 1, indent: 12, endIndent: 12,),
                              ListTile(//*******My listing
                                title:  Text('My listing', style: Theme.of(context).textTheme.headline1),
                                leading: const Icon(Icons.list_alt_outlined),
                                contentPadding: const EdgeInsets.only(top: 8, left: 20),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Listing(email: email.text,))));
                                },
                              ),
                              const Divider(color: Colors.black, thickness: 1,height: 1,indent: 12, endIndent: 12),
                              ListTile(//*******Contact
                                contentPadding: const EdgeInsets.only(top: 8, left: 20),
                                title:  Text('Contact', style: Theme.of(context).textTheme.headline1),
                                leading: const Icon(Icons.contact_page_outlined),
                                onTap: () {
                                  if(mounted){
                                    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const Contact())));
                                  }
                                },
                              ),
                              const Divider(color: Colors.black, thickness: 1,height: 1,indent: 12, endIndent: 12),
                              ListTile(//*******Log out
                                title:  Text('Log out', style: Theme.of(context).textTheme.headline1),
                                leading: const Icon(Icons.logout_outlined, color:Colors.red),
                                contentPadding: const EdgeInsets.only(top: 8, left: 20),
                                onTap: () {
                                  if(mounted){
                                    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const Login())));
                                  }
                                },
                              ),
                              const Divider(color: Colors.black, thickness: 1,height: 1,indent: 12, endIndent: 12),
                            ]
                        ),
                      );
                    }
                  }
                  return   SizedBox(height: 700,child:  Center(child: Text(prob,style: const TextStyle(fontSize: 25,color: Colors.orangeAccent),)));
                }
            ),
            body:  TabBarView(
              children: <Gigs>[
                Gigs(email: email.text, tabIndex: 0),
                Gigs(email: email.text, tabIndex: 1),
                Gigs(email: email.text, tabIndex: 2),
                Gigs(email: email.text, tabIndex: 3),
              ],
            )
        );
        }
    ,)
    );
  }
}

