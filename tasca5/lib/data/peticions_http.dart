// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert'; // Per realitzar conversions entre tipus de dades
import 'dart:io';
import 'package:http/http.dart' as http; // Per realitzar peticions HTTP
import 'comarca.dart';

// Esta clase hace las peticiones HTTP y crea los objetos necesarios

class PeticionsHttp {
  // Funcion obtención comarcas de peticionHTTP //
  Future<List<dynamic>> obtenirComarques(String provincia) async {
    // Definimos el primer endopoint
    String url1 =
        'https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia';

    // Lanzamos la petición mediante el método http.get:

    try {
      var response = await http.get(Uri.parse(url1));

      //Tratamiento de la respuesta
      if (response.statusCode == 200) {
        // Descodificacion de la respuesta
        String body = utf8.decode(response.bodyBytes);
        //final bodyJSON = jsonDecode(body) as List;

        final List<dynamic> comarcas = jsonDecode(body);

        // Imprimimos solo el nombre de las comarcas

        for (var comarca in comarcas) {
          print('\x1B[36m' +
              comarca['nom'] +
              '\x1B[0m'); // Por la estructura del JSON, el primer campo es el nombre
        }

        //List<Comarca> comarques =
        //    bodyJSON.map((item) => Comarca.fromJSON(item)).toList();
        //print(bodyJSON.toString());
        return comarcas;
      } else {
        //print('Código de estado HTTP: ${response.statusCode}');
        throw Exception('\x1B[31mNo reconec la província\x1B[0m');
      }
    } catch (e) {
      print('Excepción durante la solicitud HTTP: $e');
      return [];
    }
  }

  Future<Comarca> infoComarca(String comarca) async {
    String url2 =
        'https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca';

    try {
      var response = await http.get(Uri.parse(url2));

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> datosComarca = jsonDecode(body);

        // Creamos un objeto Comarca usando el constructor fromJSON
        Comarca comarca = Comarca.fromJSON(datosComarca);

        // Retornamos el objeto comarca creado, el toString lo usaremos en el main
        return comarca;
      }
    } catch (e) {
      print('Excepción durante la solicitud HTTP: $e');
      throw Exception('\x1B[31mNo reconec la comarca\x1B[0m');
    }
    throw Exception('\x1B[31mNo reconec la comarca\x1B[0m');
  }

  // Añadido tasca 5
  // Funcion obtención provincias de peticionHTTP //

  Future<List<dynamic>> obtenirProvincies() async {
    // Definimos el endpoint
    String url3 =
        'https://node-comarques-rest-server-production.up.railway.app/api/comarques';

    try {
      // Peticion

      var response = await http.get(Uri.parse(url3));

      // Tratamiento de respuesta

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);

        final List<dynamic> provincias = jsonDecode(body);

        return provincias;
      } else {
        throw Exception('\x1B[31mError\x1B[0m');
      }
    } catch (e) {
      print('Excepción durante la solicitud HTTP: $e');
      return [];
    }
  }

  // Añadido API tiempo
  Future<dynamic> obteClima(
      {required double longitud, required double latitud}) async {
    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitud&longitude=$longitud&current_weather=true';

    // Llancem una petició GET mitjançant el mètode http.get, i ens esperem a la resposta
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == HttpStatus.ok) {
      // Descodifiquem la resposta
      String body = utf8.decode(response.bodyBytes);
      final result = jsonDecode(body);

      // I la tornem
      return result;
    } else {
      // Si no carrega, llancem una excepció
      throw Exception('No s\'ha pogut connectar');
    }
  }
}
