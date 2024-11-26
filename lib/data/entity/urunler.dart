class Urunler {
  String id;
  String ad;
  String resim;
  String kategori;
  String fiyat;
  String marka;

  Urunler({
    required this.id,
    required this.ad,
    required this.resim,
    required this.kategori,
    required this.fiyat,
    required this.marka,
  });

  factory Urunler.fromJson(Map<String, dynamic> json) {
    return Urunler(
      id: json['id'].toString(),
      ad: json['ad'] as String,
      resim: json['resim'] as String,
      kategori: json['kategori'] as String,
      fiyat: json['fiyat'] .toString(),
      marka: json['marka'] as String,
      /*id: json['id'].toString(), // Eğer id bir int ise, toString ile String'e çevir
      ad: json['ad']?.toString() ?? '', // Eğer ad null ise boş string atama
      resim: json['resim']?.toString() ?? '', // Eğer resim null ise boş string atama
      kategori: json['kategori']?.toString() ?? '', // Eğer kategori null ise boş string atama
      fiyat: json['fiyat'].toString(), // Eğer fiyat bir int veya double ise, toString ile String'e çevir
      marka: json['marka']?.toString() ?? '', // Eğer marka null ise boş string atama
      */
    );
  }
} 

