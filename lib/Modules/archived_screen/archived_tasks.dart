import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Shared/components/constants.dart';
import 'package:todo_app/Shared/cubit/cubit.dart';
import 'package:todo_app/Shared/cubit/states.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        List<Map> archivedTasks = AppCubit.get(context).archivedTasks;
        AppCubit cubit = AppCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Archived Tasks",
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
                    key: Key((cubit.archivedTasks[i]['id']).toString()),
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
                          id: cubit.archivedTasks[i]['id']);
                      cubit.archivedTasks.removeAt(i);
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
                                cubit.updateDataFromDataBase(id: cubit.archivedTasks[i]['id'],status: 'done');
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    archivedTasks[i]['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  if (cubit.archivedTasks[i]['date'] !="" && cubit.archivedTasks[i]['time'] !="")
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
                                            archivedTasks[i]['date'],
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200),
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
                                            archivedTasks[i]['time'],
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200),
                                          )
                                        ],
                                      )
                                    ])
                                  else if (cubit.archivedTasks[i]['time'] !="")
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
                                          archivedTasks[i]['time'],
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w200),
                                        )
                                      ],
                                    )
                                  else if (cubit.archivedTasks[i]['date'] !="")
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
                                            archivedTasks[i]['date'],
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
                              cubit.changeFavIconState(id: archivedTasks[i]['id'],favState: archivedTasks[i]['favourite']);
                            },
                            icon: archivedTasks[i]['favourite']=='yes'?Icon(
                              Icons.star,
                              color: defaultColor,

                            ):Icon(
                              Icons.star_border_outlined,
                              color: Colors.white70,
                            )
                            ,
                            splashRadius: 1,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.updateDataFromDataBase(id: cubit.archivedTasks[i]['id'],status: 'new');
                            },
                            icon:Icon(
                              Icons.archive,
                              color: defaultColor,
                            )
                            ,
                            splashRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, i) => SizedBox(
                    height: 3,
                  ),
                  itemCount: archivedTasks.length),
            ],
          ),
        );

      },
    );
  }
}
