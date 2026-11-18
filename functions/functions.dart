import '../Classes/line.dart';

Map<String, Map<String, dynamic>> inAnyLine(
    String firstStation, String lastStation) {
  Map<String, Map<String, dynamic>> linesWithStation = {};
  for (var line in line.lisnes) {
    for (var i = 0; i < line.stations.length; i++) {
      if (line.stations[i].name == firstStation ||
          line.stations[i].name == lastStation) {
        linesWithStation[line.stations[i].name] = {
          'LineName': line.name,
          'StationIndex': i
        };
      }
      if (linesWithStation.length == 2) {
        break;
      }
    }
  }
  return linesWithStation;
}

bool isInSameLine(Map<String, Map<String, dynamic>> linesWithStation) {
  return linesWithStation.length == 2 &&
      linesWithStation.values.every((line) =>
          line['LineName'] == linesWithStation.values.first['LineName']);
}

String getRouteFromOneLine(Map<String, Map<String, dynamic>> linesWithStation) {
  for (var line in line.lisnes) {
    if (line.name == linesWithStation.values.first['LineName']) {
      int firstStationIndex = linesWithStation.values.first['StationIndex'];
      int lastStationIndex = linesWithStation.values.last['StationIndex'];

      List<String> routeStations = line.stations
          .sublist(firstStationIndex, lastStationIndex + 1)
          .map((station) => station.name)
          .toList();
      if (firstStationIndex < lastStationIndex) {
        routeStations = routeStations.reversed.toList();
      }
      return routeStations.join(' -> ');
    }
  }
  return 'No route found.';
}
