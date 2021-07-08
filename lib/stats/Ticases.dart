class TI_cases {
  var total;
  var discharged;
  var deaths;
  var confirmedCasesIndian;
  var confirmedCasesForeign;
  var confirmedButLocationUnidentified;

  TI_cases(
      {this.total,
      this.discharged,
      this.deaths,
      this.confirmedCasesIndian,
      this.confirmedCasesForeign,
      this.confirmedButLocationUnidentified});

  factory TI_cases.fromJson(final json) {
    return TI_cases(
        total: json["total"],
        discharged: json["discharged"],
        deaths: json["deaths"],
        confirmedCasesIndian: json["confirmedCasesIndian"],
        confirmedCasesForeign: json["confirmedCasesForeign"],
        confirmedButLocationUnidentified:
            json["confirmedButLocationUnidentified"]);
  }
}
