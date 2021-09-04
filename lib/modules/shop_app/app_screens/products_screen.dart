import 'package:abdullah_mansour/layout/shop_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/shop_app/cubit/states.dart';
import 'package:abdullah_mansour/models/shop_app/categories_model.dart';
import 'package:abdullah_mansour/models/shop_app/home_model.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavState){
          if(!state.model.status){
            showToast(text: state.model.message, color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        HomeModel homeModel = ShopCubit.get(context).homeModel;
        CategoryModel catModel = ShopCubit.get(context).categoryModel;

        return ConditionalBuilder(
          condition: homeModel != null && catModel != null,
          builder: (context) => ProductsBuilder(homeModel, catModel),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

// widgets we'll need:

// just trying make it better performance stless < function
class ProductsBuilder extends StatelessWidget {
  final HomeModel homeModel;
  final CategoryModel catModel;

  const ProductsBuilder(this.homeModel, this.catModel);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel.data.banners.map((e) {
              return Image(
                image: NetworkImage(
                  '${e.image}',
                ),
                //width: double.infinity,
                fit: BoxFit.fill,
              );
            }).toList(),
            options: CarouselOptions(
              height: 220,
              autoPlay: true,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 2),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.vertical,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        BuildCategoryItem(catModel.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.0,
                    ),
                    itemCount: catModel.data.data.length,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
            ),
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.48,
              children: List.generate(
                  homeModel.data.products.length,
                  (index) => BuildGridProduct(
                        homeModel.data.products[index],
                      )),
              // children: homeModel.data.products.map((e) {
              //   BuildGridProductFun(e);
              // }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildCategoryItem extends StatelessWidget {
  final DataModel dataModel;

  const BuildCategoryItem(this.dataModel);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(dataModel.image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.7),
          width: 100,
          child: Text(
            dataModel.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class BuildGridProduct extends StatelessWidget {
  final ProductModel product;

  const BuildGridProduct(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${product.image}'),
                  height: 180.0,
                  width: double.infinity,
                ),
                if (product.discount != 0)
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
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    product.name,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  height:
                      35, // Just for make the favorite icon is the same line always
                ),
                Row(
                  children: [
                    Text(
                      product.price.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (product.discount != 0)
                      Text(
                        product.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 11,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        print(product.id);
                        print(product.inFavorites);
                        ShopCubit.get(context).changeFavorites(product.id);
                      },
                      //iconSize: 19,
                      icon: CircleAvatar(
                        radius: 15.0,
                        // todo maybe the mistake is here try to send 'context'
                        backgroundColor: ShopCubit.get(context).favorites[product.id]? defaultColor: Colors.grey,
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
    );
  }
}
