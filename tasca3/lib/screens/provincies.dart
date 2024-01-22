/* 
Fitxer lib/provincies.dart
Conté la pantalla de selecció de provincia.
*/

import 'package:flutter/material.dart';
import 'package:tasca3/data/comarques.dart';

class Provincies extends StatefulWidget {
  const Provincies({super.key});

  @override
  State<Provincies> createState() => _ProvinciesState();
}

class _ProvinciesState extends State<Provincies> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provincies',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Selector de provincies'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/bg.webp"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 100.0,
                      backgroundImage: NetworkImage(provincies[0]["img"]),
                      child: Text(provincies[0]["provincia"],
                          style: const TextStyle(
                              fontFamily: 'Leckerli One',
                              fontSize: 40,
                              color: Colors.white))),
                  CircleAvatar(
                      radius: 100.0,
                      backgroundImage: NetworkImage(provincies[1]["img"]),
                      child: Text(provincies[1]["provincia"],
                          style: const TextStyle(
                              fontFamily: 'Leckerli One',
                              fontSize: 40,
                              color: Colors.white))),
                  CircleAvatar(
                      radius: 100.0,
                      backgroundImage: NetworkImage(provincies[2]["img"]),
                      child: Text(provincies[2]["provincia"],
                          style: const TextStyle(
                              fontFamily: 'Leckerli One',
                              fontSize: 40,
                              color: Colors.white))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
