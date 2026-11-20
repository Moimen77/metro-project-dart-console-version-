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

List<String>? getRouteWithInterchange2(String station1, String station2) {
  final stationLocations1 = stationsIndex[station1]!;
  final stationLocations2 = stationsIndex[station2]!;

  List<String>? bestRoute;
  String? bestInterchange;
  int minStations = 999999;

  for (final location1 in stationLocations1) {
    for (final location2 in stationLocations2) {
      if (location1.lineId == location2.lineId) continue;

      final startLine = line.lisnes.firstWhere(
        (l) => l.lineId == location1.lineId,
      );

      for (int i = 0; i < startLine.stations.length; i++) {
        final station = startLine.stations[i];

        if (station is interchangeStation &&
            station.connectinglines.contains(location2.lineId)) {
          final route1 = getRouteFromOneLine(
            station1,
            station.name,
          );

          final route2 = getRouteFromOneLine(
            station.name,
            station2,
          );

          if (route1 == 'No route found.' || route2 == 'No route found.') {
            continue;
          }

          final route = [
            ...route1.split(' -> '),
            ...route2.split(' -> ').skip(1),
          ];

          final stationCount = route.length;

          if (stationCount < minStations) {
            minStations = stationCount;
            bestRoute = route;
            bestInterchange = station.name;
          }
        }
      }
    }
  }

  if (bestRoute == null) {
    print('No route found with interchange.');
    return null;
  }

  print('Best Interchange: $bestInterchange');
  print('Best Route: ${bestRoute.join(' -> ')}');
  print('Total Stations: ${bestRoute.length}');
  return bestRoute;
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
