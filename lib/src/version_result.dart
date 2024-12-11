class VersionResult {
  VersionResult({
    required this.code,
    required this.message,
    required this.data,
  });

  final int? code;
  final dynamic message;
  final VersionData? data;

  factory VersionResult.fromJson(Map<String, dynamic> json){
    return VersionResult(
      code: json["code"],
      message: json["message"],
      data: json["data"] == null ? null : VersionData.fromJson(json["data"]),
    );
  }

}

class VersionData {
  VersionData({
        required this.buildBuildVersion,
        required this.forceUpdateVersion,
        required this.forceUpdateVersionNo,
        required this.needForceUpdate,
        required this.downloadUrl,
        required this.buildHaveNewVersion,
        required this.buildVersionNo,
        required this.buildVersion,
        required this.buildDescription,
        required this.buildUpdateDescription,
        required this.buildShortcutUrl,
        required this.appURl,
        required this.appKey,
        required this.buildKey,
        required this.buildName,
        required this.buildIcon,
        required this.buildFileKey,
        required this.buildFileSize,
    });

    final String? buildBuildVersion;
    final String? forceUpdateVersion;
    final String? forceUpdateVersionNo;
    final bool? needForceUpdate;
    final String? downloadUrl;
    final bool? buildHaveNewVersion;
    final String? buildVersionNo;
    final String? buildVersion;
    final String? buildDescription;
    final String? buildUpdateDescription;
    final String? buildShortcutUrl;
    final String? appURl;
    final String? appKey;
    final String? buildKey;
    final String? buildName;
    final String? buildIcon;
    final String? buildFileKey;
    final String? buildFileSize;

    factory VersionData.fromJson(Map<String, dynamic> json){ 
        return VersionData(
            buildBuildVersion: json["buildBuildVersion"],
            forceUpdateVersion: json["forceUpdateVersion"],
            forceUpdateVersionNo: json["forceUpdateVersionNo"],
            needForceUpdate: json["needForceUpdate"],
            downloadUrl: json["downloadURL"],
            buildHaveNewVersion: json["buildHaveNewVersion"],
            buildVersionNo: json["buildVersionNo"],
            buildVersion: json["buildVersion"],
            buildDescription: json["buildDescription"],
            buildUpdateDescription: json["buildUpdateDescription"],
            buildShortcutUrl: json["buildShortcutUrl"],
            appURl: json["appURl"],
            appKey: json["appKey"],
            buildKey: json["buildKey"],
            buildName: json["buildName"],
            buildIcon: json["buildIcon"],
            buildFileKey: json["buildFileKey"],
            buildFileSize: json["buildFileSize"],
        );
    }

}
