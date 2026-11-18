import 'functions/functions.dart';

void main() {
  Map<String, int> linesWithStation = inAnyLine('Ain Helwan', 'Sakyet Mekky');
  if (isInSameLine(linesWithStation)) {
    print('The stations are in the same line: ${linesWithStation.keys.first}');
  } else {
    print(
        'The stations are in different lines: ${linesWithStation.keys.join(', ')}');
  }
}
