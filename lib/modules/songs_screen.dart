import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:spotifyfirebase/appcubit/cubit.dart';
import 'package:spotifyfirebase/appcubit/state.dart';
import 'package:spotifyfirebase/components/components.dart';

class SongsScreen extends StatelessWidget {
  const SongsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Conditional.single(
            context: context,
            fallbackBuilder: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
            conditionBuilder: (context) => cubit.songs.isNotEmpty,
            widgetBuilder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                            width: double.infinity,
                          ),
                        ),
                        itemCount: cubit.songs.length,
                        itemBuilder: (context, index) {
                          return songsListBuilder(
                            cubit.songs[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}


