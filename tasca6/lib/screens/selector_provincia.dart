import 'package:flutter/material.dart';
import 'package:tasca4/bloc/comarques_bloc.dart';
import 'package:tasca4/screens/selector_comarca.dart';

class SelectorProvincia extends StatelessWidget {
  SelectorProvincia({super.key});

  final ComarquesBloc comarquesBloc = ComarquesBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: comarquesBloc.obtenirProvinciesStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
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

// Añadido para compartimentar la creación de botones provincia
class ProvinciaRoundButton extends StatelessWidget {
  final String nom;
  final String img;

  const ProvinciaRoundButton({super.key, required this.nom, required this.img});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectorComarca(provincia: nom)));
      }),
      child: CircleAvatar(
          radius: 100.0,
          backgroundImage: NetworkImage(img),
          child: Text(nom,
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
    llista.add(
        ProvinciaRoundButton(nom: data[i]["provincia"], img: data[i]["img"]));
    llista.add(const SizedBox(height: 20));
  }
  return llista;
}
