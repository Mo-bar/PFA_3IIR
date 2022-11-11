import 'package:bsites/view/crud/home.dart';
import 'package:bsites/view/settings.dart';
import 'package:flutter/material.dart';

class Addproduct extends StatefulWidget {
  final String email;
  const Addproduct({Key? key,required this.email}) : super(key: key);

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> 
{
  GlobalKey<FormState> addgigKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  void initState() {
    email.text = widget.email;
    super.initState();
  }
  double rowMargin = 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Gig'),
      ),
      body: Form(
        key: addgigKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(//________title
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value == null || value =='' ? 'Required field': null,
                  controller: title,
                  maxLines: 1,
                  maxLength: 23,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.title_outlined),
                    label: Text('Title',),
                  ),
                ),
                // SizedBox(height: rowMargin),
                TextFormField(//________price
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value == null || value =='' ? 'Required field': null,
                  controller: price,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_outlined),
                    suffix: Text('\$', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    label: Text('Price'),
                  ),
                ),
                SizedBox(height: rowMargin),
                TextFormField(//________duration
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value == null || value =='' ? 'Required field': null,
                  controller: duration,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.timelapse_sharp),
                    label: Text('Duration(Days)'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton( //____________________ floating button
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: (){ },
        child: const Icon(Icons.save_outlined,size:28, color: Colors.black)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar( //__________BottomAppBar
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          IconButton(
            icon: const Icon(Icons.home,color: Colors.grey, size:28),
            onPressed: (){
              if(mounted){
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>   Home(email.text))));
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings,color:  Colors.grey, size:28),
            onPressed: (){
                if(mounted){
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>   Setting(email.text))));
              }
            },
          )
        ],)
      )
    );
  }
}