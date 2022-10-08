import 'package:bsites/data/sqlite_.dart';
import 'package:bsites/screen/auth/login_.dart';
import 'package:bsites/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> signupKey = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController countryName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();
  TextEditingController confirmPasswd = TextEditingController();
  String? errorText;
  late Map<String, Object?> infos = {
                    'userName' : username.text,
                    'countryName' : countryName.text,
                    'email' : email.text,
                    'passwd' : passwd.text,
                  };
  SqlDb sql = SqlDb();
  List<String> countries = [];
  late List<Map> countries_;
  @override
  void initState() {
    loadCountries();
    super.initState();
  }
  loadCountries() async{
    countries_ = await sql.getTableByName('Country');
    for (var element in countries_) {
      countries.add(element['name']);
    }
  }
  //todo: ui style
  bool hidePasswd = true;
  double radius = 14;
  Color primaryColor = const Color.fromARGB(250, 250, 121, 44);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rowMargin = screenHeight*0.013;
    return Scaffold(
      body: Form(
        key: signupKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Container(
          margin: EdgeInsets.only(left:screenWidth*0.1, right: screenWidth*0.1),
          child: ListView(
          children: <Widget>[
            SizedBox( // todo:___________ Logo
              height: screenHeight*0.17,
              child: Center(child: 
              Image.asset('assets/images/logo_.png', fit: BoxFit.fitHeight,),
              )
            ),
            SizedBox(height: screenHeight*0.05,),
            Column(children: 
            <Widget>[
              ElevatedButton(// todo:___________ Login with fb
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(250,66, 103, 178),),
                ),
                onPressed: (){
                },
                child: Row(//*** Login with fb
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Login with Facebook',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                    Icon(Icons.facebook_outlined)
                    ],)
              ),
              const SizedBox(height: 5,),
              const Center(child: Text('or sign up with Email', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700,fontSize: 16, letterSpacing: 1),),),
              SizedBox(height: screenHeight*0.017,),
              TextFormField(// todo:___________ User name
                controller:username,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value == null || value.isEmpty ? 'User name is required!' : null,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'User name',
                  errorStyle: TextStyle(
                    height: 0.8
                  ),
                  prefixIcon: Icon(Icons.person_outline_rounded),
                )
              ),
              SizedBox(height: rowMargin,),
              DropdownSearch<String>(// todo:___________ Country
                popupProps: const PopupProps.menu(
                  menuProps: MenuProps(
                    shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    )
                  ),
                showSelectedItems: true,
                showSearchBox: true,
                ),
                items:  countries,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    prefixIcon:  Icon(Icons.flag_outlined),
                    labelText: 'Country',
                    )
                  ),
                validator: (value)  =>  value == null || value.isEmpty ? 'Required field' : null,
                onChanged: (value)
                { 
                  countryName.text = value!;
                },
                selectedItem: null,
              ),
              SizedBox(height: rowMargin,),
              TextFormField(// todo:___________ Email
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(height: rowMargin,),
              TextFormField(// todo:___________ Passwd
                validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                controller: passwd,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hidePasswd,
                textInputAction: TextInputAction.done,
                decoration:   InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock_open),
                  suffixIcon: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: IconButton(icon:  Icon( hidePasswd ? Icons.visibility : Icons.visibility_off, color: const Color.fromARGB(131, 0, 0, 0)), 
                    onPressed: () {
                      setState(() {
                        hidePasswd = !hidePasswd;
                      });
                    },)
                  )
                )
              ),
              SizedBox(height: rowMargin,),
              TextFormField(// todo:___________ confirm passwd
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Confirm password is required';
                  }else{
                    if(value != passwd.text){
                      return 'Passwords are not identical';
                    }
                  }
                  return null;
                },
                controller: confirmPasswd,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hidePasswd,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Confirm password',
                  prefixIcon:  Icon(Icons.lock_open),
                )
              ),
              SizedBox(
                height: 18,
                width: double.infinity,
                child: Text(errorText ?? '', style: const TextStyle(color : Colors.redAccent, fontWeight: FontWeight.w700, letterSpacing: 0.6),textAlign: TextAlign.left,),
              ),
              ElevatedButton(// todo:___________ Signup button
                child:  const Text('Sign up',),
                onPressed: () async{
                  if (signupKey.currentState!.validate() ) {
                    List<Map> list = await sql.getdata('SELECT * FROM User WHERE email = "${email.text}"');
                    if(list.isEmpty ){
                      int helper = await sql.insertData('User', infos);
                      if(helper > 0 && mounted){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) =>  Home(
                          email: email.text,
                        ))));
                        await sql.insertData('Addtocard',{'email' : email.text, 'favorite' : 0});
                      }
                    }else{
                      setState(() {
                        errorText = 'E-mail is already exists!';
                      });
                    }
                  }
                },
              ),
              const Center(child: Text('By signing up you are agree to our',style: TextStyle(fontSize: 14, color:Color.fromARGB(161, 0, 0, 0)),),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                InkWell(
                  child: const Text('Terms',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700, color:Colors.black)),
                  onTap: (){},
                ),
                const SizedBox(width:3),
                const Text('and',style: TextStyle(fontSize: 14, color:Color.fromARGB(161, 0, 0, 0))),
                const SizedBox(width: 3,),
                const InkWell(child: Text('Privacy',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700, color:Colors.black)),)
              ]),              
              SizedBox(height: screenHeight*0.21,),
              Center(child: InkWell(// todo:___________ Already have an account
                onTap: (){
                  if(mounted){
                    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const Login())));
                  }
                },
                child: const Text('Already have account',style: TextStyle(fontSize: 20),)),)
            ],)
          ],
      ),
        )
      )
    );
  }
} //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////