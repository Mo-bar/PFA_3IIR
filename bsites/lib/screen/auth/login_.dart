import 'package:bsites/data/sqlite_.dart';
import 'package:bsites/screen/auth/signup_.dart';
import 'package:bsites/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class Login extends StatefulWidget  {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login>  {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();
  SqlDb sql = SqlDb();
  @override
  void initState() {
    super.initState();
  }

  bool hidePasswd = true;
  String? errorText;
  @override
  Widget build(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  double verMargin =  screenHeight > screenWidth ? screenHeight*0.013: screenWidth*0.1;
  double horMargin = screenWidth*0.1;
    return Scaffold(
      body: Form(
        key: loginKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: 
            SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Container(
                margin: EdgeInsets.only(top: screenHeight*0.15,left: horMargin, right: horMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  <Widget>[
                    SizedBox( //todo -------title
                      width: 270,
                      height: screenHeight*0.051,
                      child: DefaultTextStyle(
                        textWidthBasis: TextWidthBasis.parent,
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Serif',
                          color: Colors.black
                        ),
                        child: AnimatedTextKit(
                        displayFullTextOnTap: true,
                        isRepeatingAnimation: false,
                        pause: const Duration(seconds: 0),
                        animatedTexts: <TypewriterAnimatedText>[                      
                          TypewriterAnimatedText('Welcome in ',cursor: '', speed: const Duration(milliseconds: 200),textStyle: const TextStyle(fontWeight: FontWeight.w700)),                        
                        ],
                        onTap: () {
                        },
                      ),
                    ),
                    ),
                    SizedBox( //todo ------- Title2
                    width: 300,
                    height: screenHeight*0.056,
                    child: DefaultTextStyle(
                      textWidthBasis: TextWidthBasis.parent,
                      style: const TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Serif',
                        color: Colors.black
                      ),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                        pause: const Duration(seconds: 2),
                        animatedTexts: <TypewriterAnimatedText>[                        
                          TypewriterAnimatedText('',cursor: '', speed: const Duration(milliseconds: 0)),                        
                          TypewriterAnimatedText('B-Sites App',cursor: '', speed: const Duration(milliseconds: 200),textStyle: const TextStyle(fontWeight: FontWeight.w700, color: Color.fromARGB(250, 250, 121, 44))),                        
                        ],
                        onTap: () {
                        },
                      ),
                    ),
                    ),
                    SizedBox( //todo -------subtitle
                      width: double.infinity,
                      height: screenHeight*0.09,
                      child: DefaultTextStyle(
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Agne',
                          color: Colors.grey
                        ),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          displayFullTextOnTap: true,
                          pause: const Duration(milliseconds: 2700),
                          animatedTexts: [
                            TypewriterAnimatedText('',cursor: '',speed: const Duration(milliseconds: 200),textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                            TypewriterAnimatedText('Meet new people with new idea',cursor: '',speed: const Duration(milliseconds: 200)),
                          ],
                          onTap: () {
                          },
                        ),  
                      ),
                    ),
                    SizedBox(height: verMargin,),
                    TextFormField //todo ------- Email
                    (
                      controller: email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value == null || value =='' ? 'Required field!': null,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction:TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Email.',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    SizedBox(height: verMargin,),
                    TextFormField(//todo -------password
                    controller: passwd,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value == null || value =='' ? 'Required field!': null,
                    obscureText: hidePasswd,
                    keyboardType: TextInputType.visiblePassword,
                    decoration:  InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open_outlined,),
                      hintText: 'Password.',
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
                      SizedBox(
                        height: 18,
                        width: double.infinity,
                        child: Text(errorText ?? '', style: const TextStyle(color : Colors.redAccent, fontWeight: FontWeight.w700, letterSpacing: 0.6),textAlign: TextAlign.left,),
                      ),
                      ElevatedButton(//todo ------- Login button
                        onPressed: () async{
                          if(loginKey.currentState!.validate())
                          {
                              List<Map> list = await sql.getdata('SELECT * FROM User WHERE email = "${email.text}"');
                            if(list.isNotEmpty && mounted ){
                              Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>  Home(
                            email: email.text,
                              ))));
                            }else{
                              setState(() {
                                errorText = 'E-mail or password incorrect!';
                              });
                            }         
                          }                 
                        }, 
                        child: const Text('Log In',),
                      ),                          
                      InkWell( //**forgot password
                        child: const Text('Forgot password?', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600, letterSpacing: 0.6),),
                        onTap:(){

                        }
                      ),
                      SizedBox(height: screenHeight*0.35,),
                        Container( //todo: sign up button.
                          height: screenHeight*0.07,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(255,237, 237, 237),
                            shape: BoxShape.rectangle
                          ),
                          padding: EdgeInsets.zero,
                          child:  ListTile(
                            title: const Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                            trailing: const Icon(Icons.arrow_forward_ios, size:16,color: Colors.black,),
                            onTap: () async{
                              if(mounted){
                                Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const SignUp())));
                              }
                            },
                          )
                          )
                      ],
                    ),
              ),
            ),
      ),
    );
  }
} 