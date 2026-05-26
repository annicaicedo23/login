import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = 'anny'; // Valor por defecto si no encuentra nada

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Intenta leer 'user_name', si no existe usa 'anny' como en tu captura
      _userName = prefs.getString('user_name') ?? 'anny';
    });
  }

  // Ventana emergente de confirmación para cerrar sesión
  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E2640),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          title: const Text(
            '¿Cerrar sesión?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: const Text(
            'Se cerrará tu sesión actual.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          actionsPadding: const EdgeInsets.only(bottom: 24, right: 24, left: 24),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    context.go('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B6BBF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Cerrar sesión',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extendemos el cuerpo detrás del AppBar para que el fondo de nubes cubra toda la pantalla
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF0A559B)), // Icono a juego con el diseño
            onPressed: _showLogoutDialog,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // Degradado suave simulando el cielo azul claro
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF9AD2FA), 
              Color(0xFFCBE6FF),
            ],
          ),
        ),
        child: Stack(
          children: [
            // --- Círculos decorativos que simulan las NUBES de fondo ---
            Positioned(
              bottom: -50,
              left: -60,
              child: CircleAvatar(radius: 130, backgroundColor: Colors.white.withOpacity(0.4)),
            ),
            Positioned(
              bottom: -20,
              right: -80,
              child: CircleAvatar(radius: 150, backgroundColor: Colors.white.withOpacity(0.5)),
            ),
            Positioned(
              bottom: 40,
              left: -90,
              child: CircleAvatar(radius: 110, backgroundColor: Colors.white.withOpacity(0.3)),
            ),
            Positioned(
              bottom: 90,
              right: -40,
              child: CircleAvatar(radius: 100, backgroundColor: Colors.white.withOpacity(0.3)),
            ),
            Positioned(
              top: 120,
              left: -80,
              child: CircleAvatar(radius: 90, backgroundColor: Colors.white.withOpacity(0.25)),
            ),

            // --- Contenido Principal (Perfil y Textos) ---
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Círculo exterior del perfil (Azul claro de la captura)
                    Container(
                      width: 140,
                      height: 140,
                      decoration: const BoxDecoration(
                        color: Color(0xFFBDDFFF), 
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 90,
                        color: Color(0xFF0A559B), 
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Texto de Bienvenida
                    Text(
                      '¡Bienvenido/a, $_userName!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A559B), 
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Correo electrónico secundario
                    const Text(
                      'anny12@gmail.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF708090), 
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}