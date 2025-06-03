class Maison {
  final int NUM_MAISON;
  final String RUE;
  final String ARRONDISSE;
  final int ETAGE;
  final String PRIX_LOC;
  final String PRIX_CHARG;
  final int PREAVIS;
  final String DATE_LIBRE;
  final int NUMEROPROP;
  final int JARDIN;
  final int SUPERFICIE;
  final int PISCINE;
  final int GARAGE;
  final String PAYS;
  final String VILLE;
  final String REGION;

  Maison({
    required this.NUM_MAISON,
    required this.RUE,
    required this.ARRONDISSE,
    required this.ETAGE,
    required this.PRIX_LOC,
    required this.PRIX_CHARG,
    required this.PREAVIS,
    required this.DATE_LIBRE,
    required this.NUMEROPROP,
    required this.JARDIN,
    required this.SUPERFICIE,
    required this.PISCINE,
    required this.GARAGE,
    required this.PAYS,
    required this.VILLE,
    required this.REGION,
  });

  factory Maison.fromJson(Map<String, dynamic> json) {
    return Maison(
      NUM_MAISON: int.tryParse(json['NUM_MAISON'].toString()) ?? 0,
      RUE: json['RUE']?.toString() ?? '',
      ARRONDISSE: json['ARRONDISSE']?.toString() ?? '',
      ETAGE: int.tryParse(json['ETAGE'].toString()) ?? 0,
      PRIX_LOC: json['PRIX_LOC']?.toString() ?? '0',
      PRIX_CHARG: json['PRIX_CHARG']?.toString() ?? '0',
      PREAVIS: int.tryParse(json['PREAVIS'].toString()) ?? 0,
      DATE_LIBRE: json['DATE_LIBRE']?.toString() ?? '',
      NUMEROPROP: int.tryParse(json['NUMEROPROP'].toString()) ?? 0,
      JARDIN: int.tryParse(json['JARDIN'].toString()) ?? 0,
      SUPERFICIE: int.tryParse(json['SUPERFICIE'].toString()) ?? 0,
      PISCINE: int.tryParse(json['PISCINE'].toString()) ?? 0,
      GARAGE: int.tryParse(json['GARAGE'].toString()) ?? 0,
      PAYS: json['PAYS']?.toString() ?? '',
      VILLE: json['VILLE']?.toString() ?? '',
      REGION: json['REGION']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'NUM_MAISON': NUM_MAISON,
      'RUE': RUE,
      'ARRONDISSE': ARRONDISSE,
      'ETAGE': ETAGE,
      'PRIX_LOC': PRIX_LOC,
      'PRIX_CHARG': PRIX_CHARG,
      'PREAVIS': PREAVIS,
      'DATE_LIBRE': DATE_LIBRE,
      'NUMEROPROP': NUMEROPROP,
      'JARDIN': JARDIN,
      'SUPERFICIE': SUPERFICIE,
      'PISCINE': PISCINE,
      'GARAGE': GARAGE,
      'PAYS': PAYS,
      'VILLE': VILLE,
      'REGION': REGION,
    };
  }
}