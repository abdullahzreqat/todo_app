// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Shared/components/components.dart';
import 'package:todo_app/Shared/components/constants.dart';
import 'package:todo_app/Shared/cubit/cubit.dart';
import 'package:todo_app/Shared/cubit/states.dart';

class BuildBottomSheet extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(listener: (context,state){},builder: (context,state){

      return Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                defaultTextField(suffixPress: () {
                  if (formKey.currentState!.validate()) {
                    AppCubit.get(context)
                        .insertToDatabase(
                        title: taskController.text,
                        date: AppCubit.get(context).formatedDate,
                        time: AppCubit.get(context).formatedTime)
                        .then((value) {
                      Navigator.pop(context);
                      AppCubit.get(context).changeBottomSheetState();
                      taskController.text="";
                      AppCubit.get(context).formatedDate="";
                      AppCubit.get(context).formatedTime="";
                    }).catchError((error) {
                      print(
                          "Error when try to insert data into database, $error");
                    });
                  }
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate:
                              AppCubit.get(context).taskDate,
                              firstDate:
                              DateTime.now(),
                              lastDate:
                              DateTime(2030))
                              .then((value) {

                            AppCubit.get(context).changeDateSelectedState(
                                date: value);
                          });
                        },
                        child: AppCubit.get(context).formatedDate!=""
                            ? Container(
                            height: 33,
                            decoration: BoxDecoration(
                              shape:
                              BoxShape.rectangle,
                              borderRadius:
                              BorderRadius
                                  .circular(50),
                              color: defaultColor,
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets
                                  .symmetric(
                                  horizontal:
                                  10.0),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .center,
                                children: [
                                  Icon(
                                    Icons
                                        .calendar_month_outlined,
                                    color:
                                    Colors.black,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    DateFormat.yMMMd()
                                        .format(AppCubit.get(context).taskDate),
                                    style: TextStyle(
                                        color: Colors
                                            .black),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppCubit.get(context).changeDateSelectedState(date: "");
                                    },
                                    child: Container(
                                      decoration:
                                      BoxDecoration(
                                        shape: BoxShape
                                            .circle,
                                        color: Colors
                                            .grey[
                                        600],
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors
                                            .black,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                            : Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .center,
                          children: [
                            Icon(
                              Icons
                                  .calendar_month_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Set a date", //DateFormat.yMMMd().format(taskDate),
                              style: TextStyle(
                                  color:
                                  Colors.grey),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showTimePicker(
                              context: context,
                              initialTime:
                              AppCubit.get(context).taskTime)
                              .then((value) {
                            AppCubit.get(context).changeTimeSelectedState(context: context,time: value);
                          });
                        },
                        child: AppCubit.get(context).formatedTime!=""
                            ? Container(
                            height: 33,
                            decoration: BoxDecoration(
                              shape:
                              BoxShape.rectangle,
                              borderRadius:
                              BorderRadius
                                  .circular(50),
                              color: defaultColor,
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets
                                  .symmetric(
                                  horizontal:
                                  10.0),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .center,
                                children: [
                                  Icon(
                                    Icons.alarm,
                                    color:
                                    Colors.black,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    AppCubit.get(context).formatedTime,
                                    style: TextStyle(
                                        color: Colors
                                            .black),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppCubit.get(context).changeTimeSelectedState(context: context,time: "");
                                    },
                                    child: Container(
                                      decoration:
                                      BoxDecoration(
                                        shape: BoxShape
                                            .circle,
                                        color: Colors
                                            .grey[
                                        600],
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors
                                            .black,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                            : Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .center,
                          children: [
                            Icon(
                              Icons.alarm,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Set a time",
                              style: TextStyle(
                                  color:
                                  Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
    );
  }
}
