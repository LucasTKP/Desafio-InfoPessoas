import 'street_model.dart';

class LocationModel {
  final StreetModel street;
  final String city;
  final String state;
  final String country;
  final String postcode;

  LocationModel({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    street: StreetModel.fromJson(json['street'] as Map<String, dynamic>),
    city: json['city'] as String,
    state: json['state'] as String,
    country: json['country'] as String,
    postcode: json['postcode'].toString(),
  );

  Map<String, dynamic> toJson() => {
    'street': street.toJson(),
    'city': city,
    'state': state,
    'country': country,
    'postcode': postcode,
  };
}
