import 'line.dart';

class Station {
  final String name;
  Station({required this.name});
}

class interchangeStation extends Station {
  final List<line> connectinglines;
  interchangeStation({required this.connectinglines, required super.name});
}
