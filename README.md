# pgyer_updater

flutter蒲公英应用更新插件，使用api实现，理论上无平台限制

### Example
```dart
   import 'package:package_info_plus/package_info_plus.dart';

   final packageInfo = await PackageInfo.fromPlatform();
   final projectVersionName = packageInfo.version;
   PgyerUpdater.check(apiKey: "apiKey", appKey: "appKey", versionName: projectVersionName).then((result) {
      if (mounted) {
        PgyerUpdater.showUpdateDialog(context, versionResult: result);
      }
   });
```
