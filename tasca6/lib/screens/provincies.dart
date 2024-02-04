/* 
Fitxer lib/provincies.dart
Conté la pantalla de selecció de provincia.
*/

import 'package:flutter/material.dart';
//import 'package:tasca4/data/comarques.dart';
import 'package:tasca4/screens/comarques.dart';
import 'package:tasca4/data/peticions_http.dart';

class Provincies extends StatefulWidget {
  const Provincies({super.key});

  @override
  State<Provincies> createState() => _ProvinciesState();
}

// Añadido para compartimentar la creación de botones provincia
class ProvinciaRoundButton extends StatelessWidget {
  final String nom;
  final String img;
  final int indice;

  ProvinciaRoundButton(
      {required this.nom, required this.img, required this.indice});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Comarques(indice_provincia: indice, provincia: nom)));
      }),
      child: CircleAvatar(
          radius: 100.0,
          backgroundImage: NetworkImage(this.img),
          child: Text(this.nom,
              style: const TextStyle(
                  fontFamily: 'Leckerli One',
                  fontSize: 40,
                  color: Colors.white))),
    );
  }
}

List<Widget> _creaLlistaProvincies(List<dynamic> data) {
  List<Widget> llista = [];
  for (int i = 0; i < data.length; i++) {
    llista.add(ProvinciaRoundButton(
        nom: data[i]["provincia"], img: data[i]["img"], indice: i));
    llista.add(SizedBox(height: 20));
  }
  return llista;
}

class _ProvinciesState extends State<Provincies> {
  PeticionsHttp peticionsHttp =
      PeticionsHttp(); // Instancia al método de acceso

  @override
  Widget build(BuildContext context) {
    // Añadido futurebuilder

    return FutureBuilder<List<dynamic>>(
        future: peticionsHttp.obtenirProvincies(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            List<Widget> llistaProvincies =
                _creaLlistaProvincies(snapshot.data!);

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
                      child: Column(children: llistaProvincies),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator(); // Barra de progreso para los tres a la vez
          }
        });
  }
}
