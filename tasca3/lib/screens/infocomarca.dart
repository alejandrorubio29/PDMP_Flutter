/* 
Fitxer lib/info_comarca_1.dart
Conté la pantalla de comarca 1.
*/

import 'package:flutter/material.dart';
import 'package:tasca3/data/comarques.dart';

class Infocomarca extends StatefulWidget {
  const Infocomarca({super.key});

  @override
  State<Infocomarca> createState() => _LoginState();
}

class _LoginState extends State<Infocomarca> {
  @override
  Widget build(BuildContext context) {
    var comarca =
        provincies[0]["comarques"][0]; // Por ahora mostramos la primera comarca

    return MaterialApp(
      title: 'Info Comarca',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/bg.webp"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.8),
            padding: const EdgeInsets.all(15.0),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(comarca["img"]),
                    Text(
                      comarca["comarca"],
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 10.0), // Separacion
                    Text(
                      'Capital: ${comarca["capital"]}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      comarca["desc"],
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10.0),
                    Text('Poblacio: ${comarca["poblacio"]}'),
                    const SizedBox(height: 10.0),
                    Text('Latitud: ${comarca["latitud"]}'),
                    const SizedBox(height: 10.0),
                    Text('Longitud: ${comarca["longitud"]}'),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
