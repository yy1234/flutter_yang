import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ImageUtils {
  static ImageProvider getAssetImage(String name,{ImageFormat format = ImageFormat.png}){
    return AssetImage(getImgPath(name,format: format));
  }

  static String getImgPath(String name,{ImageFormat format = ImageFormat.png}){
    return 'assets/images/$name.${format.value}';
  }

  //获取网络图片
  static ImageProvider getImageProvider(String imageUrl,{String holderImg = 'none'}){
    if(TextUtil.isEmpty(imageUrl)){
      return AssetImage(getImgPath(holderImg));
    }
    return CachedNetworkImageProvider(imageUrl);
  }

}


enum ImageFormat{
  png,
  jpg,
  gif,
  webp
}

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'gif', 'webp'][index];
}