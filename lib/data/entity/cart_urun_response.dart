import 'package:urunler_app/data/entity/cart_urun.dart';

/*class SepetUrunlerResponse {
  List<SepetUrunler> cartUrun;
  int success;

  SepetUrunlerResponse({required this.cartUrun, required this.success});
  factory SepetUrunlerResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json['urunler_sepeti'] as List? ?? [];
    int success = json['success'] as int;

    var cartUrunList = jsonArray
        .map((jsonArrayObject) => SepetUrunler.fromJson(jsonArrayObject))
        .toList();

    return SepetUrunlerResponse(cartUrun: cartUrunList, success: success);
  }

}*/
class SepetUrunlerResponse{
  List<SepetUrunler> cartUrun;
  int success;

  SepetUrunlerResponse({required this.cartUrun,required this.success});
  factory SepetUrunlerResponse.fromJson(Map<String,dynamic> json){
    var jsonArray = json['urunler_sepeti'] as List? ??[];
    int success = json['success'] as int;

    var cartUrunList = jsonArray
      .map((jsonArrayObject)=> SepetUrunler.fromJson(jsonArrayObject))
      .toList();

      return SepetUrunlerResponse(cartUrun: cartUrunList, success: success);

  }
}
