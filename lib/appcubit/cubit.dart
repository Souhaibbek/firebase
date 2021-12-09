import 'package:bloc/bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyfirebase/appcubit/state.dart';
import 'package:spotifyfirebase/models/albums_models.dart';
import 'package:spotifyfirebase/models/artists_models.dart';
import 'package:spotifyfirebase/models/songs_models.dart';
import 'package:spotifyfirebase/models/user_model.dart';
import 'package:spotifyfirebase/modules/albums_screen.dart';
import 'package:spotifyfirebase/modules/artists_screen.dart';
import 'package:spotifyfirebase/modules/songs_screen.dart';
import 'package:spotifyfirebase/modules/submodules/albumsongs.dart';
import 'package:spotifyfirebase/modules/submodules/artistsongs.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> titles = [
    'All Songs',
    'Artists',
    'Albums',
    'Artist Details',
    'Album Details'
  ];
  List<Widget> screens = [
    SongsScreen(),
    ArtistsScreen(),
    AlbumsScreen(),
    ArtistSongs(),
    AlbumSongs(),
  ];

  List<BottomNavyBarItem> items = [
    BottomNavyBarItem(
      icon: Icon(Icons.mic),
      title: Text('Songs'),
      activeColor: Colors.white,
      inactiveColor: Colors.white38,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.person),
      title: Text('Artists'),
      activeColor: Colors.white,
      inactiveColor: Colors.white38,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.menu),
      title: Text('Albums'),
      activeColor: Colors.white,
      inactiveColor: Colors.white38,
    ),
  ];

  void changeBotNavBarState(index) {
    currentIndex = index;
    emit(BotNavBarChangeState());
  }

  ArtistsModel? artistsModel;
  List<ArtistsModel> artists = [];

  Map<String, bool> favorites = {};

  void changeFav(String id) {
    if (favorites[id] == null) {
      favorites.addAll({id: true});
      emit(ChangeFavoriteArtistState());
    } else {
      if (favorites[id] == true) {
        favorites[id] = false;
        emit(ChangeFavoriteArtistState());
      } else {
        favorites[id] = true;
        emit(ChangeFavoriteArtistState());
      }
    }
  }

  void getAllArtists() {
    emit(GetAllArtistsLoadingState());
    FirebaseFirestore.instance.collection('artists').get().then((value) {
      for (var element in value.docs) {
        artists.add(ArtistsModel.fromJson(element.data()));
      }
      emit(GetAllArtistsSuccessState());
    }).catchError((error) {
      emit(GetAllArtistsErrorState(error));
    });
  }

  AlbumsModel? albumsModel;
  List<AlbumsModel> albums = [];

  void getAllAlbums() {
    emit(GetAllAlbumsLoadingState());
    FirebaseFirestore.instance.collection('albums').get().then((value) {
      for (var element in value.docs) {
        albums.add(AlbumsModel.fromJson(element.data()));
      }
      emit(GetAllAlbumsSuccessState());
    }).catchError((error) {
      emit(GetAllAlbumsErrorState(error));
    });
  }

  SongsModel? songsModel;
  List<SongsModel> songs = [];

  void getAllSongs() {
    emit(GetAllSongsLoadingState());
    FirebaseFirestore.instance.collection('songs').get().then((value) {
      for (var element in value.docs) {
        songs.add(SongsModel.fromJson(element.data()));
      }
      emit(GetAllSongsSuccessState());
    }).catchError((error) {
      emit(GetAllSongsErrorState(error));
    });
  }

  List<SongsModel> songsAr = [];

  getArtistSongs(
    String artistName,
  ) {
    songsAr = [];
    emit(GetArtistSongsLoadingState());
    FirebaseFirestore.instance
        .collection('songs')
        .where("artist", isEqualTo: artistName)
        .get()
        .then((value) {
      for (var element in value.docs) {
        songsAr.add(SongsModel.fromJson(element.data()));
      }
      emit(GetArtistSongsSuccessState());
    }).catchError((error) {
      emit(GetArtistSongsErrorState(error));
    });
  }

  List<SongsModel> songsAl = [];

  getAlbumSongs(
    String albumName,
  ) {
    songsAl = [];
    emit(GetAlbumSongsLoadingState());
    FirebaseFirestore.instance
        .collection('songs')
        .where("album", isEqualTo: albumName)
        .get()
        .then((value) {
      for (var element in value.docs) {
        songsAl.add(SongsModel.fromJson(element.data()));
      }
      emit(GetAlbumSongsSuccessState());
    }).catchError((error) {
      emit(GetAlbumSongsErrorState(error));
    });
  }

  UserModel? usModel;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  void setFavorites({
    required String uid,
    required String id,
  }) {
    changeFav(id);
    UserModel userModel = UserModel(
      uid: uid,
      favorites: favorites,
    );
    FirebaseFirestore.instance
        .collection('users_fav_artists')
        .doc(uid)
        .set(userModel.toJson())
        .then((value) {
          
      emit(UserCreateSuccessState());
    }).catchError((error) {
      emit(UserCreateErrorState(error));
    });
  }

  Map getFav = {};

  void getFavorites() {
    FirebaseFirestore.instance
        .collection('users_fav_artists')
        .doc(uid)
        .get()
        .then((value) {
      print('**********');
      print(value.get('favorites'));
      getFav=value.get('favorites');
      print('hgygyh $getFav');

    }).catchError((error) {});
  }
}
