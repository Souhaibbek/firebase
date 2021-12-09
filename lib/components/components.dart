import 'package:flutter/material.dart';
import 'package:spotifyfirebase/models/songs_models.dart';

Widget songsListBuilder(
    SongsModel? model,
    ) {
  return Row(
    children: [
      CircleAvatar(
        backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/spotifyclone-8d4ad.appspot.com/o/songlogo.png?alt=media&token=c3a25979-37d4-47d2-9e64-2f3fbaf1e47d'),
        radius: 20.0,
        backgroundColor: Colors.white,
      ),
      const SizedBox(
        width: 10.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model!.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 5.0,),
          Row(
            children: [
              Container(
                color: Colors.grey,
                child: Text(
                  model.album,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 10.0,),
              Text(
                model.artist,
                style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w500),
              ),
            ],
          ),

        ],
      ),
    ],
  );
}


Widget defaultFormField({
  required String label,
  required TextInputType type,
  required TextEditingController controller,
  required IconData prefix,
  required validate,
  onChange,
  onTap,
  bool isPass = false,
  IconData? suffix,
  suffixPressed,
  bool isEnable = true,
  onSubmit,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: TextFormField(
      onChanged: onChange,
      controller: controller,
      validator: validate,
      keyboardType: type,
      obscureText: isPass,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      enabled: isEnable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffix),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );