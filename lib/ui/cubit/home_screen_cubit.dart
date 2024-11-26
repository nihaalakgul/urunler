import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urunler_app/data/entity/urunler.dart';
import 'package:urunler_app/data/repo/urun_dao_repository.dart';

class HomeScreenCubit extends Cubit<List<Urunler>> {
  HomeScreenCubit() : super(<Urunler>[]);

  var frepo = UrunDaoRepository();

  Future<void> getAllurun() async {
    var list = await frepo.getAllurun();
    emit(list);
  }

  Future<void> searchUrun(String searchTerm) async {
    var list = await frepo.searchUrun(searchTerm);
    emit(list);
  }
}