class SepetUrunler {
  String sepetId;
  String ad;
  String resim;
  String kategori;
  String fiyat;
  String marka;
  String siparisAdeti;
  String kullaniciAdi;

  SepetUrunler({
    required this.sepetId,
    required this.ad,
    required this.resim,
    required this.kategori,
    required this.fiyat,
    required this.marka,
    required this.siparisAdeti,
    required this.kullaniciAdi,
  });

  
  factory SepetUrunler.fromJson(Map<String, dynamic> json) {
  return SepetUrunler(
    sepetId: json['sepetId']?.toString() ?? '',
    ad: json['ad']?.toString() ?? '',
    resim: json['resim']?.toString() ?? '',
    kategori: json['kategori']?.toString() ?? '',
    fiyat: json['fiyat'].toString(),
    marka: json['marka']?.toString() ?? '',
    siparisAdeti: json['siparisAdeti']?.toString() ?? '',
    kullaniciAdi: json['kullaniciAdi']?.toString() ?? '',
  );
}

}
