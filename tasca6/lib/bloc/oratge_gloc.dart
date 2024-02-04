import 'dart:async';

import '../model/comarca.dart';
import '../model/info_oratge.dart';
import '../repository/oratge_repository.dart';

class OratgeBloc {
  static final OratgeBloc _singleton = OratgeBloc._();

  final _oratgeRepository = OratgeRepository();
  Comarca? _comarcaActual;
  InfoOratge? infoOratge;
  final _infoOratgeController = StreamController<InfoOratge>();

  // Implementacion singleton: https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart

  OratgeBloc._();

  factory OratgeBloc() {
    return _singleton;
  }

  // Getter

  Stream<InfoOratge> get obtenirInfoOratgeStream =>
      _infoOratgeController.stream;

  // Setter

  set comarcaActual(Comarca? comarca) {
    if (comarca != _comarcaActual) {
      comarcaActual = comarca;
      carregaOratge(comarca!);
    }
  }

// Procedimiento carregaOratge

  void carregaOratge(Comarca comarca) async {
    infoOratge = await _oratgeRepository.obteClima(
        longitud: comarca.longitud!, latitud: comarca.latitud!);
    _infoOratgeController.sink.add(infoOratge!);
  }

  // Procedimiento actualitzaOratge

  void actualitzaOratge() async {
    await Future.delayed(Duration.zero);
    _infoOratgeController.sink.add(infoOratge!);
  }

  // El desechador del controlador

  void dispose() {
    _infoOratgeController.close();
  }
}
