import 'package:equatable/equatable.dart';

class UploadState extends Equatable{
  @override
  List<Object?> get props => [];
}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadLoaded extends UploadState {}