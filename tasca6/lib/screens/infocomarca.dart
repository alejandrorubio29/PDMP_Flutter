/* 
Fitxer lib/info_comarca_1.dart
Conté la pantalla de comarca 1.
*/

import 'package:flutter/material.dart';
import 'package:tasca4/bloc/comarques_bloc.dart';
import 'package:tasca4/model/comarca.dart';
import 'package:tasca4/data/comarques.dart';
import 'package:tasca4/data/peticions_http.dart';

import '../bloc/oratge_gloc.dart';
import '../model/info_oratge.dart';

PeticionsHttp peticionsHttp = PeticionsHttp(); // Instancia al método de acceso

class Infocomarca extends StatefulWidget {
  final String comarca;

  /*final int indice_provincia; // añadido navegacion
  final int indice_comarca;*/

  Infocomarca({super.key, required this.comarca});

  @override
  State<Infocomarca> createState() => _InfoComarcaState();
}

class _InfoComarcaState extends State<Infocomarca> {
  int indexActual = 0; // Añadido barra inferior
  late Future<dynamic> info;

  @override
  Widget build(BuildContext context) {
    /*var comarca = provincies[widget.indice_provincia]["comarques"][widget
        .indice_comarca]; // Lo actualizamos con la comarca que recibe el widget*/
    //var comarquesBloc;

    //comarquesBloc.nomComarcaActual = widget.comarca;

    // Añaddido Bloc
    final ComarquesBloc comarquesBloc = ComarquesBloc();
    final OratgeBloc oratgeBloc = OratgeBloc();

    comarquesBloc.nomComarcaActual = widget.comarca;
    oratgeBloc.actualitzaOratge();

    // Añadido futurebuilder
    return StreamBuilder(
        stream: comarquesBloc.obtenirComarcaStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var comarca = snapshot.data;
            var clima = peticionsHttp.obteClima(
                longitud: comarca!.longitud!, latitud: comarca!.latitud!);

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
                      Text('${comarca.comarca}.General'),
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
                            Image.network(comarca.img!),
                            Text(
                              comarca.comarca,
                              style: const TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 10.0), // Separacion
                            Text(
                              'Capital: ${comarca.capital!}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              comarca.desc!,
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
                            FutureBuilder<dynamic>(
                              future: clima,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  return WidgetClima(
                                    latitud: comarca.latitud,
                                    longitud: comarca.longitud,
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                            const SizedBox(height: 10.0),
                            Text('Poblacio: ${comarca.poblacio}'), // Datos API
                            const SizedBox(height: 10.0),
                            Text('Latitud: ${comarca.latitud}'), // Datos API
                            const SizedBox(height: 10.0),
                            Text('Longitud: ${comarca.longitud}'), // Datos API
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ][indexActual]),
                ]),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

// Añadido API tiempo

class WidgetClima extends StatefulWidget {
  const WidgetClima({
    required this.latitud,
    required this.longitud,
    super.key,
  });

  final double? latitud;
  final double? longitud;

  @override
  State<WidgetClima> createState() => _WidgetClimaState();
}

class _WidgetClimaState extends State<WidgetClima> {
  late Future<dynamic> info;

  @override
  void initState() {
    super.initState();
    info = peticionsHttp.obteClima(
        longitud: widget.longitud ?? 0.0, latitud: widget.latitud ?? 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: info,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // Una vegada es resol el Future, tindrem disponible
          // la informació necessària per construir el giny

          // Obtenim en primer lloc la informació de l'snapshot

          String temperatura =
              snapshot.data["current_weather"]["temperature"].toString();
          String velVent =
              snapshot.data["current_weather"]["windspeed"].toString();
          String direccioVent =
              snapshot.data["current_weather"]["winddirection"].toString();
          String codi =
              snapshot.data["current_weather"]["weathercode"].toString();

          // I ara creem el giny

          return Column(
            children: [
              _obtenirIconaOratge(codi),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.thermostat,
                    size: 35,
                  ),
                  Text(
                    "$temperaturaº",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wind_power, size: 35),
                  const SizedBox(width: 30),
                  Text(
                    "${velVent}km/h",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 30),
                  _obteGinyDireccioVent(direccioVent.toString()),
                ],
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _obtenirIconaOratge(String value) {
    Set<String> sol = <String>{"0"};
    Set<String> pocsNuvols = <String>{"1", "2", "3"};
    Set<String> nuvols = <String>{"45", "48"};
    Set<String> plujasuau = <String>{"51", "53", "55"};
    Set<String> pluja = <String>{
      "61",
      "63",
      "65",
      "66",
      "67",
      "80",
      "81",
      "82",
      "95",
      "96",
      "99"
    };
    Set<String> neu = <String>{"71", "73", "75", "77", "85", "86"};

    if (sol.contains(value)) {
      return Image.asset("assets/icons/soleado.png");
    }
    if (pocsNuvols.contains(value)) {
      return Image.asset("assets/icons/poco_nublado.png");
    }
    if (nuvols.contains(value)) {
      return Image.asset("assets/icons/nublado.png");
    }
    if (plujasuau.contains(value)) {
      return Image.asset("assets/icons/lluvia_debil.png");
    }
    if (pluja.contains(value)) {
      return Image.asset("assets/icons/lluvia.png");
    }
    if (neu.contains(value)) {
      return Image.asset("assets/icons/nieve.png");
    }

    return Image.asset("assets/icons/poco_nublado.png");
  }
}

Widget _obteGinyDireccioVent(String direccioVent) {
  // Aquesta funció ens retorna una giny que conté
  // una icona i un text, amb la direcció i el nom del vent
  // segons la seua direcció.
  // Fem ús de `late` per indicar que assignarem el valor després
  // a les variables.

  double dir = double.parse(direccioVent);
  late Icon icona;
  late String nomVent;

  if (dir > 22.5 && dir < 65.5) {
    icona = const Icon(Icons.north_east);
    nomVent = "Gregal";
  } else if (dir > 67.5 && dir < 112.5) {
    icona = const Icon(Icons.east);
    nomVent = "Llevant";
  } else if (dir > 112.5 && dir < 157.5) {
    icona = const Icon(Icons.south_east);
    nomVent = "Xaloc";
  } else if (dir > 157.5 && dir < 202.5) {
    icona = const Icon(Icons.south);
    nomVent = "Migjorn";
  } else if (dir > 202.5 && dir < 247.5) {
    icona = const Icon(Icons.south_west);
    nomVent = "Llebeig/Garbí";
  } else if (dir > 247.5 && dir < 292.5) {
    icona = const Icon(Icons.west);
    nomVent = "Ponent";
  } else if (dir > 292.5 && dir < 337.5) {
    icona = const Icon(Icons.north_west);
    nomVent = "Mestral";
  } else {
    icona = const Icon(Icons.north);
    nomVent = "Tramuntana";
  }
  return Row(children: [
    Text(nomVent),
    icona,
  ]);
}
