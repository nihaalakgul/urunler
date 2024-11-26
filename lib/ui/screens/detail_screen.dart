import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler_app/data/entity/urunler.dart';
import 'package:urunler_app/ui/cubit/detail_screen_cubit.dart';
import 'package:urunler_app/ui/screens/cart_screen.dart';

class DetailScreen extends StatefulWidget {
  final Urunler urun;

  DetailScreen({required this.urun});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var quantity = 0;
  var price = 0;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
        ),
        title: const Text(
          "Ürün Detay",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
                "http://kasimadalan.pe.hu/urunler/resimler/${widget.urun.resim}"),
            Text(
              "₺ ${widget.urun.fiyat}",
              style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.urun.ad,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (quantity < 1) {
                        quantity = 0;
                      } else {
                        quantity -= 1;
                        if (quantity == 0) {
                          isVisible = false;
                        } else {
                          isVisible = true;
                        }
                      }
                      var urunPrice = int.parse(widget.urun.fiyat);
                      price = urunPrice * quantity;
                    });
                  },
                  icon: const Icon(
                    Icons.indeterminate_check_box,
                  ),
                  iconSize: 50,
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity += 1;
                      isVisible = true;
                      var urunPrice = int.parse(widget.urun.fiyat);
                      price = urunPrice * quantity;
                    });
                  },
                  icon: const Icon(
                    Icons.add_box,
                  ),
                  iconSize: 50,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.grey[300]),
                  onPressed: () {},
                  child: const Text(
                    "Aynı Gün Kargo",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.grey[300]),
                  onPressed: () {},
                  child: const Text(
                    "Ücretsiz Teslimat",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.grey[300]),
                  onPressed: () {},
                  child: const Text(
                    "İndirim %10",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₺ $price",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(
                              urun: widget.urun,
                              quantity: quantity,
                              username: "nihaalakgul",
                            ),
                          ),
                        );
                        context.read<DetailScreenCubit>().addToCart(
                                widget.urun.ad,                     // urunName
                                widget.urun.resim,                  // urunImageName
                                widget.urun.kategori,               // urunCategory (example field from urun object)
                                int.parse(widget.urun.fiyat),       // urunPrice
                                widget.urun.marka,                  // urunMarka (example field from urun object)
                                quantity,                           // urunOrderQuantity
                                "nihaalakgul");                      // urunOrderQuantity
                                             
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.grey[700],
                      ),
                      child: const Text(
                        "Sepete Ekle",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
