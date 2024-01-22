/* 
Fitxer lib/info_comarca_1.dart
Conté la pantalla de comarca 1.
*/

import 'package:flutter/material.dart';
import 'package:tasca4/data/comarques.dart';

class Infocomarca extends StatefulWidget {
  final int indice_provincia; // añadido navegacion
  final int indice_comarca;

  const Infocomarca(
      {super.key,
      required this.indice_provincia,
      required this.indice_comarca});

  @override
  State<Infocomarca> createState() => _InfoComarcaState();
}

class _InfoComarcaState extends State<Infocomarca> {
  int indexActual = 0; // Añadido barra inferior

  @override
  Widget build(BuildContext context) {
    var comarca = provincies[widget.indice_provincia]["comarques"][widget
        .indice_comarca]; // Lo actualizamos con la comarca que recibe el widget

    return MaterialApp(
      title: 'Info Comarca',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text('${comarca["comarca"]}.General'),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              indexActual = index;
            });
          },
          selectedIndex: indexActual,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.info),
              selectedIcon: Icon(Icons.info_outline),
              label: 'La comarca',
            ),
            NavigationDestination(
              icon: Icon(Icons.sunny),
              selectedIcon: Icon(Icons.wb_sunny_outlined),
              label: 'Informació i oratge',
            ),
          ],
        ),
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
              child: [
            Container(
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
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/soleado.png", scale: 1.5),
                    const SizedBox(height: 10.0), // Separacion
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.thermostat),
                        Text('5 ºC'),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wind_power),
                        Text('20 km/h    '),
                        Text('   Tramuntana'),
                        Icon(Icons.arrow_upward),
                      ],
                    ),
                    const SizedBox(height: 10.0),

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
          ][indexActual]),
        ]),
      ),
    );
  }
}
