library pgyer_updater;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'version_result.dart';

class PgyerUpdater {
  static String? _apiKey;

  PgyerUpdater._();

  static Future<VersionResult?> check({
    required String apiKey,
    required String appKey,
    required String versionName,
  }) async {
    final url = Uri(
      scheme: "http",
      host: "www.pgyer.com",
      path: "/apiv2/app/check",
      queryParameters: {
        "_api_key": apiKey,
        "appKey": appKey,
        "buildVersion": versionName,
      },
    );
    final httpClient = HttpClient();
    try {
      final request = await httpClient.postUrl(url);
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final result = VersionResult.fromJson(jsonDecode(responseBody));
        _apiKey = apiKey;
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
  /// 弹窗提醒，下载安装自行实现
  static void showUpdateDialog(
    BuildContext context, {
    VersionResult? versionResult,
    String title = "发现新版本",
    String cancelText = "取消",
    String confirmText = "去升级",
    Function(String? appUrl)? onConfirm,
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
                        onConfirm?.call(versionResult.data?.appURl);
                      },
                    ),
                  ],
                );
              },
        );
      }
    }
  }

  /// 获取下载链接
  /// @param isIOSDirect true 无需打开浏览器，即可直接安装的效果 false 需要打开浏览器
  /// @param buildKey [https://www.pgyer.com/doc/view/api#commonParams]仅android 安装 App 具体的某个版本，不传为最新版本
  /// @param buildPassword 当应用需要安装密码时，请传入应用安装密码
  static String? getDownloadUrl(
    VersionResult? versionResult, {
    bool isIOSDirect = false,
    String? buildKey,
    String? buildPassword,
  }) {
    if (versionResult?.data == null) {
      return null;
    }
    if (Platform.isIOS && isIOSDirect) {
      return "itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/${versionResult?.data?.buildKey}${buildPassword?.isNotEmpty == true ? "?password=$buildPassword" : ""}";
    }
    var url = "https://www.pgyer.com/apiv2/app/install?_api_key=$_apiKey";
    if (buildKey?.isNotEmpty == true) {
      url = "$url&buildKey=$buildKey";
    } else {
      url = "$url&appKey=${versionResult?.data?.appKey}";
    }
    return buildPassword?.isNotEmpty == true
        ? "$url&buildPassword=$buildPassword"
        : url;
  }
}
