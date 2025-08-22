part of 'gallary_bloc.dart';

abstract class GallaryState extends Equatable {
  const GallaryState();

  @override
  List<Object> get props => [];
}

final class GallaryInitial extends GallaryState {}

class GetGalleryLoadingState extends GallaryState {
  const GetGalleryLoadingState();
  @override
  List<Object> get props => [];
}

 class GetGalleryLoadedState extends GallaryState {
  final List<GetGalleries> data; 
  const GetGalleryLoadedState(this.data); 
  @override
  List<Object> get props => [data];
  
}

class GetGalleryErrorState extends GallaryState {
  final String err;
  const GetGalleryErrorState(this.err);
  @override
  List<Object> get props => [err];
}
