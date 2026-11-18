import '../data/LinesData.dart';
import 'station.dart';

class line {
  final String name;
  final List<Station> stations;
  final List<String> directions;

  line({required this.directions, required this.name, required this.stations});

  static List<line> lisnes = [line1, line2, line3];
}
