import 'station.dart';

class line {
  final String name;
  final List<Station> stations;
  final List<String> directions;

  line({required this.directions, required this.name, required this.stations});

  static List<line> lisnes = [
    line(
        directions: ['Helwan , New marg'],
        name: 'Line 1',
        stations: [
          Station(name: 'Ain Helwan'),
          Station(name: 'Helwan uni '),
          Station(name: 'Wadi hof'),
          Station(name: 'Hadaek Helwan'),
          Station(name: 'Elmasraa'),
          Station(name: 'Tura El Asmant'),
          Station(name: 'Kozzika'),
          Station(name: 'Tura El Balad'),
          Station(name: 'Sakanat El Maadi'),
          Station(name: 'El Maadi'),
          Station(name: 'Hadayek El Maadi'),
          Station(name: 'Dar El Salam'),
        ])
  ];
}
