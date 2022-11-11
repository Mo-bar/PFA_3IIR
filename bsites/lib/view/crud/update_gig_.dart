import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
class EditGig extends StatefulWidget {
  final String title;
  final double price;
  final int duration ; 
  final String email;
  const EditGig(this.title,this.price,this.duration,this.email,[Key? key]) : super(key: key);
  @override
  State<EditGig> createState() => _EditGigState();
}
class _EditGigState extends State<EditGig> {
  GlobalKey<FormState> accountKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();  
  TextEditingController duration = TextEditingController();  
  int gigId =  -1;
  int catId = -1;
  double verPadding = 16;
  List<Map> categories = [];
  List<String> category = [];
  @override
  void initState() {
    email.text = widget.email;
    title.text = widget.title;
    price.text = '${widget.price}';
    duration.text = '${widget.duration}' ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rowMargin =  screenHeight*0.02;
    if(categories.isEmpty){ 
      setState(() {});
      return const Center(child: CircularProgressIndicator(),);
    }
    return 
      Form
      (
        key: accountKey,
        autovalidateMode: AutovalidateMode.disabled,
        child :Scaffold(
          appBar: AppBar(
            title: const Text('Update Gig'),
            leading: IconButton(
              onPressed: () {
                if(mounted){
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined ),
            ),
            actions:  <Widget>[
              IconButton(onPressed: ()async{
                if(accountKey.currentState!.validate()){
                  }
                }, icon: Icon(Icons.save_outlined, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 18,)
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(left:screenWidth*0.045, right: screenWidth*0.045),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 20,),
                TextFormField(
                  enabled: false,
                    controller: email,
                    style:   const TextStyle(fontSize: 20,),
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      prefixIcon: Icon(Icons.email_outlined,size: 20,),
                      suffixIcon: Icon(Icons.edit_off,size: 20),
                    ),
                  ),
                SizedBox(height: rowMargin,),
                  TextFormField(
                    maxLength: 23,
                    controller: title,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                    style:   const TextStyle(fontSize: 20,),
                    decoration: const InputDecoration(
                      label:  Text('Title'),
                      prefixIcon:  Icon(Icons.title_outlined,size: 20,),
                    ),
                  ),
                SizedBox(height: rowMargin,),
                  TextFormField(
                    controller: desc,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                    style:   const TextStyle(fontSize: 20,),
                    decoration: const InputDecoration(
                      label: Text('Description'),
                      prefixIcon: Icon(Icons.description_outlined,size: 20,),
                    ),
                  ),
                SizedBox(height: rowMargin,),
                DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    menuProps: MenuProps(
                    ),
                  showSelectedItems: true,
                  showSearchBox: true,
                  ),
                  items: category,
                  dropdownDecoratorProps: const  DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                    label: Text('Category'),
                    prefixIcon: Icon(Icons.category_outlined,size: 24,),
                    ),
                  ),
                  validator: (value)  =>  value == null || value.isEmpty ? 'Required field' : null,
                  onChanged: (value)
                  { 
                    if(value != null){
                      setState(() {
                      catId = category.indexOf(value);
                      });
                    }
                  },
                  selectedItem:  category[catId],
                ),
                SizedBox(height: rowMargin,),
                TextFormField(
                  controller: duration,
                  validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style:   const TextStyle(fontSize: 20,),
                  decoration: const InputDecoration(
                    label: Text('Duration'),
                    prefixIcon: Icon(Icons.timelapse_outlined,size: 20,),
                    )
                  ),
                SizedBox(height: rowMargin,),
                TextFormField(
                  controller: price,
                  validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style:   const TextStyle(fontSize: 20,),
                  decoration: const InputDecoration(
                    label: Text('Price'),
                    prefixIcon: Icon(Icons.attach_money_outlined,size: 20,),
                  ),
                ),
            ],),
          )
        ),
      );
  }
}