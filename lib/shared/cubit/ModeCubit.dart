import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/Network/local/cachHelper.dart';

import 'ModeStates.dart';
import 'States.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(IntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark=false;

  void changeAppMode({bool ? fromShared})
  {
    if(fromShared!=null)
      {
        isDark=fromShared;
        emit(AppChangeNewsMode());

      }
      else
        {
          isDark= !isDark;
          cacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
          {
            emit(AppChangeNewsMode());
          });
        }


  }
}