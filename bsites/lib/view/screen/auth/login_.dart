import 'package:bsites/controller/user.dart';
import 'package:bsites/view/screen/auth/signup_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final Users _user = Get.find();
  @override
  void initState() {
    super.initState();
  }

  bool hidePasswd = true;
  @override
  Widget build(BuildContext context) {
    UserCredential userCredential;
    double screenHeight = MediaQuery.of(context).size.height;
    double verMargin = 8;
    return Scaffold(
      body: Form(
        key: loginKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  //____________ logo
                  height: screenHeight * 0.34,
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                        width: 80,
                        height: 140,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: verMargin,
                ),
                ElevatedButton(
                    //___________ Login with fb
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                    ),
                    onPressed: () async {
                      final LoginResult loginResult = await FacebookAuth.instance.login();
                      // Create a credential from the access token
                      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
                      // Once signed in, return the UserCredential
                      UserCredential userCred = FirebaseAuth.instance.signInWithCredential(facebookAuthCredential) as UserCredential;
                      print(userCred);
                      // or FacebookAuth.i.logOut();
                    },
                    child: Row(
                      children: const <Widget>[
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            Icons.facebook_sharp,
                            color: Color.fromARGB(250, 66, 103, 178),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Text('Login with Facebook', style: TextStyle(fontFamily: 'Poppins', letterSpacing: 0.4, fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black)),
                      ],
                    )),
                SizedBox(
                  height: verMargin,
                ),
                ElevatedButton(
                    //___________ Login with Google
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                    ),
                    onPressed: () async {},
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/google.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        const Text('Login with Google', style: TextStyle(fontFamily: 'Poppins', letterSpacing: 0.4, fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black)),
                      ],
                    )),
                SizedBox(
                  height: verMargin,
                ),
                const Center(
                  child: Text('Or sign in with Email'),
                ),
                SizedBox(
                  height: verMargin,
                ),
                TextFormField //_______________________________ Email
                    (
                  controller: _user.email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value == null || value == '' ? 'Required field!' : null,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Email.',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(
                  height: verMargin,
                ),
                TextFormField(
                  //_______________________________password
                  controller: _user.passwd,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value == null || value == '' ? 'Required field!' : null,
                  obscureText: hidePasswd,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_open_outlined),
                    hintText: 'Password.',
                    suffixIcon: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: IconButton(
                        icon: Icon(hidePasswd ? Icons.visibility : Icons.visibility_off, color: const Color.fromARGB(131, 0, 0, 0)),
                        onPressed: () {
                          setState(() {
                            hidePasswd = !hidePasswd;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    //_______________________________ Error text
                    height: 18,
                    width: double.infinity,
                    child: GetBuilder<Users>(
                      builder: (value) => Text(
                        value.errorText,
                        style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                        textAlign: TextAlign.left,
                      ),
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      //______________ forgot password
                      child: const Text(
                        'Forgot password?',
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Color.fromARGB(255, 48, 48, 48), fontWeight: FontWeight.bold, letterSpacing: 0.6),
                      ),
                      onTap: () {}),
                ),
                SizedBox(
                  height: screenHeight * 0.18,
                ),
                ElevatedButton(
                  //__________________________ Login button
                  onPressed: () async {
                    if (loginKey.currentState!.validate()) {
                      await _user.login();
                    }
                  },
                  child: const Text('Log in', style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  //__________________________ havent an account
                  child: const Center(
                    child: Text('Haven\'t an account?', style: TextStyle(color: Color.fromARGB(255, 48, 48, 48), fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  onTap: () {
                    Get.off(() => const SignUp());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle btnStyle = ElevatedButton.styleFrom(
    elevation: 3,
    backgroundColor: const Color.fromARGB(255, 250, 250, 250),
  );
}
