import 'package:abdullah_mansour/layout/shop_app/cubit/cubit.dart';
import 'package:abdullah_mansour/models/shop_app/search_model.dart';
import 'package:abdullah_mansour/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  var _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return SearchCubit();
      },
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsetsDirectional.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    defaultFormField(
                      validFun: (String value) {
                        if (value.isEmpty)
                          return 'please type something to search';
                        return null;
                      },
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      text: 'Search',
                      keyBoardType: TextInputType.text,
                      controller: _searchController,
                      prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    if(state  is SearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => _BuildSearchItem(
                            SearchCubit.get(context).model.data.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20.0,
                        ),
                        itemCount: SearchCubit.get(context).model.data.data.length,
                      ),
                    ),

                    // ConditionalBuilder(
                    //   condition: SearchCubit.get(context).model != null,
                    //   builder: (context) => ListView.separated(
                    //     itemBuilder: (context, index) => BuildFavoriteItem(
                    //         SearchCubit.get(context).model.data.data[index]),
                    //     separatorBuilder: (context, index) => const SizedBox(
                    //       height: 20.0,
                    //     ),
                    //     itemCount:
                    //         SearchCubit.get(context).model.data.data.length,
                    //   ),
                    //   fallback: (context) =>
                    //       Center(child: CircularProgressIndicator()),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BuildSearchItem extends StatelessWidget {
  final Product model;
  const _BuildSearchItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 120.0,
              width: 120.0,
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: defaultColor,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     CircleAvatar(
                  //       radius: 15.0,
                  //       backgroundColor:  ShopCubit.get(context).favorites[model.id]
                  //           ? defaultColor
                  //           : Colors.grey,
                  //       child: Icon(Icons.favorite_border, size: 14,color: Colors.white,),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
