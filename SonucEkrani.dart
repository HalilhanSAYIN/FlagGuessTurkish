import 'package:bayrak_quiz_uygulamasi/main.dart';
import 'package:flutter/material.dart';

class SonucEkrani extends StatefulWidget {

  int dogrusayisi;

  SonucEkrani({required this.dogrusayisi});

  @override
  State<SonucEkrani> createState() => _SonucEkraniState();
}

class _SonucEkraniState extends State<SonucEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sonuç Ekrani"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.dogrusayisi}  Doğru ${5- widget.dogrusayisi} Yanlış",style: TextStyle(fontSize: 30),),
            Text("%${(widget.dogrusayisi*100/5).toInt()} Başarı",style: TextStyle(fontSize: 30,color: Colors.pink),),
            SizedBox(width: 250,height: 50,
              child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Tekrar Dene")),
            ),
          ],
        ),
      ),

    );
  }
}
