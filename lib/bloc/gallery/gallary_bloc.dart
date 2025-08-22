
import 'package:api_bloc/models/gallery_model.dart';
import 'package:api_bloc/repo/gellery_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'gallary_event.dart';
part 'gallary_state.dart';

class GallaryBloc extends Bloc<GallaryEvent, GallaryState> {
  GallaryBloc() : super(GallaryInitial()) {
    on<GallaryEvent>((event, emit) {
    
    });
    on<GetGalleryEvent>(getGallery);
  }
}

void getGallery(GetGalleryEvent event, Emitter<GallaryState> emit) async {
  try {
    emit(GetGalleryLoadingState());
    final data = await GalleryRepo.getGallries();
    
    print("data $data");
    if (data is List<GetGalleries>) {
      emit(GetGalleryLoadedState(data));
    } else {
      emit(GetGalleryErrorState(data["errorDesc"]));
    }
  } catch (e) {
    emit(GetGalleryErrorState(e.toString()));
  }
}

