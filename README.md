# pgyer_updater
[![package](https://img.shields.io/pub/v/pgyer_updater.svg)](https://pub.dev/packages/pgyer_updater)

flutter蒲公英应用更新插件，使用api实现，理论上无平台限制，仅弹窗提醒，下载安装可拿到versionResult自行实现

### Example
```dart
import 'package:package_info_plus/package_info_plus.dart';

final packageInfo = await PackageInfo.fromPlatform();
final projectVersionName = packageInfo.version;
PgyerUpdater.check(apiKey: "apiKey", appKey: "appKey", versionName: projectVersionName).then((result) {
  if (mounted) {
    PgyerUpdater.showUpdateDialog(
      context,
      versionResult: result,
      onConfirm: (appUrl) {
        //launchUrlString(appUrl);
        // 或者自行实现下载
        //final downloadUrl = PgyerUpdater.getDownloadUrl(result);
        //download(downloadUrl);
      },
    );
  }
});
```
