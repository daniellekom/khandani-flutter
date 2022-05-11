import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen ({ Key? key }) : super(key: key);

  @override
  State<SecondScreen> createState() => _State();
}

class _State extends State<SecondScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('second screen'),
        backgroundColor: const Color.fromARGB(255, 46, 108, 159),
      ),
      body: TextField(
        controller: controller,
      ),
    );
    
  }
}