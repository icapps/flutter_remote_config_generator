import 'package:code_builder/code_builder.dart';
import 'package:remote_config_generator/src/model/config.dart';
import 'package:remote_config_generator/src/model/remote_config_response_data.dart';
import 'package:remote_config_generator/src/util/case_util.dart';
import 'package:remote_config_generator/src/util/extensions/spec_extension.dart';

class RemoteConfigDataBuilder {
  static String build({required  List<RemoteConfigParameter> parameters, required PubSpecConfig pubspec}) {
    final className = 'RemoteConfigData';
    final filteredParameters = parameters.where((param) => param.valueType != ValueType.json).toList();
    final fields =
        filteredParameters.map((param) {
          return Field(
            (field) =>
                field
                  ..modifier = FieldModifier.final$
                  ..name = CaseUtil(param.key).camelCase
                  ..type = Reference(param.dartTypeString),
          );
        }).toList();

    final constructor = Constructor((c) {
      c.optionalParameters.addAll(
        filteredParameters.map((param) {
          return Parameter(
            (p) =>
                p
                  ..name = CaseUtil(param.key).camelCase
                  ..toThis = true
                  ..named = true
                  ..required = true,
          );
        }),
      );
    });

    final factoryConstructor = Constructor((m) {
      m
        ..name = 'fromRemoteConfig'
        ..factory = true
        ..lambda = false
        ..requiredParameters.add(
          Parameter(
            (p) =>
                p
                  ..name = 'remoteConfigBase'
                  ..type = Reference('RemoteConfigBase'),
          ),
        )
        ..body = Code('''
        return $className(
          ${filteredParameters.map((param) => "${CaseUtil(param.key).camelCase}: ${_buildParameterValue(param)}").join(",\n          ")}
        );
      ''');
    });

    final resultClass = Class((c) {
      c
        ..name = className
        ..fields.addAll(fields)
        ..constructors.add(constructor)
        ..constructors.add(factoryConstructor);
    });

    return Library(
      (libraryBuilder) =>
          libraryBuilder
            ..directives.add(Directive.import('package:${pubspec.packageName}/remote_config/remote_config_base.dart'))
            ..body.add(resultClass)
    ).toDart();
  }

  static String _buildParameterValue(RemoteConfigParameter parameter) {
    final defaultValue = parameter.defaultValue;
    final hasDefaultValue = defaultValue != null;
    switch (parameter.valueType) {
      case ValueType.number:
        return 'remoteConfigBase.getOptionalDouble(\'${parameter.key}\') ??  ${hasDefaultValue ? defaultValue : 0}';
      case ValueType.string:
        return 'remoteConfigBase.getOptionalString(\'${parameter.key}\') ?? ${hasDefaultValue ? defaultValue : ''}';
      case ValueType.boolean:
        return 'remoteConfigBase.getOptionalBool(\'${parameter.key}\') ?? ${hasDefaultValue ? defaultValue : false}';
      case ValueType.json:
      // json not supported currently
        throw '';
    }
  }
}
