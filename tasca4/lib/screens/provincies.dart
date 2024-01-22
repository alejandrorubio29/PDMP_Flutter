/* 
Fitxer lib/provincies.dart
Conté la pantalla de selecció de provincia.
*/

import 'package:flutter/material.dart';
import 'package:tasca4/data/comarques.dart';
import 'package:tasca4/screens/comarques.dart';

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
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Comarques(indice_provincia: 0)));
                    }),
                    child: CircleAvatar(
                        radius: 100.0,
                        backgroundImage: NetworkImage(provincies[0]["img"]),
                        child: Text(provincies[0]["provincia"],
                            style: const TextStyle(
                                fontFamily: 'Leckerli One',
                                fontSize: 40,
                                color: Colors.white))),
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Comarques(indice_provincia: 1)));
                    }),
                    child: CircleAvatar(
                        radius: 100.0,
                        backgroundImage: NetworkImage(provincies[1]["img"]),
                        child: Text(provincies[1]["provincia"],
                            style: const TextStyle(
                                fontFamily: 'Leckerli One',
                                fontSize: 40,
                                color: Colors.white))),
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Comarques(indice_provincia: 2)));
                    }),
                    child: CircleAvatar(
                        radius: 100.0,
                        backgroundImage: NetworkImage(provincies[2]["img"]),
                        child: Text(provincies[2]["provincia"],
                            style: const TextStyle(
                                fontFamily: 'Leckerli One',
                                fontSize: 40,
                                color: Colors.white))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
