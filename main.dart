import 'functions/functions.dart';

void main() {
  Map<String, Map<String, dynamic>> linesWithStation =
      inAnyLine('Dar El Salam', 'Elmasraa');
  print(linesWithStation);
  if (isInSameLine(linesWithStation)) {
    print(
        'The stations are in the same line: ${linesWithStation.values.first['LineName']}');
  } else {
    print(
        'The stations are in different lines: ${linesWithStation.values.map((v) => v['LineName']).join(', ')}');
  }
  print(getRouteFromOneLine(linesWithStation));
}
