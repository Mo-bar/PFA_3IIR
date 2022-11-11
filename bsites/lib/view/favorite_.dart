import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: must_be_immutable
class Favorite extends StatefulWidget {
String email;
  Favorite({Key? key,required this.email}) : super(key: key);
  @override
  State<Favorite> createState() => _FavoriteState();
}
class _FavoriteState extends State<Favorite> {
  TextEditingController email = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldFav = GlobalKey<ScaffoldState>();
  int isPressed = 0;
@override
  void initState() {
    email.text = widget.email;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldFav,
      appBar: AppBar(
        title: const Text('Favorite items'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: (() { Get.back();
          }
        ),
      ),),
      body: FutureBuilder(
        builder: (context,AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Text('${snapshot.error}');
            }else if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  
                  return Card(
                    key: Key('$index'),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex:3,
                          child: ListTile(
                            title: Column(children: <Row>[
                                //*********Title
                                Row(children: <Widget>
                                [ 
                                    const Icon(Icons.title, size:16),
                                    const SizedBox(width: 8,),
                                    Text('${snapshot.data![index]["gigName"]}',style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                  ],),
                                  //*********Desc 
                                  Row(children: <Widget>
                                  [
                                    const Icon(Icons.description_outlined,size: 16),
                                    const SizedBox(width: 8,),
                                    Text( snapshot.data[index]['desc'].toString().length > 22 ? '${snapshot.data[index]["desc"].toString().substring(0,22)}...':snapshot.data[index]["desc"].toString(),style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
                                  ],),
                                  //*********user 
                                  Row(children: <Widget>
                                  [
                                    const Icon(Icons.person_outline,size: 19),
                                    const SizedBox(width: 8,),
                                    Text('${snapshot.data![index]["userName"]}',style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
                                  ],),
                                  //*********flag 
                                  Row(children: <Widget>
                                  [
                                    const Icon(Icons.flag_outlined,size: 19),
                                    const SizedBox(width: 8,),
                                    Text('${snapshot.data![index]["flag"]}',)
                                  ],),
                            ],),
                            onTap: (){
                            },
                          ),
                        ),
                        Expanded(flex :1,child: Text('${snapshot.data![index]["price"]}\$')),
                        Expanded(
                          flex:1,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromARGB(255,250,250,250),),
                              ),
                              onPressed: ()async{

                              },
                              child: Icon(Icons.remove_shopping_cart_outlined,color: Theme.of(context).colorScheme.primary),
                            )
                          ),
                      ],
                    ),
                  );
                  }
              );
            }else{
              return const SizedBox(height: 700,child:  Center(child: Text('No Gigs',style: TextStyle(fontSize: 25,color: Colors.orangeAccent),)));
            }
          }
          return const  Center(child:  CircularProgressIndicator());
        },
      )
      );
  }
}
