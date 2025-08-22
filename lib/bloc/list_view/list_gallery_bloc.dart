import 'package:api_bloc/models/gallery_model.dart';
import 'package:api_bloc/models/image_model.dart';
import 'package:api_bloc/repo/gellery_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_gallery_event.dart';
part 'list_gallery_state.dart';

class ListGalleryBloc extends Bloc<ListGalleryEvent, ListGalleryState> {
  ListGalleryBloc() : super(ListGalleryInitial()) {
    on<ListGalleryEvent>((event, emit) {
    });
     on<GetListGalleryEvent>(getListGallery);
  }
}

void getListGallery(GetListGalleryEvent event, Emitter<ListGalleryState> emit) async {
  try {
    emit(GetListGalleryLoadingState());
    final data = await GalleryRepo.getGallries();
    // final data2 = await GalleryRepo.getGallriesImage(event.code);
    print("data $data");
    if (data is List<GetGalleries>) {
      emit(GetListGalleryLoadedState(data));
    } else {
      emit(GetListGalleryErrorState(data["errorDesc"]));
    }
  } catch (e) {
    emit(GetListGalleryErrorState(e.toString()));
  }
}
