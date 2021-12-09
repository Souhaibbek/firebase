import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyfirebase/appcubit/cubit.dart';
import 'package:spotifyfirebase/appcubit/state.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getAllArtists()..getAllAlbums()..getAllSongs()..getFavorites(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is BotNavBarChangeState){
            print(AppCubit.get(context).getFav);
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            bottomNavigationBar: BottomNavyBar(
              backgroundColor: Colors.indigo,
              selectedIndex: cubit.currentIndex,
              items: cubit.items,
              onItemSelected: (int value) {
                cubit.changeBotNavBarState(value);
              },
            ),

            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
