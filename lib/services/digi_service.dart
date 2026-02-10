import 'package:dio/dio.dart';
import '../utils/dio_client.dart'; // Asegúrate que esta ruta sea correcta
import '../models/digi_model.dart';

class DigiService {
  Future<List<DigiModel>> getDigimons() async {
    try {
      // Usamos la instancia configurada en tu paso 2
      final response = await DioClient.dio.get('/digimon');
      // OJO: Si en dio_client ya pusiste la base url hasta '.../api/v1', aquí solo pones '/digimon'

      if (response.statusCode == 200) {
        // La API devuelve: { "content": [ ...lista... ], "pageable": ... }
        // Necesitamos acceder a la lista que está dentro de "content"
        final List<dynamic> datos = response.data['content'];

        return datos.map((json) => DigiModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error obteniendo Digimons: $e");
      return [];
    }
  }
}
