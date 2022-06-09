import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:query_builder/models/selected_query_model.dart';
import 'package:query_builder/ui/users_screen.dart';
import 'package:query_builder/ui/widgets/custom_query_container.dart';
import 'package:query_builder/ui/widgets/custom_text.dart';
import 'package:query_builder/utils/colors_utils.dart';
import 'package:query_builder/utils/constants.dart';
import 'package:query_builder/utils/routes.dart';
import 'package:query_builder/viewModels/data_riverpod.dart';
import 'package:query_builder/viewModels/global_riverpod_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int counterQueriesContainer = 1;
  List<SelectedQueryModel> listOfSelectedQuery = [];
  List<String> _listOfValues = [];
  String _queryString = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      await providerContainer.read(dataRiverPod).getData();
      listOfSelectedQuery.add(SelectedQueryModel(andOrPerator: ''));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.whiteColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Consumer(
            builder: (context, ref, child) {
              final dataProv = ref.watch(dataRiverPod);
              return dataProv.loading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  :  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 72.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const CustomText(
                                    text: 'Query Builder',
                                    color: ColorsUtils.blackColor,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      counterQueriesContainer++;
                                      listOfSelectedQuery.add(SelectedQueryModel());
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 28.0,
                                      height: 28.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: ColorsUtils.greenColor),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 20.0,
                                        color: ColorsUtils.greenColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: counterQueriesContainer,
                                itemBuilder: (context, index) {
                                  return CustomQueryContainer(
                                    index: index,
                                    list: listOfSelectedQuery,
                                    removeFunction: () {
                                      counterQueriesContainer--;
                                      listOfSelectedQuery.removeAt(index);
                                      setState(() {});
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              dataProv.loadingSearch
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          FocusScope.of(context).unfocus();
                                          _listOfValues = [];
                                          _queryString = '';
                                          _queryString += Constants.queryStart;
                                          for (var element in listOfSelectedQuery) {
                                            _queryString +=
                                                '${element.andOrPerator}${element.queryName}${element.queryOperator} ?';
                                            _listOfValues.add(element.queryValue!);
                                          }
                                          await dataProv.getSearchUsers(
                                              _queryString, _listOfValues);
                                          if (!dataProv.loadingSearch) {
                                            CustomNavigator.pushScreen(
                                                widget: const UsersScreen(), context: context);
                                          }
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorsUtils.buttonColor,
                                          borderRadius: BorderRadius.circular(14.0),
                                        ),
                                        height: 52.0,
                                        child: const Center(
                                          child: Icon(
                                            Icons.search,
                                            size: 35,
                                            color: ColorsUtils.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        );
            },
          ),
        ),
      ),
    );
  }
}
