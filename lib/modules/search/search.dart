
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/components/reusable_components.dart';
import 'package:news_application/shared/cubit/States.dart';
import 'package:news_application/shared/cubit/cubit.dart';

class SearchScreen extends StatelessWidget
{
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsAppCubit,NewsAppStates>(
      builder: (BuildContext context, state)
      {
        late var list = NewsAppCubit.get(context).search;
        return  Scaffold(

            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: deafultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      OnChange: (String value){
                        if (value == '' ){
                          NewsAppCubit.get(context).search =[];
                          NewsAppCubit.get(context).emit(NewsGetSearchLoadingState());
                        }
                        else {
                          NewsAppCubit.get(context).getSearch(value);
                        }
                      },
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'please enter word to search for';
                        }
                        return null;
                      },
                      label: 'search',
                      prefix: Icons.search
                  ),
                ),

                Expanded(child: articleBuilder(list, context,isSearch:true))

              ],
            )
        );

      },
      listener: (BuildContext context, Object? state) {  },

    );
  }

}