import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Account extends StatefulWidget {
  final String email;
  const Account(this.email,[Key? key]) : super(key: key);
  @override
  State<Account> createState() => _AccountState();
}
class _AccountState extends State<Account> {
  GlobalKey<FormState> accounrKey = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwd = TextEditingController();  
  @override
  void initState() {
    email.text = widget.email;
    super.initState();
  }
  bool hidePasswd = true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
  double verMargin = 12;
    return
      Form(
        key: accounrKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Update Account'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: (() { Get.back(); }
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 20,),
                TextFormField(//________Email
                  enabled: false,
                  initialValue: email.text,
                  decoration:  const InputDecoration(
                    hintText: 'Email',
                    prefixIcon:  Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(height: verMargin,),
                TextFormField(// ______User name
                  controller: userName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                  decoration: const InputDecoration(
                    hintText: 'User name',
                    prefixIcon: Icon(Icons.account_circle_outlined),
                  ),
                ),
                SizedBox(height: verMargin,),
                TextFormField(
                  controller: passwd,
                  validator: (value) => value == null || value.isEmpty ? 'Required field' : null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: hidePasswd,
                  decoration:  InputDecoration(
                    label: const Text('Password'),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(icon:  Icon( hidePasswd ? Icons.visibility : Icons.visibility_off, color: const Color.fromARGB(131, 0, 0, 0)), 
                    onPressed: () {
                      setState(() {
                        hidePasswd = !hidePasswd;
                      });
                    },),
                  ),
                ),
                SizedBox(height: verMargin,),
                ElevatedButton(onPressed: (){}, child: const Text('Save', style: TextStyle(color: Colors.black))),
                SizedBox(height: verMargin,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: (){}, 
                  child: const Text('Cancel', style: TextStyle(color: Colors.black)))
            ],),
          ),
      ),
    ); 
  }
}