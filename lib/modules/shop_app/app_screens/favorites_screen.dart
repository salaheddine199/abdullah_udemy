import 'package:abdullah_mansour/layout/shop_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/shop_app/cubit/states.dart';
import 'package:abdullah_mansour/models/shop_app/get_fav_model.dart';
import 'package:abdullah_mansour/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        GetFavoriteModel _getFavModel = ShopCubit.get(context).favModel;

        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavState,
          builder: (context)=> ListView.separated(
            itemBuilder:(context, index)=> _BuildFavItem(_getFavModel.data.data[index].product),
            separatorBuilder:(context, index)=> const SizedBox(height: 20.0,),
            itemCount: _getFavModel.data.data.length,//ShopCubit.get(context).categoryModel.data.data.length,
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class _BuildFavItem extends StatelessWidget {
  final Product model;
  const _BuildFavItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  height: 120.0,
                  width: 120.0,
                ),
                if (model.discount != 0)
                  Container(
                    width: 50,
                    color: Colors.red,
                    child: Text(
                      'discount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
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
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 11,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          print(model.id);
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        //iconSize: 19,
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:  ShopCubit.get(context).favorites[model.id]
                              ? defaultColor
                              : Colors.grey,
                          child: Icon(Icons.favorite_border, size: 14,color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
