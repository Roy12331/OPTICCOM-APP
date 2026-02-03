import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificacionesPage extends StatefulWidget {
  const NotificacionesPage({super.key});

  @override
  State<NotificacionesPage> createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  final List<Map<String, String>> ordenes = [
    {
      "id": "#8821",
      "cliente": "Junior Jhunior",
      "tipo": "NUEVA INSTALACIÓN",
      "ubic": "Calle Real 123",
      "prioridad": "ALTA",
    },
    {
      "id": "#8822",
      "cliente": "Empresa SAC",
      "tipo": "AVERIA",
      "ubic": "Av. Huancavelica 456",
      "prioridad": "NORMAL",
    },
    {
      "id": "#8823",
      "cliente": "Luis Perez",
      "tipo": "AVERIA",
      "ubic": "Jr. Aguirre Morales 123",
      "prioridad": "NORMAL",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          "Órdenes de Trabajo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Lista de Pendientes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ordenes.length,
              itemBuilder: (context, index) {
                final item = ordenes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 4,
                      decoration: BoxDecoration(
                        color: item['tipo'] == 'AVERIA'
                            ? Colors.red
                            : Colors.green,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    title: Text(
                      item['tipo']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: item['tipo'] == 'AVERIA'
                            ? Colors.red[800]
                            : Colors.green[800],
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          "ID Orden: ${item['id']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Cliente: ${item['cliente']}"),
                        Text(
                          "Dirección: ${item['ubic']}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => context.push("/formulario"), // CONEXIÓN AQUÍ
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => index == 1 ? context.push('/historial') : null,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Órdenes'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
