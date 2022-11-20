import 'package:english_vocabulary/constants/global_variables.dart';
import 'package:english_vocabulary/model/word.dart';
import 'package:english_vocabulary/pages/add_word_page.dart';
import 'package:english_vocabulary/pages/detail_page.dart';
import 'package:english_vocabulary/pages/update_word_page.dart';
import 'package:english_vocabulary/service/service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Word>? words;
  List<Word>? wordsFav;
  final Services services = Services();

  FlutterTts flutterTts = FlutterTts();
  
  void main() async {
    //print(y);
    final translator = GoogleTranslator();
    //translator.translate(y, from: 'en', to: 'vi').then(print);
    translator.translate("I love Brazil!", from: 'en', to: 'vi').then((s) {
      print(s);
    });
  }

  String y = 'good';

  @override
  void initState() {
    // main();
    super.initState();
    fetchAllWords();
    fetchAllWordsFav();
  }

  fetchAllWords() async {
    words = await services.fetchAllWords(context);
    setState(() {});
  }

  fetchAllWordsFav() async {
    wordsFav = await services.fetchAllWordsFav(context);
    setState(() {});
  }
  
  void deleteWord(Word word, int index) {
    services.deleteWord(
      context: context,
      word: word,
      onSuccess: () {
        words!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(words?.length);
    return 
    words == null || wordsFav == null
  ? const Center(
      child: CircularProgressIndicator(),
    )
  : 
  DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundMain,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              setState(() {
                // main();
                //print(words!.length);
                // fetchAllWords();
              });
            },
            child: Icon(Icons.list_outlined, color: Colors.white, size: 36),
          ),
        ),
        body: Column(
          children: [
            // 
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 40, left: 15),
                    alignment: Alignment.bottomLeft,
                    width: size.width,
                    height: size.height * 2.5 / 10,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(223, 197, 105, 209),
                          Color.fromARGB(255, 186, 149, 196),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome !',
                          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: AppColors.secondColor),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Good news for all students',
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: AppColors.secondColor),
                        ),
                        Text(
                          'We develop an app to improve your vocab memory',
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: AppColors.secondColor),
                        ),
                      ],
                    ),
                  ),
                ]
              )
            ),

            //
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Colors.white,
                bottom: TabBar(
                  indicatorColor: AppColors.backgroundMain,
                  tabs: [
                    Tab(
                      child: Container(
                        child: Text(
                          'All', 
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Tab(
                      
                      child: Container(
                        child: Text(
                          'Favorites', 
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            Expanded(
              child: TabBarView(
                children: [
                  // All
                  
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 12),
                    height: 50,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: words!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final wordData = words![index];

                        return Container(
                          padding: EdgeInsets.only(top: 12, bottom: 12, left: 14),
                          margin: EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(223, 241, 63, 137),
                                Color.fromARGB(255, 186, 149, 196),
                              ],
                            ),
                          ),
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(wordData.name, style: TextStyle(fontSize: 17),),
                                  IconButton(
                                    onPressed: () async{
                                      flutterTts.setSpeechRate(0.5);
                                      flutterTts.setLanguage("en-US");
                                      flutterTts.speak(wordData.name);
                                      },
                                    icon: Icon(
                                      Icons.headset_rounded, size: 14,
                                    )
                                  )
                                ],
                              ),
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailPage()));
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                                        name: wordData.name,
                                        description: wordData.description,
                                        translate: wordData.translate,
                                        favorite: wordData.favorite
                                      )));
                                      },
                                      icon: Icon(
                                        Icons.play_arrow_outlined, size: 14,
                                      )
                                    ),
                                    if(wordData.favorite == "yes")
                                    IconButton(
                                      onPressed: (){

                                      },
                                      icon: Icon(
                                         Icons.favorite, size: 14, color:Colors.red, 
                                      )
                                    ), 
                                    if(wordData.favorite == "no" || wordData.favorite == null)
                                    IconButton(
                                      onPressed: (){

                                      },
                                      icon: Icon(
                                         Icons.favorite_border, size: 14, color:Colors.white, 
                                      )
                                    ), 
                                    IconButton(
                                      onPressed: () => deleteWord(wordData, index),
                                      icon: Icon(
                                        Icons.delete, size: 16,
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Favorites
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 12),
                    height: 50,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: wordsFav!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final wordFavData = wordsFav![index];
                        return Container(
                          padding: EdgeInsets.only(top: 12, bottom: 12, left: 14),
                          margin: EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 186, 149, 196),
                                Color.fromARGB(223, 81, 102, 223),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(wordFavData.name, style: TextStyle(fontSize: 17),),
                                  IconButton(
                                    onPressed: () async{
                                      flutterTts.setSpeechRate(0.5);
                                      flutterTts.setLanguage("en-US");
                                      
                                      flutterTts.speak(wordFavData.name);
                                      },
                                    icon: Icon(
                                      Icons.headset_rounded, size: 14,
                                    )
                                  )
                                ],
                              ),
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailPage()));
                                      },
                                      icon: Icon(
                                        Icons.play_arrow_outlined, size: 14,
                                      )
                                    ),
                                    if(wordFavData.favorite == "yes")
                                    IconButton(
                                      onPressed: (){

                                      },
                                      icon: Icon(
                                         Icons.favorite, size: 14, color:Colors.red, 
                                      )
                                    ), 
                                    if(wordFavData.favorite == "no" || wordFavData.favorite == null)
                                    IconButton(
                                      onPressed: (){

                                      },
                                      icon: Icon(
                                         Icons.favorite_border, size: 14, color:Colors.white, 
                                      )
                                    ), 
                                    IconButton(
                                      onPressed: () => deleteWord(wordFavData, index),
                                      icon: Icon(
                                        Icons.delete, size: 16,
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  
                ],
              ),
            ),

          ]
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:Color.fromARGB(255, 202, 22, 142),
          onPressed: () {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddWordPage()));
            });
          },
          child: Icon(Icons.add, size: 36,),
        ),
      ),
      
    );
  }
}

