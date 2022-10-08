import 'package:bsites/data/sqlite_.dart';
import 'package:flutter/material.dart';

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
  SqlDb sql = SqlDb();
  loadData()async{
    List<Map> helper = [];
    helper.addAll(await sql.getdata('''
    SELECT DISTINCT G.*,G.favorite,C.flag,U.userName 
    FROM  
    Gig G, User U,Country C 
    WHERE  
    G.catId = $tabIndex AND G.email = U.email AND C.name = U.countryName'''));
    return helper;
  }
@override
  void initState() {
    email.text = widget.email;
    tabIndex = widget.tabIndex;
    loadData();
    super.initState();
  }
  int press = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldLogo,
      body: FutureBuilder(
        future: loadData(),
        builder: (context,AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Text('${snapshot.error}');
            }else if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  int currentIndex = index;
                  press = snapshot.data![currentIndex]["favorite"];
                  return Card(
                    key: ValueKey('$index'),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex:4,
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: ListTile(
                              title:  Column(children: <Widget>[
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
                                    Text('${snapshot.data![index]["desc"]}',style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
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
                                  //*********duration
                                  Row(children: <Widget>
                                  [
                                    const Icon(Icons.timelapse_sharp,size: 19),
                                    const SizedBox(width: 8,),
                                    Text('${snapshot.data![index]["duration"]}  days',style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
                                  ],),
                                  //*********price
                                  Row(children: <Widget>
                                  [
                                    const Icon(Icons.attach_money,size: 19),
                                    const SizedBox(width: 8,),
                                    Text('${snapshot.data![index]["price"]} \$',style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
                                  ],),
                              ]),
                              onTap: (){
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: ElevatedButton( //*** Add to cart
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 250, 250, 250)),
                              ),
                              onPressed: ()async
                              {
                                press = snapshot.data![currentIndex]["favorite"];
                                press == 0 ? press = 1 : press = 0;
                                int tester =  await sql.updateData_('UPDATE Gig SET favorite = $press WHERE gigId = ${snapshot.data[currentIndex]["gigId"]}');
                                if(mounted && tester > 0){
                                    }
                                    setState(() {});
                              },
                              child: press == 0 ?  Icon(key : ValueKey(index), Icons.add_shopping_cart_outlined,color: Colors.black) : Icon(key : ValueKey(index), Icons.remove_shopping_cart_outlined,color: Theme.of(context).colorScheme.primary),
                            )
                          ),
                      ],
                    ),
                  );
                  }
              );
            }
          }
          return const  Center(child:  CircularProgressIndicator());
        },
      )
      );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
