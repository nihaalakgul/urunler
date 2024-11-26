import 'package:urunler_app/data/entity/urunler.dart';

class UrunlerResponse {
  List<Urunler> urun;
  int success;

  UrunlerResponse({required this.urun, required this.success});

  factory UrunlerResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json['urunler'] as List;
    int success = json['success'] as int;


    var urunList = jsonArray.map((jsonArrayObject) => Urunler.fromJson(jsonArrayObject)).toList();

    return UrunlerResponse(urun: urunList, success: success);
  }
}