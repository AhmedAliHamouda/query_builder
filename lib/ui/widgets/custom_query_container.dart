import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:query_builder/models/query_item_model.dart';
import 'package:query_builder/models/selected_query_model.dart';
import 'package:query_builder/ui/widgets/custom_dropdown_button.dart';
import 'package:query_builder/ui/widgets/custom_textformfield.dart';
import 'package:query_builder/utils/colors_utils.dart';
import 'package:query_builder/utils/constants.dart';
import 'package:query_builder/utils/custom_functions.dart';
import 'package:query_builder/viewModels/data_riverpod.dart';

class CustomQueryContainer extends StatefulWidget {
  final int index;
  final VoidCallback removeFunction;
  final List<SelectedQueryModel>? list;

  const CustomQueryContainer(
      {Key? key, required this.index, required this.removeFunction, required this.list})
      : super(key: key);

  @override
  State<CustomQueryContainer> createState() => _CustomQueryContainerState();
}

class _CustomQueryContainerState extends State<CustomQueryContainer> {
  bool _isAge = false;
  String _queryOperatorName='';
  @override
  void initState() {
    super.initState();
    _queryOperatorName=Constants.stringOperators[0].name!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final dataProv = ref.watch(dataRiverPod);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Query Operator and , or
            widget.index == 0
                ? Container()
                : Container(
                    width: 80.0,
                    height: 36.0,
                    margin: const EdgeInsets.symmetric(vertical: 24.0),
                    child:CustomDropdownButtonFormField(
                      hintText: 'op',
                      value: Constants.andOrOperators[0],
                      onChanged: (newValue) {},
                      onSaved: (value) {
                        widget.list![widget.index].andOrPerator = value!.value!;
                      },
                      items: Constants.andOrOperators
                          .map<DropdownMenuItem<QueryItemModel>>((QueryItemModel value) {
                        return DropdownMenuItem(
                          child: Text(value.name!),
                          value: value,
                        );
                      }).toList(),

                    ),
                  ),
            Container(
              height: 104,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0), color: ColorsUtils.containerColor),
              child: Row(
                children: [
                  /// query names ,query operator and query values
                  Flexible(
                    child: Column(
                      children: [
                        /// query names ,query operator
                        Row(
                          children: [
                            /// query names
                            Flexible(
                              child: SizedBox(
                                height: 36.0,
                                child:CustomDropdownButtonFormField(
                                  hintText: 'Select Item',
                                  value: Constants.names[0],
                                  onChanged: (newValue) {
                                    if (newValue!.name == 'Age') {
                                      _isAge = true;
                                    } else {
                                      _isAge = false;
                                    }
                                    setState(() {});
                                  },
                                  onSaved: (value) {
                                    widget.list![widget.index].queryName = value!.value!;
                                  },
                                  items: Constants.names.map<DropdownMenuItem<QueryItemModel>>(
                                          (QueryItemModel value) {
                                        return DropdownMenuItem(
                                          child: Text(value.name!),
                                          value: value,
                                        );
                                      }).toList(),

                                ),
                             /*   child: DropdownButtonFormField<QueryItemModel>(
                                  validator: (value) {
                                    if (value == null || value.name!.isEmpty) {
                                      return "this Field is Required";
                                    }
                                    return null;
                                  },
                                  value: Constants.names[0],
                                  decoration: InputDecoration(
                                    hintText: 'Select Item',
                                    labelStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                        color: ColorsUtils.blackColor),
                                    contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                                    border: Constants.border,
                                    disabledBorder: Constants.border,
                                    enabledBorder: Constants.border,
                                    errorBorder: Constants.border,
                                    focusedBorder: Constants.border,
                                    focusedErrorBorder: Constants.border,
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  style:
                                      const TextStyle(color: ColorsUtils.blackColor, fontSize: 16),
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
                                  onChanged: (newValue) {
                                    if (newValue!.name == 'Age') {
                                      _isAge = true;
                                    } else {
                                      _isAge = false;
                                    }
                                    setState(() {});
                                  },
                                  onSaved: (value) {
                                    widget.list![widget.index].queryName = value!.value!;
                                  },
                                  items: Constants.names.map<DropdownMenuItem<QueryItemModel>>(
                                      (QueryItemModel value) {
                                    return DropdownMenuItem(
                                      child: Text(value.name!),
                                      value: value,
                                    );
                                  }).toList(),
                                ),*/
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            /// query operator
                            SizedBox(
                              width: 66.0,
                              height: 36.0,
                              child:CustomDropdownButtonFormField(
                                hintText: 'op',
                                value:  _isAge
                                    ? Constants.numberOperators[0]
                                    : Constants.stringOperators[0],
                                onChanged: (newValue) {
                                  _queryOperatorName=newValue!.name!;
                                },
                                onSaved: (value) {
                                  widget.list![widget.index].queryOperator = value!.value!;
                                  _queryOperatorName=value.name!;
                                },
                                items: (_isAge
                                    ? Constants.numberOperators
                                    : Constants.stringOperators)
                                    .map<DropdownMenuItem<QueryItemModel>>((QueryItemModel value) {
                                  return DropdownMenuItem(
                                    child: Text(value.name!),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        /// query values
                        Flexible(
                          child: AppTextFormField(
                            keyboardType: TextInputType.name,
                            horizontalPadding: 10.0,
                            verticalPadding: 0.0,
                            borderColor: ColorsUtils.borderColor.withOpacity(0.2),
                            borderRadius: 5.0,
                            hintText: 'query search',
                            fillColor: ColorsUtils.whiteColor,
                            fieldHeight: 40.0,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'this field Required';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            onSaved: (value) {
                           final newVal=CustomFunctions.getValueByOperator(_queryOperatorName, value!);
                              widget.list![widget.index].queryValue = newVal;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  /// remove container
                  widget.index == 0
                      ? Container()
                      : InkWell(
                          onTap: widget.removeFunction,
                          child: Container(
                            width: 28.0,
                            height: 28.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorsUtils.redColor),
                            ),
                            child: const Icon(
                              Icons.clear,
                              size: 20.0,
                              color: ColorsUtils.redColor,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
