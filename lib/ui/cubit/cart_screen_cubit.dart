import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler_app/data/entity/cart_urun.dart';
import 'package:urunler_app/data/repo/urun_dao_repository.dart';

class CartScreenCubit extends Cubit<List<SepetUrunler>> {
  CartScreenCubit() : super(<SepetUrunler>[]);

  var frepo = UrunDaoRepository();

  // Sepet Ürünlerini Al
  Future<void> getCartUrun(String username) async {
    try {
      var list = await frepo.getCartUrun(username);
      emit(list); // Yeni liste durumu yayımlanıyor
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  // Sepetten Ürün Sil
  Future<void> deleteFromCart(int carturunId, String username) async {
    try {
      await frepo.deleteFromCart(carturunId, username);
      // Silme işleminden sonra güncellenmiş listeyi getir
      await getCartUrun(username);
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }
}
