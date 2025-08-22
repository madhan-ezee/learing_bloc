part of 'gallary_bloc.dart';

sealed class GallaryEvent extends Equatable {
  const GallaryEvent();

  @override
  List<Object> get props => [];
}

class GetGalleryEvent extends GallaryEvent {
  const GetGalleryEvent();
  
  @override
  List<Object> get props => [];
}
