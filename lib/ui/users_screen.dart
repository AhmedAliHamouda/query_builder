import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:query_builder/ui/widgets/custom_text.dart';
import 'package:query_builder/ui/widgets/custom_user_widget.dart';
import 'package:query_builder/utils/colors_utils.dart';
import 'package:query_builder/utils/routes.dart';
import 'package:query_builder/viewModels/data_riverpod.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 20.0),
                child: InkWell(
                    onTap: () {
                      CustomNavigator.popScreen(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: ColorsUtils.blackColor,
                    )),
              ),
              const SizedBox(
                height: 7.0,
              ),
              const CustomText(
                text: 'Users',
                fontSize: 32.0,
                color: ColorsUtils.blackColor,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(
                height: 24.0,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final dataProv = ref.watch(dataRiverPod);
                  return Flexible(
                    child: dataProv.listUsers == null
                        ? const Center(
                            child: Text('Error Found'),
                          )
                        : dataProv.listUsers!.isEmpty
                            ? const Center(
                                child: Text('No Users Found'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: dataProv.listUsers!.length,
                                itemBuilder: (context, index) {
                                  return CustomUserWidget(userModel: dataProv.listUsers![index]);
                                },
                              ),
                  );
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
