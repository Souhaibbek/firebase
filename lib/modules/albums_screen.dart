import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:spotifyfirebase/appcubit/cubit.dart';
import 'package:spotifyfirebase/appcubit/state.dart';
import 'package:spotifyfirebase/models/albums_models.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

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
            conditionBuilder: (context) => cubit.albums.isNotEmpty,
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
                        itemCount: cubit.albums.length,
                        itemBuilder: (context, index) {
                          return albumsListBuilder(
                            cubit.albums[index],context,
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

Widget albumsListBuilder(
  AlbumsModel? model,
  context,
) {
  return InkWell(
    onTap: () {
      AppCubit.get(context).currentIndex = 4;
      AppCubit.get(context).getAlbumSongs(model!.name);
    },
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(model!.img),
          radius: 40.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            Text(model.artistname),
          ],
        ),
      ],
    ),
  );
}
