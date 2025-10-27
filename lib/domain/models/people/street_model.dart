class StreetModel {
  final String number;
  final String name;

  StreetModel({required this.number, required this.name});

  factory StreetModel.fromJson(Map<String, dynamic> json) => StreetModel(
    number: json['number'].toString(),
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'number': number,
    'name': name,
  };
}
