part of 'list_gallery_bloc.dart';

sealed class ListGalleryState extends Equatable {
  const ListGalleryState();
  
  @override
  List<Object> get props => [];
}

final class ListGalleryInitial extends ListGalleryState {
  
}

class GetListGalleryLoadingState extends ListGalleryState {
  //  final List<GetGalleries> data;
  const GetListGalleryLoadingState();
  @override
  List<Object> get props => [];
}

 class GetListGalleryLoadedState extends ListGalleryState {
  final List<GetGalleries> data; 
  const GetListGalleryLoadedState(this.data); 
  @override
  List<Object> get props => [data];
  
}

class GetListGalleryErrorState extends ListGalleryState {
  final String err;
  const GetListGalleryErrorState(this.err);
  @override
  List<Object> get props => [err];
}
