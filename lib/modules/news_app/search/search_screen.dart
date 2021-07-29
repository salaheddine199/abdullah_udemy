import 'package:abdullah_mansour/layout/new_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/new_app/cubit/states.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  validFun: (String value) {
                    if (value.length == 0)
                      return 'please type something to search';
                    return null;
                  },
                  onChange: (String value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  text: 'search',
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  keyBoardType: TextInputType.text,
                  controller: searchController,
                  prefix: Icons.search,
                ),
              ),
              Expanded(
                child:
                    // list.length==0
                    // ?Center(child: Text("Nothing"),) :
                articleBuilder(list, context,isSearch: true,),
              ),
            ],
          ),
        );
      },
    );
  }
}
