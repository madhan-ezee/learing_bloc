part of 'image_bloc.dart';

sealed class ImageState extends Equatable {
  const ImageState();
  
  @override
  List<Object> get props => [];
}

final class ImageInitial extends ImageState {}
class GetImageLoadingState extends ImageState {
  const GetImageLoadingState();
  @override
  List<Object> get props => [];
}
 class GetImageLoadedState extends ImageState {
  final List<Data> data; 
  const GetImageLoadedState(this.data); 
  @override
  List<Object> get props => [data];
  
}

class GetImageErrorState extends ImageState {
  final String err;
  const GetImageErrorState(this.err);
  @override
  List<Object> get props => [err];
}