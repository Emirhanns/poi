import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import './screens/login_screen.dart';
import './screens/edit_form_screen.dart';
import './screens/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POI Harita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Başlangıç sayfası
      routes: {
        '/': (context) => const LocationPermissionScreen(), // Konum izin kontrolü
        '/map': (context) => const MapScreen(), // Harita ekranı
        '/edit': (context) => const EditFormScreen(), // Düzenleme ekranı
      },
    );
  }
}

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  _LocationPermissionScreenState createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    // Konum Servisinin Aktif Olup Olmadığını Kontrol Et
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        _closeApp(); // Kullanıcı servis açmazsa uygulamayı kapat
        return;
      }
    }

    // Konum İzinlerini Kontrol Et
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _closeApp(); // Kullanıcı izin vermezse uygulamayı kapat
        return;
      }
    }

    // Eğer konum erişimi ve servis aktifleştirilmişse devam et
    _navigateToNextScreen();
  }

  void _closeApp() {
    // Uygulamayı kapat
    Future.delayed(const Duration(milliseconds: 500), () {
      SystemNavigator.pop();
    });
  }

  void _navigateToNextScreen() {
    // İzinler tamamsa giriş ekranına git
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Konum ayarları kontrol ediliyor...'),
          ],
        ),
      ),
    );
  }
}
