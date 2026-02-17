import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'historial_screen.dart'; // Ya lo crearemos
import 'perfil_screen.dart'; // Ya lo crearemos

class MainContainer extends StatefulWidget {
  final int idTecnico;
  const MainContainer({super.key, required this.idTecnico});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 0;

  // Lista de pantallas
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(idTecnico: widget.idTecnico), // Índice 0: Trabajos Pendientes
      HistorialScreen(
        idTecnico: widget.idTecnico,
      ), // Índice 1: Historial Finalizados
      PerfilScreen(idTecnico: widget.idTecnico), // Índice 2: Perfil y Logout
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Muestra la pantalla seleccionada
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work, color: Color(0xFFFF9800)),
            label: 'Pendientes',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            selectedIcon: Icon(Icons.history, color: Color(0xFFFF9800)),
            label: 'Historial',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Color(0xFFFF9800)),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
