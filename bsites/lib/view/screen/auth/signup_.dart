import 'package:bsites/view/crud/home.dart';
import 'package:bsites/view/screen/auth/login_.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> signupKey = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();
  String? errorText;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    super.initState();
  }

  //____________________________________ ui design
  bool hidePasswd = true;
  double radius = 3;
  Color primaryColor = const Color.fromARGB(250, 250, 121, 44);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalMargin = 8;
    return Scaffold(
        body: Form(
            key: signupKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        //____________ logo
                        height: screenHeight * 0.34,
                        width: double.infinity,
                        // padding: const  EdgeInsets.only(top:50,bottom: 150 , left: 130),
                        child: Center(
                          child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              )),
                        ),
                      ),
                      const Text('Welcome in BSites app.',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              letterSpacing: 1.3,
                              fontFamily: 'Satisfy')),
                      TextFormField(
                          //___________ User name
                          controller: username,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'User name is required.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'User name',
                            errorStyle: TextStyle(height: 0.8),
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          )),
                      SizedBox(
                        height: horizontalMargin,
                      ),
                      TextFormField(
                        //___________ Email
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required.';
                          }
                          return null;
                        },
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      SizedBox(
                        height: horizontalMargin,
                      ),
                      TextFormField(
                          //___________ Passwd
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required field'
                              : null,
                          controller: passwd,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: hidePasswd,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock_open),
                              suffixIcon: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: IconButton(
                                    icon: Icon(
                                        hidePasswd
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            const Color.fromARGB(131, 0, 0, 0)),
                                    onPressed: () {
                                      setState(() {
                                        hidePasswd = !hidePasswd;
                                      });
                                    },
                                  )))),
                      SizedBox(
                        height: horizontalMargin,
                      ),
                      SizedBox(
                        //______________Error text
                        height: 18,
                        width: double.infinity,
                        child: Text(
                          errorText ?? '',
                          style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ElevatedButton(
                        //___________ Signup button
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          if (signupKey.currentState!.validate()) {
                            users
                                .where('email', isEqualTo: email.text)
                                .get()
                                .then((QuerySnapshot querySnapshot) async {
                              if (querySnapshot.docs.isEmpty && mounted) {
                                await users
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  users
                                      .add({
                                        'username': username.text,
                                        'email': email.text,
                                        'passwd': passwd.text,
                                      })
                                      .then((value) => debugPrint("User Added"))
                                      .catchError((error) => debugPrint(
                                          "Failed to add user: $error"));
                                  Get.off(Home(email.text));
                                  setState(() {
                                    errorText = null;
                                  });
                                });
                              } else {
                                setState(() {
                                  errorText = 'Email is already in use.';
                                });
                              }
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: horizontalMargin,
                      ),
                      const Center(
                        //______________Terms & privacy
                        child: Text(
                          'By signing up you are agree to our',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(161, 0, 0, 0)),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: const Text('Terms',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 48, 48, 48))),
                              onTap: () {},
                            ),
                            const SizedBox(width: 3),
                            const Text('and',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 48, 48, 48))),
                            const SizedBox(
                              width: 3,
                            ),
                            const InkWell(
                              child: Text('Privacy',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            )
                          ]),
                      SizedBox(
                        height: screenHeight * 0.27,
                      ),
                      Center(
                        child: InkWell(
                            //___________ Already have an account
                            onTap: () {
                              if (mounted) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => const Login())));
                              }
                            },
                            child: const Text('Already have account?',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 48, 48, 48),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                      )
                    ],
                  )),
            )));
  }
}
