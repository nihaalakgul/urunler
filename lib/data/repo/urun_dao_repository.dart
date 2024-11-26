import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:urunler_app/data/entity/cart_urun.dart';
import 'package:urunler_app/data/entity/cart_urun_response.dart';
import 'package:urunler_app/data/entity/urunler.dart';
import 'package:urunler_app/data/entity/urunler_cevap.dart';

class UrunDaoRepository {
  // Gelen ürün listesini parse eden fonksiyon
  List<Urunler> parseUrun(String response) {
    try {
      return UrunlerResponse.fromJson(json.decode(response)).urun;
    } catch (e) {
      print("Ürün JSON Parse Hatası: $e");
      return [];
    }
  }

  // Sepet ürünlerini parse eden fonksiyon
  List<SepetUrunler> parseCartUrun(String response) {
    try {
      return SepetUrunlerResponse.fromJson(json.decode(response)).cartUrun;
    } catch (e) {
      print("Sepet JSON Parse Hatası: $e");
      return [];
    }
  }

  // Sepete ürün ekleme
  Future<void> addToCart(
      String urunName,
      String urunImageName,
      String urunCategory,
      int urunPrice,
      String urunMarka,
      int urunOrderQuantity,
      String username) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php";
    var data = {
      "ad": urunName,
      "resim": urunImageName,
      "kategori": urunCategory,
      "fiyat": urunPrice,
      "marka": urunMarka,
      "siparisAdeti": urunOrderQuantity,
      "kullaniciAdi": username,
    };

    try {
      print("Gönderilen veri: $data"); // Kontrol amaçlı
      var response = await Dio().post(url, data: FormData.fromMap(data));
      print("Sepete Ürün Ekleme Yanıtı: ${response.data}");
    } catch (e) {
      print("Sepete Ürün Ekleme Hatası: $e");
    }
  }

  // Sepetteki ürünleri alma
  Future<List<SepetUrunler>> getCartUrun(String username) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php";
    var data = {"kullaniciAdi": username};

    try {
      print("Gönderilen data: $data"); // Konsola yazdır
      var response = await Dio().post(url, data: FormData.fromMap(data));
      print("API Response: ${response.data}");

      if (response.data == null || response.data.toString().isEmpty) {
        print("Boş veya geçersiz yanıt alındı.");
        return [];
      }

      return parseCartUrun(response.data.toString());
    } catch (e) {
      print("Sepetteki Ürünleri Getirme Hatası: $e");
      return [];
    }
  }

  // Sepetten ürün silme
  Future<void> deleteFromCart(int cartUrunId, String username) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php";
    var data = {
      "sepetId": cartUrunId,
      "kullaniciAdi": username,
    };

    try {
      await Dio().post(url, data: FormData.fromMap(data));
      print("Ürün sepetten başarıyla silindi.");
    } catch (e) {
      print("Ürün Silme Hatası: $e");
    }
  }

  // Tüm ürünleri getirme
  Future<List<Urunler>> getAllurun() async {
    var url = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php";

    try {
      var response = await Dio().get(url);
      print("Tüm Ürünler API Response: ${response.data}");
      return parseUrun(response.data.toString());
    } catch (e) {
      print("Tüm Ürünleri Getirme Hatası: $e");
      return [];
    }
  }

  // Ürün arama
  Future<List<Urunler>> searchUrun(String searchTerm) async {
    var url = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php";

    try {
      var response = await Dio().get(url);
      var urunList = parseUrun(response.data.toString());
      return urunList
          .where((urun) =>
              urun.ad.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    } catch (e) {
      print("Ürün Arama Hatası: $e");
      return [];
    }
  }
}
