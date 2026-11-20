import 'dart:io';

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

double TripMoney(int StationsCount) {
  switch (StationsCount) {
    case <= 9:
      return 10;
    case <= 16:
      return 12;
    case <= 23:
      return 15;
    case <= 39:
      return 20;
    default:
      return 0;
  }
}

double TripTime(int StationsCount) {
  return StationsCount * 2.5;
}

void printMenu() {
  int choice;
  print('Welcome to the Metro Route Finder!');
  print('1. Find route between two stations');
  print('2. Exit');
  choice = int.parse(stdin.readLineSync()!);
  switch (choice) {
    case 1:
      findRouteBetweenStations();
      break;
    case 2:
      print('Exiting the program. Goodbye!');
      exit(0);
    default:
      print('Invalid choice. Please try again.');
  }
}

void findRouteBetweenStations() {
  print('Enter the starting station:');
  String startStation = stdin.readLineSync()!.trim();
  print('Enter the destination station:');
  String endStation = stdin.readLineSync()!.trim();

  if (!stationsIndex.containsKey(startStation)) {
    print('Starting station not found.');
    return;
  }

  if (!stationsIndex.containsKey(endStation)) {
    print('Destination station not found.');
    return;
  }

  if (isInSameLine(startStation, endStation)) {
    String route = getRouteFromOneLine(startStation, endStation);
    print('Route: $route');
    print(
        'Trip Time: ${TripTime(route.split(' -> ').length).toStringAsFixed(2)} minutes');
    print('Trip Price: ${TripMoney(route.split(' -> ').length)} EGP');
  } else {
    List<String>? route = getRouteWithInterchange2(startStation, endStation);
    if (route != null) {
      print('Trip Time: ${TripTime(route.length).toStringAsFixed(2)} minutes');
      print('Trip Price: ${TripMoney(route.length)} EGP');
    }
  }
}

void powerApp() {
  String choice = '';
  do {
    printMenu();
    print('Enter your choice (Y or N):');
    choice = stdin.readLineSync()!.trim();
  } while (choice.toUpperCase() == 'Y');
}
