import 'package:netflix_clone/models/BackGroundImage.dart';
import 'package:netflix_clone/models/Genres.dart';
import 'package:netflix_clone/models/LogoImage.dart';
import 'package:netflix_clone/models/cast.dart';

class JawSummary {
  final String title;
  final Cast cast;
  final Genres genres;
  final String description;
  final LogoImage logoimage;
  final BackGroundImage backGroundImage;

  JawSummary({
    required this.title,
    required this.cast,
    required this.genres,
    required this.description,
    required this.logoimage,
    required this.backGroundImage 
  });
}
