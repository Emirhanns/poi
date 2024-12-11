import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import './edit_form_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  LatLng _currentLocation = const LatLng(41.685166, 26.573157); // Default: İstanbul
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};
  bool _isSatelliteView = false; // Uydu Görünümü için Switch kontrolü
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Drawer key

  @override
  void initState() {
    super.initState();
    _markers.addAll([
      // İlk marker
      Marker(
        markerId: const MarkerId('marker1'),
        position: const LatLng(41.672738, 26.572685), // İlk konum
        infoWindow: const InfoWindow(title: 'Marker 1', snippet: 'Konum 1'),
        onTap: () => _showBottomMenu(LatLng(41.672738, 26.572685)),
      ),
      // İkinci marker
      Marker(
        markerId: const MarkerId('marker2'),
        position: const LatLng(41.685166, 26.573157), // İkinci konum
        infoWindow: const InfoWindow(title: 'Marker 2', snippet: 'Konum 2'),
        onTap: () => _showBottomMenu(LatLng(41.685166, 26.573157)),
      ),
    ]);
    _getUserLocation(); // Kullanıcı konumunu al
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum servisini kontrol et
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Konum servisleri devre dışı.');
    }

    // Konum izni kontrolü
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Konum izni reddedildi.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Konum izni kalıcı olarak reddedildi.');
    }

    // Kullanıcının mevcut konumunu al
    Position position = await Geolocator.getCurrentPosition();
    LatLng userLocation = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentLocation = userLocation;
      _circles.clear();
      _circles.add(
        Circle(
          circleId: const CircleId('userRadius'),
          center: userLocation,
          radius: 800, // Dairenin yarıçapı (metre cinsinden)
          fillColor: Colors.blue.withOpacity(0.3),
          strokeColor: Colors.blue,
          strokeWidth: 1,
        ),
      );
    });
  }

  bool _isMarkerWithinCircle(LatLng markerPosition) {
    double distance = Geolocator.distanceBetween(
      _currentLocation.latitude,
      _currentLocation.longitude,
      markerPosition.latitude,
      markerPosition.longitude,
    );
    print('Marker pozisyonu: $markerPosition, Kullanıcı pozisyonu: $_currentLocation, Mesafe: $distance');
    return distance <= 800; // Marker, çemberin içinde mi?
  }

  // Modal Bottom Sheet
  void _showBottomMenu(LatLng markerPosition) {
    bool isWithinCircle = _isMarkerWithinCircle(markerPosition);
    print('Marker çember içinde mi? $isWithinCircle'); // Debug için sonucu kontrol et

    // Show the bottom sheet
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
                    onPressed: isWithinCircle
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EditFormScreen()),
                            );
                          }
                        : null, // Çember dışındaysa buton devre dışı
                    icon: const Icon(Icons.edit),
                    label: const Text('Düzenle'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isWithinCircle
                          ? Colors.blue // Çember içindeyse mavi
                          : Colors.grey, // Çember dışındaysa gri
                    ),
                  ),
                ],
              ),
              if (!isWithinCircle)
                const Text(
                  'Bu marker, mavi çemberin dışında.',
                  style: TextStyle(color: Colors.red),
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'POI',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              height: 100,
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
            const Divider(),
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
            mapType: _isSatelliteView ? MapType.satellite : MapType.normal,
            myLocationEnabled: true, // Kullanıcıyı mavi nokta olarak göster
            onMapCreated: (GoogleMapController controller) {},
            initialCameraPosition: CameraPosition(
              target: _currentLocation,
              zoom: 15.0,
            ),
            markers: _markers,
            circles: _circles,
            onTap: (LatLng position) {
              // Marker'lara tıkladığında, marker'ı ve mesafeyi kontrol et
              _showBottomMenu(position);
            },
          ),
        ],
      ),
    );
  }
}
