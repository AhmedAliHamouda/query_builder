import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:query_builder/helpers/db_helper.dart';
import 'package:query_builder/models/user_model.dart';
import 'package:query_builder/repo/data_repository.dart';

final dataRiverPod = ChangeNotifierProvider<DataRiverPod>((ref) => DataRiverPod());

class DataRiverPod extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _loading = true;

  bool get loading => _loading;

  set loading(bool val) {
    _loading = val;
    notifyListeners();
  }

  bool _loadingSearch = false;

  bool get loadingSearch => _loadingSearch;

  set loadingSearch(bool val) {
    _loadingSearch = val;
    notifyListeners();
  }

  List<UserModel>? listUsers = [];

  Future<void> getData() async {
    loading = true;
    final _usersCount = await DBHelper.getDataCount('users_data');
    if (_usersCount == 0) {
      final response = await DataRepository.getData();
      if (response != null) {
        listUsers = response;
        loading = false;
      } else {
        loading = false;
      }
    } else {
      loading = false;
    }
  }

  Future<void> getSearchUsers(String queryString, List<String> listOfValues) async {
    try{
      listUsers=[];
      loadingSearch = true;
      final resp = await DBHelper.getSearchData('users_data', queryString, listOfValues);
      for (var element in resp) {
        listUsers!.add(UserModel.fromJson(element));
      }
      loadingSearch=false;
    }catch(error){
      listUsers=null;
      loadingSearch=false;
    }
  }
}
