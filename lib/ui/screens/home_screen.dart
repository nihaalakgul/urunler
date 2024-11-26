import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler_app/data/entity/urunler.dart';
import 'package:urunler_app/ui/cubit/home_screen_cubit.dart';
import 'package:urunler_app/ui/screens/cart_screen.dart';
import 'package:urunler_app/ui/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;

  Urunler urun = Urunler(
      id: "0",
      ad: "ürün",
      resim: "default_image.png",
      kategori: "teknolojik",
      marka: "apple",
      fiyat: "10");

  @override
  void initState() {
    super.initState();
    context.read<HomeScreenCubit>().getAllurun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 255, 248, 253), // Arka plan siyah
      appBar: AppBar(
        title: isSearching
            ? TextField(
                decoration: const InputDecoration(hintText: "Search"),
                onChanged: (searchingResult) {
                  context.read<HomeScreenCubit>().searchUrun(searchingResult);
                },
              )
            : const Text(""),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                  },
                  icon: const Icon(Icons.clear),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
        ],
      ),
      body: BlocBuilder<HomeScreenCubit, List<Urunler>>(
        builder: (context, urunList) {
          if (urunList.isNotEmpty) {
            return GridView.builder(
              itemCount: urunList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.7),
              itemBuilder: (context, index) {
                var urun = urunList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  urun: urun,
                                ))).then((value) {
                      context.read<HomeScreenCubit>().getAllurun();
                    });
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 211, 250, 246), // Kartlar beyaz
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Kart kenarları yuvarlatılmış
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                            "http://kasimadalan.pe.hu/urunler/resimler/${urun.resim}"),
                        Text(
                          urun.ad,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.directions_bike_outlined,
                              size: 20,
                            ),
                            Text("Ücretsiz Teslimat"),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "₺ ${urun.fiyat}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailScreen(urun: urun)));
                                },
                                iconSize: 30,
                                color: const Color.fromARGB(255, 255, 171, 247),
                                icon: const Icon(Icons.add_box),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(
                urun: urun,
                quantity: 1,
                username: "nihaalakgul",
              ),
            ),
          );
        },
        child: const Icon(
          Icons.shopping_cart,
          size: 32,
        ),
      ),
    );
  }
}
