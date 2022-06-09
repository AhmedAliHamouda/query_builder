import 'package:flutter/material.dart';
import 'package:query_builder/models/query_item_model.dart';
import 'package:query_builder/utils/colors_utils.dart';

class Constants {
  static String queryStart='SELECT * FROM users_data WHERE';
  static List<QueryItemModel> names = [
    QueryItemModel(name: 'First Name', value: ' first_name'),
    QueryItemModel(name: 'Last Name', value: ' last_name'),
    QueryItemModel(name: 'Full Name', value: ' full_name'),
    QueryItemModel(name: 'Age', value: ' age'),
    QueryItemModel(name: 'Gender', value: ' gender'),
  ];

  static List<QueryItemModel> numberOperators = [
    QueryItemModel(name: '=', value: ' ='),
    QueryItemModel(name: '!=', value: ' !='),
    QueryItemModel(name: '>', value: ' >'),
    QueryItemModel(name: '<', value: ' <'),
  ];
  static List<QueryItemModel> stringOperators = [
    QueryItemModel(name: 'start with', value: ' like'),
    QueryItemModel(name: 'end with', value: ' like '),
    QueryItemModel(name: 'contains', value: ' like '),
    QueryItemModel(name: 'exact', value: ' like '),
  ];

  static List<QueryItemModel> andOrOperators = [
    QueryItemModel(name: 'AND', value: ' and'),
    QueryItemModel(name: 'OR', value: ' or'),
];

  static OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide:   BorderSide(color: ColorsUtils.borderColor.withOpacity(0.2)));
}
