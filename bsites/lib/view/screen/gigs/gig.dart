import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Gigs extends StatefulWidget {
  final String email;
  final int tabIndex;
  const Gigs({Key? key, required this.email, required this.tabIndex}) : super(key: key);
  @override
  State<Gigs> createState() => _GigsState();
}
class _GigsState extends State<Gigs> {
  final GlobalKey<ScaffoldState> scaffoldLogo = GlobalKey<ScaffoldState>();
  TextEditingController email = TextEditingController();
  int tabIndex = 0;
@override
  void initState() {
    email.text = widget.email;
    tabIndex = widget.tabIndex;
    super.initState();
  }
  int press = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      key: scaffoldLogo,
      body:  ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => --index < 0 ? const SizedBox(height: 20.0,) :
         Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          height: 120,
          child: Stack(//__________stack.
            clipBehavior: Clip.antiAlias,
            children: [
             Container(
              margin: const EdgeInsets.only(top: 10.0, right: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Color.fromARGB(255, 165, 165, 165)
                ), 
              ),  
              Slidable(  //___________Slidable
                key: UniqueKey(),
                direction: Axis.horizontal,
                endActionPane:  ActionPane(
                  motion: const BehindMotion(),
                  extentRatio: 0.3,
                  children: [
                     Container( //____________Buttons_container
                      height: double.infinity,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 156, 130, 58),
                    ),   
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(//__________add_shopping_cart_button
                          height: double.infinity,    
                          width: screenWidth*0.14,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.center,
                              colors: [Color.fromARGB(255, 165, 165, 165),Color.fromARGB(255, 203, 202, 204)]),
                            borderRadius: BorderRadius.circular(8),
                            // color:const Color.fromARGB(255, 255, 206, 45)
                          ),
                          child: IconButton(onPressed: (){ print('Added to cart');}, icon: const Icon(Icons.favorite_outline, color: Colors.white,)),
                          ),              
                        Container(//______________favorite_button
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.center,
                          colors: [ Color.fromARGB(255, 156, 130, 58), Color.fromARGB(255, 243, 201, 87)]),
                          borderRadius: BorderRadius.circular(8),
                          // color: const Color.fromARGB(255, 255, 93, 81),
                        ),
                        margin: EdgeInsets.zero,
                        height: double.infinity,
                        width: screenWidth*0.14,
                        child:  IconButton(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          onPressed: (){ print('added to favorite');}, icon: const Icon(Icons.add_shopping_cart_outlined)),
                        ),
                      ],),
                    ),
                  ],
                ),
                child:  Card(//_________________Card 
                color: Color.fromARGB(255, 255, 255, 255),
                margin: const EdgeInsets.only(top:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(//_________image
                      flex:4,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                        child:  Image.asset('assets/images/img.png', height: 120, fit: BoxFit.fill,),
                      )
                    ),
                    const VerticalDivider(width: 9,color: Colors.transparent,),
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const  <Text>[
                          Text('Develop your ios and android app using flutter and firebase.', style: TextStyle(fontFamily: 'Poppins',fontSize: 15),),
                          Text('7 days', style: TextStyle(fontFamily: 'Poppins', fontSize: 16),),
                          Text('99\$', style: TextStyle(fontFamily: 'Poppins', fontSize: 16,),)
                        ],
                      )),
                    const VerticalDivider(width: 9,color: Colors.transparent,),
                        
                  ],
                ),
                          ),
              ),
            ],
          ),
        ),
      )
      );
  }
}

