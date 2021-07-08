class TCases {
  var cases;
  var deaths;
  var recovered;
  var updated;
  TCases({this.cases, this.deaths, this.recovered, this.updated});

  factory TCases.fromJson(final json) {
    return TCases(
      cases: json["cases"],
      deaths: json["deaths"],
      recovered: json["recovered"],
      updated: json["updated"],
    );
  }
}
