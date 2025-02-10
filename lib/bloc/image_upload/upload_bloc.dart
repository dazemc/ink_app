import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ink_app/bloc/image_upload/upload_event.dart';
import 'package:ink_app/bloc/image_upload/upload_state.dart';
import 'package:ink_app/services/api_service.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final DisplayUploadImage uploadImageService;

  UploadBloc(this.uploadImageService) : super(UploadInitial()) {
    on<UploadImage>((event, emit) async {
      emit(UploadLoading());
      await uploadImageService.uploadImage();
      emit(UploadLoaded());
    });
  }
}
