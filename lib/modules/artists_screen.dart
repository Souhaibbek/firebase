import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:spotifyfirebase/appcubit/cubit.dart';
import 'package:spotifyfirebase/appcubit/state.dart';
import 'package:spotifyfirebase/models/artists_models.dart';

class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Conditional.single(
            context: context,
            fallbackBuilder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
            conditionBuilder: (context) => cubit.artists.isNotEmpty,
            widgetBuilder: (context) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                            width: double.infinity,
                          ),
                        ),
                        itemCount: cubit.artists.length,
                        itemBuilder: (context, index) {
                          return artistsListBuilder(
                              cubit.artists[index], context);
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

Widget artistsListBuilder(ArtistsModel? model, context) {
  return InkWell(
    onTap: () {
      AppCubit.get(context).currentIndex = 3;
      AppCubit.get(context).getArtistSongs(model!.name);
    },
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(model!.image),
          radius: 40.0,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          model.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            print(AppCubit.get(context).favorites);

            print('//////////');
            print(AppCubit.get(context).uid);
            AppCubit.get(context)
                .setFavorites(uid: AppCubit.get(context).uid,id:model.id);
            AppCubit.get(context).getFavorites();
          },
          icon: AppCubit.get(context).getFav[model.id] == true
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : Icon(Icons.favorite_border),
        ),
      ],
    ),
  );
}
