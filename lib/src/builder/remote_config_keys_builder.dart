import 'package:code_builder/code_builder.dart';
import 'package:remote_config_generator/src/model/remote_config_response_data.dart';
import 'package:remote_config_generator/src/util/case_util.dart';
import 'package:remote_config_generator/src/util/extensions/spec_extension.dart';

class RemoteConfigKeysBuilder {
  RemoteConfigKeysBuilder._();

  static String build({required List<RemoteConfigParameter> parameters}) {
    final properties =
        parameters.map((e) {
          return Field(
            (b) =>
                b
                  ..name = CaseUtil(e.key).camelCase
                  ..static= true
                  ..type = refer('String')
                  ..modifier = FieldModifier.constant
                  ..assignment = Code("'${e.key}'"),
          );
        }).toList();

    final keyClass = Class(
      (keyClass) =>
          keyClass
            ..name = 'RemoteConfigKeys'
            ..fields.addAll(properties),
    );

    return keyClass.toDart();
  }
}
