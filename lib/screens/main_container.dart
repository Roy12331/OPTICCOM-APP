import 'package:flutter/material.dart';
import 'home_screen.dart';
<<<<<<< HEAD
import 'perfil_screen.dart';

class MainContainer extends StatefulWidget {
  final Map<String, dynamic> userData;
  const MainContainer({super.key, required this.userData});
=======
import 'historial_screen.dart'; // Ya lo crearemos
import 'perfil_screen.dart'; // Ya lo crearemos

class MainContainer extends StatefulWidget {
  final int idTecnico;
  const MainContainer({super.key, required this.idTecnico});
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 0;
<<<<<<< HEAD
=======

  // Lista de pantallas
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
<<<<<<< HEAD
      HomeScreen(userData: widget.userData),
      const Center(child: Text("Configuración en desarrollo")),
      PerfilScreen(userData: widget.userData),
=======
      HomeScreen(idTecnico: widget.idTecnico), // Índice 0: Trabajos Pendientes
      HistorialScreen(
        idTecnico: widget.idTecnico,
      ), // Índice 1: Historial Finalizados
      PerfilScreen(idTecnico: widget.idTecnico), // Índice 2: Perfil y Logout
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 15,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Configuración',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
=======
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
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
