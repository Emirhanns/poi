import 'package:flutter/material.dart';

class EditFormScreen extends StatefulWidget {
  const EditFormScreen({super.key});

  @override
  EditFormScreenState createState() => EditFormScreenState();
}

class EditFormScreenState extends State<EditFormScreen> {
  String? _selectedDistrict;
  String? _selectedNeighborhood;
  String? gender;
  final TextEditingController _caddeController = TextEditingController();
  final TextEditingController _dkn1Controller = TextEditingController();
  final TextEditingController _dkn2Controller = TextEditingController();
  final TextEditingController _blokController = TextEditingController();
  final TextEditingController _mekanAdController = TextEditingController();
  final TextEditingController _subeAdController = TextEditingController();

  List<String> districts = ['İstanbul', 'Ankara', 'İzmir'];
  List<String> neighborhoods = ['Mahalle 1', 'Mahalle 2', 'Mahalle 3'];

  int erkekSayisi = 0;
  int kadinSayisi = 0;

  void _incrementErkek() {
    setState(() {
      erkekSayisi++;
    });
  }

  void _incrementKadin() {
    setState(() {
      kadinSayisi++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Gönder işlemi
                    },
                    child: const Text('Gönder'),
                  ),
                  const Text(
                    "POI ID: XYZ12345",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Vazgeçme işlemi
                      Navigator.pop(context);
                    },
                    child: const Text('Vazgeç'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // İlçe Dropdown
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                decoration: const InputDecoration(
                  labelText: 'İlçe',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                items: districts
                    .map((district) => DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDistrict = value;
                  });
                },
              ),
              const SizedBox(height: 6),

              // Mahalle Dropdown
              DropdownButtonFormField<String>(
                value: _selectedNeighborhood,
                decoration: const InputDecoration(
                  labelText: 'Mahalle',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                items: neighborhoods
                    .map((neighborhood) => DropdownMenuItem<String>(
                          value: neighborhood,
                          child: Text(neighborhood),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedNeighborhood = value;
                  });
                },
              ),
              const SizedBox(height: 6),

              // Cadde-Sokak Input
              TextFormField(
                controller: _caddeController,
                decoration: const InputDecoration(
                  labelText: 'Cadde - Sokak',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 6),

              // Dkn-1 Input
              TextFormField(
                controller: _dkn1Controller,
                decoration: const InputDecoration(
                  labelText: 'Dkn-1',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 6),

              // Dkn-2 Input
              TextFormField(
                controller: _dkn2Controller,
                decoration: const InputDecoration(
                  labelText: 'Dkn-2',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 6),

              // Blok Input
              TextFormField(
                controller: _blokController,
                decoration: const InputDecoration(
                  labelText: 'Blok',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 6),

              // Mekan Ad Input
              TextFormField(
                controller: _mekanAdController,
                decoration: const InputDecoration(
                  labelText: 'Mekan Ad',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 6),

              // Şube Ad Input
              TextFormField(
                controller: _subeAdController,
                decoration: const InputDecoration(
                  labelText: 'Şube Ad',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 10),

              // Fotoğraf ve Video çekme butonları
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Fotoğraf çekme işlemi
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Fotoğraf Çek'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Video çekme işlemi
                    },
                    icon: const Icon(Icons.videocam),
                    label: const Text('Video Çek'),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Erkek - Kadın butonları
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _incrementErkek,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 30),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Erkek',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _incrementKadin,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 30),
                      backgroundColor: Colors.pink,
                    ),
                    child: const Text(
                      'Kadın',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              // Sayaçlar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sayılan Erkek: $erkekSayisi', style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 20),
                  Text('Sayılan Kadın: $kadinSayisi', style: const TextStyle(fontSize: 16)),
                 
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}