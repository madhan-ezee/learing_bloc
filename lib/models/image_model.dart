class GetGalleryImage {
  int? status;
  String? datetime;
  List<Data>? data;
  String? code;

  GetGalleryImage({this.status, this.datetime, this.data, this.code});

  GetGalleryImage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    datetime = json['datetime'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['datetime'] = this.datetime;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Data {
  int? activeFlag;
  String? imageUrlSlug;
  String? imageCategory;
  String? tag;

  Data({this.activeFlag, this.imageUrlSlug, this.imageCategory, this.tag});

  Data.fromJson(Map<String, dynamic> json) {
    activeFlag = json['activeFlag'];
    imageUrlSlug = json['imageUrlSlug'];
    imageCategory = json['imageCategory'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeFlag'] = this.activeFlag;
    data['imageUrlSlug'] = this.imageUrlSlug;
    data['imageCategory'] = this.imageCategory;
    data['tag'] = this.tag;
    return data;
  }
}