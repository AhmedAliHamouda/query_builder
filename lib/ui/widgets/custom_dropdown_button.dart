import 'package:flutter/material.dart';
import 'package:query_builder/models/query_item_model.dart';
import 'package:query_builder/utils/colors_utils.dart';
import 'package:query_builder/utils/constants.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  const CustomDropdownButtonFormField(
      {Key? key,
      required this.hintText,
      required this.value,
      required this.onChanged,
      required this.onSaved,
      required this.items})
      : super(key: key);

  final String hintText;
  final QueryItemModel? value;
  final Function(QueryItemModel?)? onChanged;
  final Function(QueryItemModel?)? onSaved;
  final List<DropdownMenuItem<QueryItemModel>>? items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<QueryItemModel>(
      validator: (value) {
        if (value == null || value.name!.isEmpty) {
          return "this Field is Required";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        labelStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16.0, color: ColorsUtils.blackColor),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        border: Constants.border,
        disabledBorder: Constants.border,
        enabledBorder: Constants.border,
        errorBorder: Constants.border,
        focusedBorder: Constants.border,
        focusedErrorBorder: Constants.border,
        fillColor: Colors.white,
        filled: true,
      ),
      value: value,
      style: const TextStyle(color: ColorsUtils.blackColor, fontSize: 16),
      icon: Row(
        children: const [
          Icon(
            Icons.keyboard_arrow_down_outlined,
            color: ColorsUtils.blackColor,
          ),
        ],
      ),
      isExpanded: true,
      iconSize: 24,
      onChanged: onChanged,
      onSaved: onSaved,
      items: items,
    );
  }
}
