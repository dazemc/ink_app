import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ink_app/services/api_service.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  final QrCode qrCodeService;

  QrBloc(this.qrCodeService) : super(QrInitial()) {
    on<QrWifi>((event, emit) async {
      emit(QrUpdatingWifi());
      HapticFeedback.vibrate();
      try {
        await qrCodeService.wifiQR();
      } catch (e) {
        emit(QrError());
      }
      emit(QrUpdated());
    });

    on<QrSSH>((event, emit) async {
      emit(QrUpdatingSSH());
      HapticFeedback.vibrate();
      try {
        await qrCodeService.sshQR();
      } catch (e) {
        emit(QrError());
      }
      emit(QrUpdated());
    });
  }
}
