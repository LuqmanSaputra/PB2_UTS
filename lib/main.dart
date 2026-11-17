import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Root Widget aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Makanan - UTS',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const HomeScreen(),
    );
  }
}

/// Halaman Utama
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variabel state untuk pencarian dan filter kategori
  String searchText = '';
  String selectedCategory = 'Semua';

  // Daftar kategori
  final List<String> categories = [
    'Semua',
    'Kopi',
    'Minuman',
    'Makanan',
    'Snack',
  ];

  // Data daftar menu
  final List<Map<String, dynamic>> menuList = [
    {
      'name': 'Es Kopi Susu',
      'category': 'Kopi',
      'price': 'Rp 18.000',
      'isFavorite': false,
    },
    {
      'name': 'Americano Dingin',
      'category': 'Kopi',
      'price': 'Rp 15.000',
      'isFavorite': false,
    },
    {
      'name': 'Matcha Latte',
      'category': 'Minuman',
      'price': 'Rp 20.000',
      'isFavorite': true,
    },
    {
      'name': 'Es Cokelat',
      'category': 'Minuman',
      'price': 'Rp 18.000',
      'isFavorite': false,
    },
    {
      'name': 'Nasi Goreng Spesial',
      'category': 'Makanan',
      'price': 'Rp 25.000',
      'isFavorite': true,
    },
    {
      'name': 'Mie Goreng Telur',
      'category': 'Makanan',
      'price': 'Rp 20.000',
      'isFavorite': false,
    },
    {
      'name': 'Kentang Goreng',
      'category': 'Snack',
      'price': 'Rp 15.000',
      'isFavorite': false,
    },
    {
      'name': 'Roti Bakar Cokelat',
      'category': 'Snack',
      'price': 'Rp 16.000',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter data berdasarkan kategori dan pencarian
    final filteredMenu = menuList.where((item) {
      final matchCategory =
          selectedCategory == 'Semua' || item['category'] == selectedCategory;
      final matchSearch = item['name']
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();

    return Scaffold(
      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        title: const Text(
          'Kantin & Kopi Kampus',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.brown[400],
                borderRadius: BorderRadius.circular(10),
              ),
               child: const Stack(
                children: [
                  Positioned(
                    right: 12,
                    bottom: 10,
                    child: Icon(
                      Icons.fastfood,
                      size: 70,
                      color: Colors.white24,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Promo Makan Siang!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Diskon Rp 5.000 untuk semua menu kopi & makanan.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Kolom Pencarian
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Cari menu makanan atau minuman...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Filter Kategori
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      selectedColor: Colors.brown[600],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Judul daftar menu
            Text(
              'Daftar Menu (${filteredMenu.length})',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Daftar Menu
            Expanded(
              child: GridView.builder(
                itemCount: filteredMenu.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final item = filteredMenu[index];

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kotak gambar
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: buildNoImageBox(),
                              ),
                              // Tombol Favorite
                              Positioned(
                                top: 6,
                                right: 6,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      item['isFavorite'] = !item['isFavorite'];
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      item['isFavorite']
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: item['isFavorite']
                                          ? Colors.red
                                          : Colors.grey,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Teks Nama, Kategori, dan Harga
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item['category'],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['price'],
                                style: TextStyle(
                                  color: Colors.brown[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget placeholder
  Widget buildNoImageBox() {
    return Container(
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey,
            size: 32,
          ),
          SizedBox(height: 4),
          Text(
            'No Image',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}