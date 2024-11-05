// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
  path: '.env.dev',
  useConstantCase: true,
  obfuscate: true,
  requireEnvFile: true,
)
abstract class Env {
  @EnviedField()
  static String apiUrl = _Env.apiUrl;
}
