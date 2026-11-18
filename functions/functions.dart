import '../Classes/line.dart';
import '../Classes/stationLocation.dart';
import '../data/LinesData.dart';

bool isInSameLine(String station1, String station2) {
  final stationLocations1 = stationsIndex[station1]!.first;
  final stationLocations2 = stationsIndex[station2]!.first;

  return stationLocations1.lineId == stationLocations2.lineId;
}

String getRouteFromOneLine(String station1, String station2) {
  final stationLocations1 = stationsIndex[station1]!.first;
  final stationLocations2 = stationsIndex[station2]!.first;

  for (var metroLine in line.lisnes) {
    if (metroLine.lineId == stationLocations1.lineId &&
        metroLine.lineId == stationLocations2.lineId) {
      final firstIndex = stationLocations1.stationIndex;
      final lastIndex = stationLocations2.stationIndex;

      final startIndex = firstIndex < lastIndex ? firstIndex : lastIndex;
      final endIndex = firstIndex > lastIndex ? firstIndex : lastIndex;

      List<String> routeStations = metroLine.stations
          .sublist(startIndex, endIndex + 1)
          .map((station) => station.name)
          .toList();

      if (firstIndex > lastIndex) {
        routeStations = routeStations.reversed.toList();
      }

      return routeStations.join(' -> ');
    }
  }

  return 'No route found.';
}

void buildStationsIndex() {
  for (var line in line.lisnes) {
    for (var i = 0; i < line.stations.length; i++) {
      final stationName = line.stations[i].name.trim();

      stationsIndex.putIfAbsent(stationName, () => []);

      stationsIndex[stationName]!.add(
        StationLocation(
          lineId: line.lineId,
          stationIndex: i,
        ),
      );
    }
  }
}
