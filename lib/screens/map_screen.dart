
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './edit_form_screen.dart';
import '../routes.dart';  // AppRoutes dosyasını import edin

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
      initialRoute: '/', // Başlangıçta LoginScreen'i göster
      routes: AppRoutes.getRoutes(),  // Burada AppRoutes.getRoutes() fonksiyonunu kullanıyoruz
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final LatLng _center =
      const LatLng(41.0082, 28.9784); // İstanbul Koordinatları

  final Set<Marker> _markers = {};

  bool _isSatelliteView = false; // Uydu Görünümü için Switch kontrolü
  final String remainingFiles =
      "5"; // Kalan dosya sayısı (örnek olarak 5 yazıldı)

  // Drawer key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId('marker1'),
        position: const LatLng(41.0082, 28.9784),
        infoWindow:
            const InfoWindow(title: 'Watsons', snippet: 'Ferit Selimpaşa Cd.'),
        onTap: _showBottomMenu,
      ),
    );
  }

  // Modal Bottom Sheet
  void _showBottomMenu() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Düzenleme sayfasına gitme işlemi
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditFormScreen()),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Düzenle'),
                  ),
                
                 
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  // Scaffold key'i ekledik
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerRight, // Yazıyı sağa hizaladık
          child: Text(
            'POI',
            style: TextStyle(
              color: Colors.black, // Yazının rengini siyah yaptık
            ),
          ),
        ),
        backgroundColor: Colors.white, // AppBar arka planını beyaz yapıyoruz
        toolbarHeight: 50, // AppBar'ın yüksekliğini ayarlıyoruz
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black), // Menü butonu
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Menü açma
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // DrawerHeader yerine Container kullandık
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              height: 100, // DrawerHeader'ın yüksekliğini buradan ayarlıyoruz
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hoşgeldiniz Sn. XXX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Uydu Görünümü'),
              trailing: Switch(
                value: _isSatelliteView,
                onChanged: (value) {
                  setState(() {
                    _isSatelliteView = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.file_copy),
              title: const Text('Kalan Dosya Sayısı'),
              subtitle: Text(remainingFiles.toString()),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Verileri Yenile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.upload_file),
              title: const Text('Kalan Verileri Gönder'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Fotoğrafları Tekrar Gönder'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Çıkış'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {},
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            markers: _markers,
          ),
        ],
      ),
    );
  }
}
