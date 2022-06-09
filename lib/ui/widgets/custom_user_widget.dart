import 'package:flutter/material.dart';
import 'package:query_builder/models/user_model.dart';
import 'package:query_builder/ui/widgets/custom_text.dart';
import 'package:query_builder/utils/colors_utils.dart';

class CustomUserWidget extends StatelessWidget {
  final UserModel userModel;
  const CustomUserWidget({required this.userModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      margin: const EdgeInsets.symmetric(vertical: 6.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: 44.0,
            width: 44.0,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsUtils.borderColor.withOpacity(0.5),
            ),
            child: Center(child: CustomText(text: userModel.age.toString(),color: ColorsUtils.blackColor,fontSize: 18.0,fontWeight: FontWeight.w700,)),
          ),
          title:  CustomText(
            text: '${userModel.firstName}, ${userModel.lastName}',
            color: ColorsUtils.blackColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
          subtitle:  CustomText(
            text: '${userModel.gender}',
            color: ColorsUtils.blackColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
