import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ink_app/services/api_service.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final DisplayUploadImage uploadImageService;

  UploadBloc(this.uploadImageService) : super(UploadInitial()) {
    on<UploadImage>((event, emit) async {
      emit(UploadLoading());
      HapticFeedback.vibrate();
      await uploadImageService.uploadImage();
      emit(UploadLoaded());
    });
  }
}
