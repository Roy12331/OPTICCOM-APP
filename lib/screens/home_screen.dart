import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/orden_model.dart';
import '../services/orden_service.dart'; // 🔹 Importación del nuevo servicio

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const HomeScreen({super.key, required this.userData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<OrdenTrabajo>> _futureOrdenes;

  @override
  void initState() {
    super.initState();
    _recargar();
  }

  void _recargar() {
    setState(() {
      // 🔹 Llamada al nuevo servicio separado
      _futureOrdenes = OrdenService.getOrdenes(widget.userData['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hola, ${widget.userData['nombre']}"),
          actions: [
            IconButton(
              onPressed: _recargar,
              icon: const Icon(Icons.notifications_none),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[600],
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: "Pendientes"),
                    Tab(text: "Finalizadas"),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 20, top: 15, bottom: 5),
              child: Text(
                "Tareas",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: FutureBuilder<List<OrdenTrabajo>>(
                future: _futureOrdenes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "No tienes tareas asignadas",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  final ordenes = snapshot.data!;
                  final pendientes = ordenes
                      .where((o) => o.estado != 'Finalizado')
                      .toList();
                  final finalizadas = ordenes
                      .where((o) => o.estado == 'Finalizado')
                      .toList();

                  return TabBarView(
                    children: [
                      _listaOrdenes(pendientes),
                      _listaOrdenes(finalizadas),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listaOrdenes(List<OrdenTrabajo> lista) {
    if (lista.isEmpty) {
      return const Center(
        child: Text("Vacío", style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: lista.length,
      itemBuilder: (context, index) {
        final orden = lista[index];
        bool esAveria = orden.tipoTrabajo.toLowerCase().contains("averia");

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
              vertical: 5,
            ),
            leading: Icon(
              esAveria
                  ? Icons.warning_amber_rounded
                  : Icons.build_circle_outlined,
              color: esAveria ? Colors.amber : Colors.grey,
              size: 35,
            ),
            title: Text(
              "${orden.tipoTrabajo} - ${orden.distrito}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                "Cliente: ${orden.cliente}",
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey,
            ),
            onTap: () => context.push('/detalle', extra: orden),
          ),
        );
      },
    );
  }
}
