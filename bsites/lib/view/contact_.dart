import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(
        title: const Text('Contact',),
        leading: IconButton(
          onPressed: () {
              Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Column(
        children:  <Widget>[
          const ListTile(
            leading: Icon(Icons.person_outline, size: 25,),
            title: Text('Mourad.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
          const Divider(thickness: 3,indent: 20, endIndent: 30,),
          const ListTile(
            leading: Icon(Icons.person_outline, size: 25,),
            title: Text('BARKOUCH.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
          const Divider(thickness: 3,indent: 20, endIndent: 30,),
          const ListTile(
            leading: Icon(Icons.email_outlined, size: 25,),
            title: Text('mourad.barkouch@edu-emsi.ma.', style: TextStyle(fontSize: 16,color: Colors.blueAccent, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
          const Divider(thickness: 3,indent: 20, endIndent: 30,),
          const ListTile(
            leading: Icon(Icons.phone_android_outlined, size: 25,),
            title: Text('06-82690009.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
          const Divider(thickness: 3,indent: 20, endIndent: 30,),
          ListTile(
            leading: const Icon(Icons.data_object_outlined, size: 25,),
            title: Row(children: const <Text>[
              Text('PFA project called ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
              Text("'b-Sites'", style: TextStyle(fontSize: 18,color: Colors.blueAccent, fontWeight: FontWeight.bold, letterSpacing: 1)),
            ],)
          ),
          const Text('Ecommerce app for  buying/ Selling Services.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const Divider(thickness: 3,indent: 20, endIndent: 30,),
        ],
      )
    );
  }
}