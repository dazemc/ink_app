part of 'qr_bloc.dart';

sealed class QrEvent extends Equatable {
  const QrEvent();

  @override
  List<Object> get props => [];
}

final class QrWifi extends QrEvent {}

final class QrSSH extends QrEvent {}