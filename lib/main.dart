
import 'package:flutter/material.dart';

import 'loginpage.dart';

void main () {

  runApp( home());

}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginpage(),
    );
  }
}
