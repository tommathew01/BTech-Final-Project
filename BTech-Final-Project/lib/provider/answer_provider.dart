import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnswerProvider with ChangeNotifier {
  int _isqsattempted=0;
  int get isqsattempted =>_isqsattempted;


  void initqsattempted(value){
    _isqsattempted=value;
  }

  set isqsattempted(int value){
        _isqsattempted=value;
        notifyListeners();
  }

  Future<int> Answerquery(Map<String, dynamic> payload) async {
    var output;
    do {
      var response = await http.post(
          Uri.parse(
              "https://api-inference.huggingface.co/models/sentence-transformers/all-MiniLM-L12-v1"),
          headers: {
            "Authorization": "Bearer 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"
          },
          body: jsonEncode(payload));
      output = await jsonDecode(response.body);
      print("OUT:${output}");
    } while (output[0] == null);
    if (output[0] > 0.6) {
      print('correct');
      return 1;
    }
    return 0;
  }
}
