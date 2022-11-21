import 'dart:convert';
import 'dart:io';

import 'package:english_vocabulary/model/word.dart';
import 'package:english_vocabulary/pages/detail_page.dart';
import 'package:english_vocabulary/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

String uri = 'http://10.0.2.2:3000';

void showSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    )
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}

class Services {
  //
  void addWord({
    required BuildContext context,
    required String name,
    required String description,
    required String translate,
    required String favorite,
  }) async {

    try {
      Word word = Word(
        name: name,
        description: description,
        translate: translate,
        favorite: favorite,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-word'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: word.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Added Successfully!');
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all
  Future<List<Word>> fetchAllWords(BuildContext context) async {
    List<Word> wordList = [];
    try {

      http.Response res = await http.get(Uri.parse('$uri/api/get-all-words'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            wordList.add(
              Word.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return wordList;
  }

  Future<List<Word>> fetchAllWordsFav(BuildContext context) async {
    List<Word> wordList = [];
    
    try {
      http.Response res = await http.get(Uri.parse('$uri/api/get-all-words-fav'), 
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            wordList.add(
              Word.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return wordList;
  }

  void deleteWord({
    required BuildContext context,
    required Word word,
    required VoidCallback onSuccess,
  }) async {
    
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/delete-word'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': word.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          showSnackBar(context, 'Deleted Successful !');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void updateWord({
    required BuildContext context,
    required String id,
    required String name,
    required String description,
    required String translate,
    required VoidCallback onSuccess,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/update-word'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': id,
          'name': name,
          'description': description,
          'translate': translate,
          //'favorite': word.favorite,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailPage(
            id: id,
            name: name,
            description: description,
            translate: translate,
            //favorite: wordData.favorite               
          )));
          showSnackBar(context, 'Updated Successful !');
          
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void updateFavorite({
    required BuildContext context,
    required String id,
    required String favorite,
    required VoidCallback onSuccess,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/update-favorite'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': id,
          'favorite': favorite,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage(
          )));
          showSnackBar(context, 'Updated Successful !');
          
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}