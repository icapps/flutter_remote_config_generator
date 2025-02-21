import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

extension SpecExtension on Spec {
  static final _emitter = DartEmitter(
    allocator: Allocator.simplePrefixing(),
    orderDirectives: true,
    useNullSafetySyntax: true,
  );

  String toDart({bool format = true}) {
    final result = accept(_emitter).toString();
    if (!format) return result;
    return DartFormatter().format(result);
  }
}
