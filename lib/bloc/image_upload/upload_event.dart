part of 'upload_bloc.dart';

sealed class UploadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadImage extends UploadEvent {}
