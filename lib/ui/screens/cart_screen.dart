import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler_app/data/entity/cart_urun.dart';
import 'package:urunler_app/data/entity/urunler.dart';
import 'package:urunler_app/ui/cubit/cart_screen_cubit.dart';
import 'package:urunler_app/ui/screens/home_screen.dart';

class CartScreen extends StatefulWidget {
  final Urunler urun;
  final int quantity;
  final String username;

  CartScreen(
      {required this.urun, required this.quantity, required this.username});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  num total = 0;

  @override
  void initState() {
    super.initState();
    context.read<CartScreenCubit>().getCartUrun("nihaalakgul");
    total = total + int.parse(widget.urun.fiyat) * (widget.quantity);
  }

  void goBackButton(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    total = 0;
  }

  void buttonShowDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Siparişiniz yola çıkmak için hazırlanıyor"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  child: const Text("Anasayfaya Dön"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              goBackButton(context);
            },
            icon: const Icon(Icons.clear)),
      ),
      body: BlocBuilder<CartScreenCubit, List<SepetUrunler>>(
        builder: (context, cartUrunList) {
          if (cartUrunList.isNotEmpty) {
            total = cartUrunList.fold(
                0,
                (previousValue, element) =>
                    previousValue +
                    (int.parse(element.fiyat) *
                        int.parse(element.siparisAdeti)));

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartUrunList.length,
                    itemBuilder: (context, index) {
                      var urun = cartUrunList[index];
                      total = total +
                          (int.parse(cartUrunList[index].fiyat) *
                              int.parse(
                                  cartUrunList[index].siparisAdeti));
                      return Card(
                        child: SizedBox(
                          height: 125,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                  "http://kasimadalan.pe.hu/urunler/resimler/${urun.resim}"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      urun.ad,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Fiyat: ₺${urun.fiyat}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Adet: ${urun.siparisAdeti}"),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("${urun.ad} silinsin mi?"),
                                          action: SnackBarAction(
                                            label: "Evet",
                                            onPressed: () {
                                              context
                                                  .read<CartScreenCubit>()
                                                  .deleteFromCart(
                                                      int.parse(urun.sepetId),
                                                      urun.kullaniciAdi);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                    iconSize: 24,
                                  ),
                                  Text(
                                    "₺ ${int.parse(urun.fiyat) * int.parse(urun.siparisAdeti)}",
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gönderim Ücreti",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "₺0",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Toplam:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "₺$total",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: buttonShowDialog,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow[700]),
                          child: const Text(
                            "SEPETİ ONAYLA",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Sepetiniz boş.'),
            );
          }
        },
      ),
    );
  }
}
