part of 'image_bloc.dart';

sealed class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}
class GetImageEvent extends ImageEvent {
  final String code;
   const GetImageEvent(this.code);
  
  @override
  List<Object> get props => [code];
}

