import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler_app/data/repo/urun_dao_repository.dart';

class DetailScreenCubit extends Cubit<void> {
  DetailScreenCubit() : super(0);

  var frepo = UrunDaoRepository();

  Future<void> addToCart(String urunName, String urunImageName,String urunCategory,
      int urunPrice, String urunMarka,int urunOrderQuantity, String username) async {
    await frepo.addToCart(urunName, urunImageName, urunCategory,urunPrice,urunMarka,urunOrderQuantity,username);
  }
}