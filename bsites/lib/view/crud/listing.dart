import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'update_gig_.dart';
class Listing extends StatefulWidget {
final String email;
  const Listing(this.email,[Key? key]) : super(key: key);
  @override
  State<Listing> createState() => _ListingState();
}
class _ListingState extends State<Listing> {
  String email = '';
  final GlobalKey<ScaffoldState> scaffoldFav = GlobalKey<ScaffoldState>();
  int isPressed = 0;
@override
  void initState() {
    email = widget.email;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold
    (
      key: scaffoldFav,
      appBar: AppBar
      (
        title: const Text('My listings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: (() {
            Get.back();
          }
        ),
        ),
      ),
      );
  }
}
