import '../Classes/line.dart';

Map<String, int> inAnyLine(String firstStation, String lastStation) {
  Map<String, int> linesWithStation = {};
  for (var line in line.lisnes) {
    for (var i = 0; i < line.stations.length; i++) {
      if (line.stations[i].name == firstStation ||
          line.stations[i].name == lastStation) {
        linesWithStation[line.name] = i;
        break;
      }
    }
  }
  return linesWithStation;
}

bool isInSameLine(Map<String, int> linesWithStation) {
  return linesWithStation.length == 1;
}
