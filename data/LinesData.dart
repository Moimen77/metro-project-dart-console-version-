import '../Classes/line.dart';
import '../Classes/station.dart';

line line1 = line(
    lineId: 1,
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
    ]);

line line2 = line(
    lineId: 2,
    directions: ['Shubra El Kheima', 'El Moneeb'],
    name: 'Line 2',
    stations: [
      Station(name: 'Sakyet Mekky'),
      Station(name: 'Om El Masryeen'),
      Station(name: 'Giza'),
      Station(name: 'Opera'),
      interchangeStation(name: 'El Sadat', connectinglines: [1, 2]),
    ]);

line line3 = line(
    lineId: 3,
    directions: ['Adly Mansour', 'Rod El Farag Corr.'],
    name: 'Line 3',
    stations: [
      Station(name: 'Ring Road'),
      Station(name: 'El- Qawmia '),
      Station(name: 'El- Bohy'),
      Station(name: 'Imbaba'),
      Station(name: 'Sudan'),
      interchangeStation(
          name: 'Kit-Kat', connectinglines: []), // from kitkat to faisal
      Station(name: 'Safaa Hegazy'),
    ]);
