import 'package:bsites/data/sqlite_.dart';
import 'package:bsites/screen/home.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  final String userName;
  final String country;
  final String email;
  final String passwd;
  const Account({Key? key,required this.email,required this.userName ,required this.country,required this.passwd}) : super(key: key);
  @override
  State<Account> createState() => _AccountState();
}
class _AccountState extends State<Account> {
  GlobalKey<FormState> accounrKey = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController countryName = TextEditingController();
  TextEditingController passwd = TextEditingController();  
  SqlDb sql = SqlDb();

  List<Map> countries = [];
  List<String> country = [];

  @override
  void initState() {
    loadData();
    userName.text = widget.userName;
    email.text = widget.email;
    countryName.text = widget.country;
    passwd.text = widget.passwd;
    super.initState();
  }
  void loadData() async{
    countries = await sql.getTableByName('Country');
    if(countries.isNotEmpty){
      for(int i =0; i< countries.length;i++){
        country.add(countries[i]['name']);
      }
    }
  }
  bool hidePasswd = true;
  @override
  Widget build(BuildContext context) {
  double verPadding = 7, horPadding = 5, raduis = 14, verMargin = 12;
    return
      Form(
        key: accounrKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Update Account'),
            backgroundColor: const Color.fromARGB(255,250, 250, 250),
            leading: IconButton(onPressed: (){
              if(mounted){
                Navigator.of(context).pop();
              }
            }, icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            actions: [
              IconButton(onPressed: ()async{
                  if(accounrKey.currentState!.validate()){
                    await sql.updateData_('''
                      UPDATE User
                      SET userName = "${userName.text}",passwd = "${passwd.text}" ,countryName = "${countryName.text}" WHERE email = "${email.text}";
                    ''');
                  if(mounted){
                    Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context) => Home(
                      email: email.text,
                    ),));
                  }
                  }
              }, icon:  Icon(Icons.save_outlined,color: Theme.of(context).colorScheme.primary,))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 20,),
                TextFormField(
                  enabled: false,
                  initialValue: email.text,
                  style:   const TextStyle(fontSize: 20,),
                  decoration:  InputDecoration(
                    label: const Text('Email'),
                    contentPadding: EdgeInsets.symmetric(horizontal: horPadding, vertical: verPadding),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(raduis),
                    ),
                    prefixIcon: const Icon(Icons.email_outlined),
                    suffix: const Icon(Icons.edit_off,size: 20)
                  ),
                ),
                SizedBox(height: verMargin,),
                TextFormField(
                  controller: userName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                  style:   const TextStyle(fontSize: 20,),
                  decoration: const InputDecoration(
                    label: Text('User name'),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                SizedBox(height: verMargin,),
                DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    menuProps: MenuProps(
                      shape: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                      )
                    ),
                  showSelectedItems: true,
                  showSearchBox: true,
                  ),
                  items:  country,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration:  InputDecoration(
                      label:  Text('Country'),
                      prefixIcon:  Icon(Icons.flag_outlined)
                    ),
                  ),
                  validator: (value)  =>  value == null || value.isEmpty ? 'Required field' : null,
                  onChanged: (value)
                  { 
                    if(value != null){
                      countryName.text = value;
                    }
                  },
                  selectedItem: countryName.text,
                ),
                SizedBox(height: verMargin,),
                TextFormField(
                  controller: passwd,
                  validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: hidePasswd,
                  style:   const TextStyle(fontSize: 20,),
                  decoration:  InputDecoration(
                    label: const Text('Password'),
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: IconButton(icon:  Icon( hidePasswd ? Icons.visibility : Icons.visibility_off, color: const Color.fromARGB(131, 0, 0, 0)), 
                      onPressed: () {
                        setState(() {
                          hidePasswd = !hidePasswd;
                        });
                      },),
                    ),
                  ),
                ),
            ],
        ),
          )
      ),
    ); 
  }
}