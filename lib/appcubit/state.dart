import 'package:firebase_auth/firebase_auth.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class BotNavBarChangeState extends AppStates {}

class GetAllArtistsSuccessState extends AppStates {}

class GetAllArtistsLoadingState extends AppStates {}

class GetAllArtistsErrorState extends AppStates {
  final TypeError error;

  GetAllArtistsErrorState(this.error);
}

class GetAllAlbumsSuccessState extends AppStates {}

class GetAllAlbumsLoadingState extends AppStates {}

class GetAllAlbumsErrorState extends AppStates {
  final TypeError error;

  GetAllAlbumsErrorState(this.error);
}

class GetAllSongsSuccessState extends AppStates {}

class GetAllSongsLoadingState extends AppStates {}

class GetAllSongsErrorState extends AppStates {
  final TypeError error;

  GetAllSongsErrorState(this.error);
}

class GetArtistSongsSuccessState extends AppStates {}

class GetArtistSongsLoadingState extends AppStates {}

class GetArtistSongsErrorState extends AppStates {
  final TypeError error;

  GetArtistSongsErrorState(this.error);
}

class GetAlbumSongsSuccessState extends AppStates {}

class GetAlbumSongsLoadingState extends AppStates {}

class GetAlbumSongsErrorState extends AppStates {
  final TypeError error;

  GetAlbumSongsErrorState(this.error);
}

class ChangeFavoriteArtistState extends AppStates{}

class UserCreateSuccessState extends AppStates {

}

class UserCreateErrorState extends AppStates {
  final FirebaseAuthException error;
  UserCreateErrorState(this.error);
}