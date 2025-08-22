import 'package:api_bloc/models/image_model.dart';
import 'package:api_bloc/repo/gellery_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageEvent>((event, emit) {
      
    });
    on<GetImageEvent>(getImage);
  }
}
void getImage(GetImageEvent event, Emitter<ImageState> emit) async {
  try {
    emit(GetImageLoadingState());
    final data = await GalleryRepo.getGallriesImage(event.code);
    
    print("data $data");
    if (data is List<Data>) {
      emit(GetImageLoadedState(data));
    } else {
      emit(GetImageErrorState(data["errorDesc"]));
    }
  } catch (e) {
    emit(GetImageErrorState(e.toString()));
  }
}