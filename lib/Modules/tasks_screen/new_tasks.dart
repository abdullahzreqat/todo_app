// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Modules/bottom_sheet/bottom_sheet.dart';
import 'package:todo_app/Shared/components/components.dart';
import 'package:todo_app/Shared/components/constants.dart';
import 'package:todo_app/Shared/cubit/cubit.dart';
import 'package:todo_app/Shared/cubit/states.dart';

class TasksScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          floatingActionButton: defaultFloatingButton(
            isSmall: cubit.isBottomSheetShown ? true : false,
            btnColor:
                cubit.isBottomSheetShown ? Colors.grey[600] : defaultColor,
            btnChild: cubit.isBottomSheetShown
                ? Icon(
                    Icons.close,
                    size: 20,
                  )
                : Icon(
                    Icons.add,
                    size: 30,
                  ),
            onpressed: () {
              if (cubit.isBottomSheetShown) {
                Navigator.pop(context);
                cubit.changeBottomSheetState();
                taskController.text="";
                AppCubit.get(context).formatedDate="";
                AppCubit.get(context).formatedTime="";
              } else {
                scaffoldKey.currentState?.showBottomSheet(
                  enableDrag: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    backgroundColor: secondColor, (context) {
                  return BuildBottomSheet();
                });
                cubit.changeBottomSheetState();
              }
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tasks",
                  style: TextStyle(
                      color: defaultColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) => Dismissible(

                          key: Key((cubit.newTasks[i]['id']).toString()),
                          background: Container(
                            color: Colors.red[900],
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 20.0),
                                    child: Icon(
                                      Icons.delete_forever,
                                      size: 35,
                                    ),
                                  )
                                ]),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            cubit.deleteFromDatabase(
                                id: cubit.newTasks[i]['id']);
                            cubit.newTasks.removeAt(i);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: secondColor,
                            ),
                            height: 70,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                    onPressed: () {
                                      cubit.updateDataFromDataBase(
                                          id: cubit.newTasks[i]['id'],
                                          status: 'done');
                                    },
                                    icon: Icon(
                                      Icons.circle_outlined,
                                      color: Colors.white60,
                                      size: 28,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cubit.newTasks[i]['title'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        if (cubit.newTasks[i]['date'] != "" &&
                                            cubit.newTasks[i]['time'] != "")
                                          Row(children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: 11,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  cubit.newTasks[i]['date'],
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.alarm,
                                                  size: 11,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  cubit.newTasks[i]['time'],
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                )
                                              ],
                                            )
                                          ])
                                        else if (cubit.newTasks[i]['time'] !=
                                            "")
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.alarm,
                                                size: 11,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                cubit.newTasks[i]['time'],
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              )
                                            ],
                                          )
                                        else if (cubit.newTasks[i]['date'] !=
                                            "")
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.calendar_month_outlined,
                                                size: 11,
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                cubit.newTasks[i]['date'],
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.changeFavIconState(
                                        id: cubit.newTasks[i]['id'],
                                        favState: cubit.newTasks[i]
                                            ['favourite']);
                                  },
                                  icon: cubit.newTasks[i]['favourite'] == 'yes'
                                      ? Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        )
                                      : Icon(
                                          Icons.star_border_outlined,
                                          color: Colors.white70,
                                        ),
                                  splashRadius: 1,
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.updateDataFromDataBase(
                                        id: cubit.newTasks[i]['id'],
                                        status: 'archived');
                                  },
                                  icon: Icon(
                                    Icons.archive,
                                    color: Colors.white70,
                                    size: 22,
                                  ),
                                  splashRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                    separatorBuilder: (context, i) => SizedBox(
                          height: 3,
                        ),
                    itemCount: cubit.newTasks.length)
              ],
            ),
          ),
        );
      },
    );
  }
}
