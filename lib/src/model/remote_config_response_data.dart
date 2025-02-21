class RemoteConfigResponse {
  final String versionNumber;
  final List<RemoteConfigParameter> parameters;
  final DateTime updateTime;
  final String updateUser;
  final String updateOrigin;
  final String updateType;

  RemoteConfigResponse({
    required this.parameters,
    required this.versionNumber,
    required this.updateTime,
    required this.updateUser,
    required this.updateOrigin,
    required this.updateType,
  });

  factory RemoteConfigResponse.fromJson(Map<String, dynamic> json) {
    var params = (json['parameters'] as Map<String, dynamic>).entries.map((entry) => RemoteConfigParameter.fromJson(name: entry.key, json: entry.value)).toList();

    return RemoteConfigResponse(
      parameters: params,
      versionNumber: json['version']['versionNumber'],
      updateTime: DateTime.parse(json['version']['updateTime']),
      updateUser: json['version']['updateUser']['email'],
      updateOrigin: json['version']['updateOrigin'],
      updateType: json['version']['updateType'],
    );
  }
}

class RemoteConfigParameter {
  final dynamic defaultValue;
  final ValueType valueType;
  final String key;

  RemoteConfigParameter({required this.defaultValue, required this.valueType, required this.key});

  factory RemoteConfigParameter.fromJson({required Map<String, dynamic> json, required String name}) {
    return RemoteConfigParameter(defaultValue: json['defaultValue']['value'], valueType: _parseValueType(json['valueType']), key: name);
  }

  static ValueType _parseValueType(String value) => ValueType.values.firstWhere((type) => type.jsonKey == value, orElse: () => ValueType.string);

  String get dartTypeString => switch (valueType) {
    ValueType.number => 'double',
    ValueType.string => 'String',
    ValueType.boolean => 'bool',
    ValueType.json => 'Map<String, dynamic>',
  };
}

enum ValueType {
  number('NUMBER'),
  string('STRING'),
  boolean('BOOLEAN'),
  json('JSON');

  final String jsonKey;
  const ValueType(this.jsonKey);
}
