import 'package:flutter/material.dart';
import '../models/orden_model.dart';
import '../services/historial_service.dart'; // 🔹 Importación del nuevo servicio separado

class HistorialScreen extends StatefulWidget {
  final int idTecnico;
  const HistorialScreen({super.key, required this.idTecnico});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  late Future<List<OrdenTrabajo>> _futureOrdenes;

  @override
  void initState() {
    super.initState();
    // 🔹 Llamada al nuevo servicio exclusivo para historial
    _futureOrdenes = HistorialService.getHistorial(widget.idTecnico);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🔹 Fondo blanco estilo Figma
      appBar: AppBar(
        title: const Text(
          "Historial de Trabajos",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<OrdenTrabajo>>(
        future: _futureOrdenes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // 🔹 Pantalla vacía mejorada
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_toggle_off, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    "No hay trabajos finalizados recientes",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final ordenes = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: ordenes.length,
            itemBuilder: (context, index) {
              final orden = ordenes[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                  title: Text(
                    orden.tipoTrabajo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      "Cliente: ${orden.cliente}\nFinalizado el: ${orden.fecha}",
                      style: TextStyle(color: Colors.grey[600], height: 1.4),
                    ),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
