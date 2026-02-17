import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detalle_screen.dart';
import 'screens/formulario_screen.dart';
import 'models/orden_model.dart';
import 'screens/main_container.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    // CAMBIO IMPORTANTE: La ruta /home ahora carga el CONTENEDOR PRINCIPAL
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final idTecnico = state.extra as int? ?? 0;
        return MainContainer(idTecnico: idTecnico); // Usamos MainContainer
      },
    ),
    GoRoute(
      path: '/detalle',
      builder: (context, state) {
        final orden = state.extra as OrdenTrabajo;
        return DetalleScreen(orden: orden);
      },
    ),
    GoRoute(
      path: '/formulario',
      builder: (context, state) {
        final orden = state.extra as OrdenTrabajo;
        return FormularioScreen(orden: orden);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Opticcom App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF9800)),
      ),
    );
  }
}
