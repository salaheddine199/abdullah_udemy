import 'package:abdullah_mansour/layout/shop_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/shop_app/cubit/states.dart';
import 'package:abdullah_mansour/models/shop_app/categories_model.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        CategoryModel _catModel = ShopCubit.get(context).categoryModel;
        return ListView.separated(
          itemBuilder: (context, index) => _BuildCategoryItem(_catModel.data.data[index]),
          separatorBuilder: (context, index) => buildOurDivider(),
          itemCount: _catModel.data.data.length,
        );
      },
    );
  }
}


class _BuildCategoryItem extends StatelessWidget {
  final DataModel _catModel;

  const _BuildCategoryItem(this._catModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(_catModel.image),
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20.0,),
          Text(
            _catModel.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}

