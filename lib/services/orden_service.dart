import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/orden_model.dart';

class OrdenService {
  static const String baseUrl = 'https://opticcomperu.com/api';

  static Future<List<OrdenTrabajo>> getOrdenes(int idTecnico) async {
    final response = await http.get(
      Uri.parse('$baseUrl/get_mis_ordenes.php?id_tecnico=$idTecnico'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        List data = jsonResponse['data'];
        return data.map((e) => OrdenTrabajo.fromJson(e)).toList();
      }
    }
    return [];
  }
}
