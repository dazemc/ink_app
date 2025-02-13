part of 'qr_bloc.dart';

sealed class QrState extends Equatable {
  const QrState();

  @override
  List<Object> get props => [];
}

final class QrInitial extends QrState {}

final class QrUpdatingSSH extends QrState {}

final class QrUpdatingWifi extends QrState {}

final class QrUpdated extends QrState {}

final class QrError extends QrState {}
