# pgyer_updater

flutter蒲公英应用更新插件，使用api实现，理论上无平台限制

### Example
```dart
   PgyerUpdater.check(apiKey: "apiKey", appKey: "appKey", versionName: "versionName").then((result) {
      if (mounted) {
        PgyerUpdater.showUpdateDialog(context, versionResult: result);
      }
   });
```
