part of 'list_gallery_bloc.dart';

sealed class ListGalleryEvent extends Equatable {
  const ListGalleryEvent();

  @override
  List<Object> get props => [];
}

class GetListGalleryEvent extends ListGalleryEvent {
  // final String code;
  const GetListGalleryEvent();
  
  @override
  List<Object> get props => [];
}