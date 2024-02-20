class EnvironmentService {
  static const String kEnvProduction = "production";
  static const String kEnvDevelopment = "dev";
  static const String environment = String.fromEnvironment("environment");
  static const String apiKey = String.fromEnvironment("apiKey");
  static const String appIdWeb = String.fromEnvironment("appIdWeb");
  static const String appIdAndroid = String.fromEnvironment("appIdAndroid");
  static const String appIdIos = String.fromEnvironment("appIdIos");
  static const String messagingSenderId =
      String.fromEnvironment("messagingSenderId");
  static const String projectId = String.fromEnvironment("projectId");
  static const String authDomain = String.fromEnvironment("authDomain");
  static const String storageBucket = String.fromEnvironment("storageBucket");
  static const String iosBundleId = String.fromEnvironment("iosBundleId");

  static bool get isProduction => environment == kEnvProduction;
  static bool get isDevelopment => environment == kEnvDevelopment;
}
