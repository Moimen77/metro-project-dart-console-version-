import '../Classes/line.dart';
import '../Classes/station.dart';
import '../Classes/stationLocation.dart';
import '../data/LinesData.dart';

bool isInSameLine(String station1, String station2) {
  final stationLocations1 = stationsIndex[station1]!.first;
  final stationLocations2 = stationsIndex[station2]!.first;

  return stationLocations1.lineId == stationLocations2.lineId;
}

String getRouteFromOneLine(String station1, String station2) {
  final stationLocations1 = stationsIndex[station1]!;
  final stationLocations2 = stationsIndex[station2]!;

  final commonLocation = stationLocations1.where((loc1) {
    return stationLocations2.any(
      (loc2) => loc1.lineId == loc2.lineId,
    );
  }).firstOrNull;

  if (commonLocation == null) {
    return 'No common line found.';
  }

  final firstLocation = commonLocation;

  final secondLocation = stationLocations2.firstWhere(
    (loc) => loc.lineId == firstLocation.lineId,
  );

  for (var metroLine in line.lisnes) {
    if (metroLine.lineId == firstLocation.lineId &&
        metroLine.lineId == secondLocation.lineId) {
      final firstIndex = firstLocation.stationIndex;
      final lastIndex = secondLocation.stationIndex;

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

void getRouteWithInterchange(String station1, String station2) {
  final stationLocations1 = stationsIndex[station1]!.first;
  final stationLocations2 = stationsIndex[station2]!.first;

  final lineStation1 = stationLocations1.lineId;
  final lineStation2 = stationLocations2.lineId;

  final lineStationIndex1 = stationLocations1.stationIndex;

  for (var metroLine in line.lisnes) {
    if (metroLine.lineId == lineStation1) {
      for (var i = lineStationIndex1; i < metroLine.stations.length; i++) {
        final station = metroLine.stations[i];
        if (station is interchangeStation) {
          final connectingLines = station.connectinglines;
          if (connectingLines.contains(lineStation2)) {
            final routeToInterchange =
                getRouteFromOneLine(station1, station.name);
            final routeFromInterchange =
                getRouteFromOneLine(station.name, station2);

            print(
                'Route from $station1 to ${station.name}: $routeToInterchange');
            print(
                'Route from ${station.name} to $station2: $routeFromInterchange');
            return;
          }
        }
      }
    }
  }

  print('No route found with interchange.');
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
