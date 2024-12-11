library pgyer_updater;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'version_result.dart';

class PgyerUpdater {
  PgyerUpdater._();

  static Future<VersionResult?> check({
    required String apiKey,
    required String appKey,
    required String versionName,
  }) async {
    final url = Uri.parse("https://www.pgyer.com/apiv2/app/check");
    final httpClient = HttpClient();
    try {
      final request = await httpClient.postUrl(url);
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");

      request.write(jsonEncode({
        "_api_key": apiKey,
        "appKey": appKey,
        "buildVersion": versionName,
      }));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final result = VersionResult.fromJson(jsonDecode(responseBody));
        return result;
      } else {
        debugPrint("Error: HTTP ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      // 关闭 HttpClient
      httpClient.close();
    }
    return null;
  }

  static void showUpdateDialog(
    BuildContext context, {
    VersionResult? versionResult,
    String title = "发现新版本",
    String cancelText = "取消",
    String confirmText = "去升级",
    Function(String?)? onConfirm,
    WidgetBuilder? builder,
  }) async {
    if (versionResult != null) {
      final isUpdate = versionResult.data?.buildHaveNewVersion == true;
      final String descMessage =
          versionResult.data?.buildUpdateDescription ?? "";
      final isForce = versionResult.data?.needForceUpdate == true;
      if (isUpdate) {
        showDialog(
          context: context,
          barrierDismissible: !isForce,
          builder: builder ??
              (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text(title),
                  content: Text(descMessage),
                  actions: <Widget>[
                    isForce
                        ? Container()
                        : TextButton(
                            child: Text(cancelText),
                            onPressed: () {
                              Navigator.of(dialogContext)
                                  .pop(); // Dismiss alert dialog
                            },
                          ),
                    TextButton(
                      child: Text(confirmText),
                      onPressed: () {
                        if (!isForce) {
                          Navigator.of(dialogContext)
                              .pop(); // Dismiss alert dialog
                        }
                        onConfirm?.call(versionResult.data?.downloadUrl ??
                            versionResult.data?.appURl);
                      },
                    ),
                  ],
                );
              },
        );
      }
    }
  }
}
