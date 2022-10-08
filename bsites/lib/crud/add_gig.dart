import 'package:bsites/data/sqlite_.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Addproduct extends StatefulWidget {
  final String email;
  const Addproduct({Key? key,required this.email}) : super(key: key);

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> 
{
  GlobalKey<FormState> addgigKey = GlobalKey<FormState>();
  TextEditingController gigName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController catName = TextEditingController();
  int catId = 0;
  List<String> niches = [];
  SqlDb sql = SqlDb();
  late List<Map> listCat ;
  @override
  void initState() {
    loadData();
    email.text = widget.email;
    super.initState();
  }
  // [{catId: 1, catName: Logos}, {catId: 2, catName: Web site}, {catId: 3, catName: Mobile app}, {catId: 4, catName: Mockup}]
  loadData() async{
    listCat = await sql.getTableByName('Category');
    for (var element in listCat) { niches.add('${element['catName']}'); }
    return await sql.getTableByName('Gig');
  }
  double rowMargin = 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        title: const Text('New Gig'),
        leading: IconButton(//*back button
            onPressed: (){
            bool tester = Navigator.of(context).canPop();
            if(tester) {
              Navigator.of(context).pop();
            }
          } ,icon: const Icon(Icons.arrow_back_ios_new, size: 30,color: Colors.grey,)
          ),
        actions: [
          IconButton(//* save button
            onPressed: ()async{
              if(addgigKey.currentState!.validate()){
                    int tester = await sql.insertData('Gig', {
                    'gigName' : gigName.text,
                    'price' : price.text,
                    'duration' : duration.text,
                    'desc' : desc.text,
                    'email' : email.text,
                    'catId' :  catId,
                  });
                  if(tester > 0){
                  }
              }
            }, 
            icon:  Icon(Icons.save_outlined,size: 30, color: Theme.of(context).colorScheme.primary))
        ],
      ),
      body: Form(
        key: addgigKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value == null || value =='' ? 'Required field': null,
                controller: gigName,
                maxLines: 1,
                maxLength: 23,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.title_outlined),
                  label: Text('Title',),
                ),
              ),
              DropdownSearch<String>(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                ),
                items:  niches,
                selectedItem: null,
                validator: (value) => value == null || value =='' ? 'Required field': null,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    prefixIcon: Icon(Icons.category_outlined),
                    label: Text('Category'),
                  )
                ),
                onChanged: (val) {
                  catName.text = val!;
                  setState(() {
                  catId = niches.indexOf(catName.text);
                  });
                },
              ),
              SizedBox(height: rowMargin),
              TextFormField(
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
              TextFormField(
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
              SizedBox(height: rowMargin),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value == null || value =='' ? 'Required field': null,
                controller: desc,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 4,
                maxLength: 300,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description_outlined),
                  label: Text('Description'),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}