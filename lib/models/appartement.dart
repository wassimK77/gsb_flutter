class Appartement {
  final int NUMAPPART;
  final String RUE;
  final String ARRONDISSE;
  final int ETAGE;
  final String PRIX_LOC;
  final String PRIX_CHARG;
  final int ASCENSEUR;
  final int PREAVIS;
  final String DATE_LIBRE;
  final int NUMEROPROP;
  final String PAYS;
  final String VILLE;
  final String REGION;

  Appartement({
    required this.NUMAPPART,
    required this.RUE,
    required this.ARRONDISSE,
    required this.ETAGE,
    required this.PRIX_LOC,
    required this.PRIX_CHARG,
    required this.ASCENSEUR,
    required this.PREAVIS,
    required this.DATE_LIBRE,
    required this.NUMEROPROP,
    required this.PAYS,
    required this.VILLE,
    required this.REGION,
  });

  factory Appartement.fromJson(Map<String, dynamic> json) {
    return Appartement(
      NUMAPPART: int.tryParse(json['NUMAPPART'].toString()) ?? 0,
      RUE: json['RUE']?.toString() ?? '',
      ARRONDISSE: json['ARRONDISSE']?.toString() ?? '',
      ETAGE: int.tryParse(json['ETAGE'].toString()) ?? 0,
      PRIX_LOC: json['PRIX_LOC']?.toString() ?? '0',
      PRIX_CHARG: json['PRIX_CHARG']?.toString() ?? '0',
      ASCENSEUR: int.tryParse(json['ASCENSEUR'].toString()) ?? 0,
      PREAVIS: int.tryParse(json['PREAVIS'].toString()) ?? 0,
      DATE_LIBRE: json['DATE_LIBRE']?.toString() ?? '',
      NUMEROPROP: int.tryParse(json['NUMEROPROP'].toString()) ?? 0,
      PAYS: json['PAYS']?.toString() ?? '',
      VILLE: json['VILLE']?.toString() ?? '',
      REGION: json['REGION']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'NUMAPPART': NUMAPPART,
      'RUE': RUE,
      'ARRONDISSE': ARRONDISSE,
      'ETAGE': ETAGE,
      'PRIX_LOC': PRIX_LOC,
      'PRIX_CHARG': PRIX_CHARG,
      'ASCENSEUR': ASCENSEUR,
      'PREAVIS': PREAVIS,
      'DATE_LIBRE': DATE_LIBRE,
      'NUMEROPROP': NUMEROPROP,
      'PAYS': PAYS,
      'VILLE': VILLE,
      'REGION': REGION,
    };
  }
}