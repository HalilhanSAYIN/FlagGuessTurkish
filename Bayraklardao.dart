import 'package:bayrak_quiz_uygulamasi/Bayraklar.dart';
import 'package:bayrak_quiz_uygulamasi/VeritabaniYardimcisi.dart';

class Bayraklardao{

Future<List<Bayraklar>> rastgele5getir() async {
  var db = await VeritabaniYardimcisi.veritabaniErisim();

  List<Map<String,dynamic>> maps =await db.rawQuery(
      "SELECT * FROM bayraklar ORDER BY RANDOM() LIMIT 5"
  );

  return List.generate(maps.length, (i) {
    var satir = maps[i];
    return Bayraklar(satir["bayrak_id"],satir["bayrak_ad"],satir["bayrak_resim"]);
});
}
Future<List<Bayraklar>> rastgele3Yanlisgetir(int bayrak_id) async {
  var db = await VeritabaniYardimcisi.veritabaniErisim();

  List<Map<String,dynamic>> maps =await db.rawQuery(
      "SELECT * FROM bayraklar WHERE bayrak_id !=$bayrak_id ORDER BY RANDOM() LIMIT 3"
  );

  return List.generate(maps.length, (i) {
    var satir = maps[i];
    return Bayraklar(satir["bayrak_id"],satir["bayrak_ad"],satir["bayrak_resim"]);
  });
}

}