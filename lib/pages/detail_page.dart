import 'package:english_vocabulary/pages/update_word_page.dart';
import 'package:english_vocabulary/service/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DetailPage extends StatefulWidget {
 final String? name;
  final String? description;
  final String? translate;
  final String? favorite;
  const DetailPage({Key? key, 
    required this.name, 
    this.description, 
    this.translate, 
    this.favorite})
  : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController wordController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController translateController = TextEditingController();
  final TextEditingController favoriteController = TextEditingController();
  final Services services = Services();

  final _updateWordFormKey = GlobalKey<FormState>();
  
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 235, 156, 221),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const Text(
              //   'Update',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold,
              //   ),
              // )
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Text(widget.name.toString(), style: TextStyle(fontSize: 18),),
                    IconButton(
                      onPressed: () async{
                        flutterTts.setSpeechRate(0.5);
                        flutterTts.setLanguage("en-US");
                        flutterTts.speak(widget.name!);
                        },
                    
                      icon: Icon(
                        Icons.headset_rounded, size: 14,
                      )
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Text(widget.translate.toString(), style: TextStyle(fontSize: 18),),
                    IconButton(
                      onPressed: () async{
                        flutterTts.setSpeechRate(0.5);
                        flutterTts.setLanguage("vi-VN");
                        flutterTts.speak(widget.translate!);
                        },
                      icon: Icon(
                        Icons.headset_rounded, size: 14,
                      )
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text('Update',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateWordPage(
                  name: widget.name,
                  description: widget.description,
                  translate: widget.translate,
                  favorite: widget.favorite
                )));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                primary: Color.fromARGB(255, 195, 125, 241),
              ),
            ),
          ],
        ),
      ),
    );
  }
}