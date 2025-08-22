class GetGalleriesRsp {
  int? status;
  String? datetime;
  List<GetGalleries>? data;
  int? superNamespace;
  String? countryCode;

  GetGalleriesRsp(
      {this.status,
      this.datetime,
      this.data,
      this.superNamespace,
      this.countryCode});

  GetGalleriesRsp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    datetime = json['datetime'];
    if (json['data'] != null) {
      data = <GetGalleries>[];
      json['data'].forEach((v) {
        data!.add(new GetGalleries.fromJson(v));
      });
    }
    superNamespace = json['superNamespace'];
    countryCode = json['countryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['datetime'] = this.datetime;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['superNamespace'] = this.superNamespace;
    data['countryCode'] = this.countryCode;
    return data;
  }
}

class GetGalleries {
  String? code;
  String? name;
  int? activeFlag;
  List<ImageDetails>? imageDetails;


  GetGalleries({this.code, this.name, this.activeFlag,
   this.imageDetails
  });

  GetGalleries.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    activeFlag = json['activeFlag'];
    if (json['imageDetails'] != null) {
      imageDetails = <ImageDetails>[];
      json['imageDetails'].forEach((v) {
        imageDetails!.add(new ImageDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['activeFlag'] = this.activeFlag;
    if (this.imageDetails != null) {
      data['imageDetails'] = this.imageDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageDetails {
  int? activeFlag;
  String? imageUrlSlug;

  ImageDetails({this.activeFlag, this.imageUrlSlug});

  ImageDetails.fromJson(Map<String, dynamic> json) {
    activeFlag = json['activeFlag'];
    imageUrlSlug = json['imageUrlSlug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeFlag'] = this.activeFlag;
    data['imageUrlSlug'] = this.imageUrlSlug;
    return data;
  }
}


