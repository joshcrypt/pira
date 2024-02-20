# pira

A new Flutter project.

## Deploy ios
- flutter build ipa --release --dart-define-from-file=config.prod.json --obfuscate --split-debug-info=debug-info/ios/2

## Deploy Android
- flutter build appbundle --release --dart-define-from-file=config.prod.json  --obfuscate --split-debug-info=debug-info/android/2


## Deploy Android apk
- flutter build apk --release --dart-define-from-file=config.prod.json


## Deploy Web
- flutter build web --release --dart-define-from-file=config.prod.json && firebase deploy --only hosting

