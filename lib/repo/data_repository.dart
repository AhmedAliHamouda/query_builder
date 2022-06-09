import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:query_builder/helpers/db_helper.dart';
import 'package:query_builder/models/user_model.dart';

class DataRepository {
  static Map<String, String> headers() {
    Map<String, String> headerMap = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    return headerMap;
  }

  static Future<List<UserModel>?> getData() async {
    try {
      final List<UserModel> _list = [];
      String basUrl = 'https://mocki.io/v1/feb55092-37b0-4bd4-a9ad-d7e92a3ebd72';
      final response = await http.get(Uri.parse(basUrl), headers: headers());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final finalResponse = jsonDecode(response.body) as List<dynamic>;
        log(finalResponse.toString());
        for (var element in finalResponse) {
          await DBHelper.insert(table: 'users_data', data: element as Map<String, dynamic>);
          _list.add(UserModel.fromJson(element));
        }
        return _list;
      } else {
        print('response code${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('error ${error.toString()}');
      return null;
    }
  }
}
