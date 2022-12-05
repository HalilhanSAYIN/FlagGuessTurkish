import 'dart:collection';

import 'package:bayrak_quiz_uygulamasi/Bayraklar.dart';
import 'package:bayrak_quiz_uygulamasi/Bayraklardao.dart';
import 'package:bayrak_quiz_uygulamasi/SonucEkrani.dart';
import 'package:flutter/material.dart';

class QuizEkrani extends StatefulWidget {
  const QuizEkrani({Key? key}) : super(key: key);

  @override
  State<QuizEkrani> createState() => _QuizEkraniState();
}

class _QuizEkraniState extends State<QuizEkrani> {

  var sorular = <Bayraklar>[];
  var yanlisSecenekler = <Bayraklar>[];
  late Bayraklar dogruSoru;
  var tumSecenekler = HashSet<Bayraklar>();

  int soruSayac=0;
  int dogruSayac=0;
  int yanlisSayac=0;

  String bayrakResimAdi="placeholder.png";
  String buttonAyazi="";
  String buttonByazi="";
  String buttonCyazi="";
  String buttonDyazi="";

  @override
  void initState(){
    super.initState();

    sorulariAl();
  }
  Future<void>sorulariAl()async{
    sorular=await Bayraklardao().rastgele5getir();
    soruYukle();
  }

  Future<void>soruYukle()async{
  dogruSoru = sorular[soruSayac];
  bayrakResimAdi = dogruSoru.bayrak_resim;
  yanlisSecenekler = await Bayraklardao().rastgele3Yanlisgetir(dogruSoru.bayrak_id);

  tumSecenekler.clear();
  tumSecenekler.add(dogruSoru);
  tumSecenekler.add(yanlisSecenekler[0]);
  tumSecenekler.add(yanlisSecenekler[1]);
  tumSecenekler.add(yanlisSecenekler[2]);

  buttonAyazi = tumSecenekler.elementAt(0).bayrak_ad;
  buttonByazi = tumSecenekler.elementAt(1).bayrak_ad;
  buttonCyazi = tumSecenekler.elementAt(2).bayrak_ad;
  buttonDyazi = tumSecenekler.elementAt(3).bayrak_ad;

  setState(() {
  });

  }

  void soruSayacKontrol(){
    soruSayac=soruSayac+1;

    if(soruSayac != 5){
      soruYukle();
    }else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> SonucEkrani(dogrusayisi: dogruSayac,)));
    }
  }

  void dogrukontrol(String buttonYazi){
    if(dogruSoru.bayrak_ad == buttonYazi) {
      dogruSayac = dogruSayac + 1;
    }else{
      yanlisSayac=yanlisSayac+1;
      }
    }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Ekranı"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Text("Doğru : $dogruSayac",style: TextStyle(fontSize: 18),),
              Text("Yanlış : $yanlisSayac",style: TextStyle(fontSize: 18),),
            ],),
            soruSayac != 5 ? Text("${soruSayac+1}. Soru",style: TextStyle(fontSize: 30),) :
            Text("5. Soru",style: TextStyle(fontSize: 30),),
            Image.asset("resimler/$bayrakResimAdi"),

            SizedBox(width: 250,height: 50,
              child: ElevatedButton(
                  onPressed: (){
                dogrukontrol(buttonAyazi);
                soruSayacKontrol();
              }, child: Text(buttonAyazi)),
            ),
            SizedBox(width: 250,height: 50,
              child: ElevatedButton(onPressed: (){
                dogrukontrol(buttonByazi);
                soruSayacKontrol();
              }, child: Text(buttonByazi)),
            ),
            SizedBox(width: 250,height: 50,
              child: ElevatedButton(onPressed: (){
                dogrukontrol(buttonCyazi);
                soruSayacKontrol();
              }, child: Text(buttonCyazi)),
            ),
            SizedBox(width: 250,height: 50,
              child: ElevatedButton(onPressed: (){
                dogrukontrol(buttonDyazi);
                soruSayacKontrol();
              }, child: Text(buttonDyazi)),
            ),
          ],
        ),
      ),

    );
  }
}
