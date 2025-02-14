import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteInitial()) {
    on<QuoteUpdate>((event, emit) {
      emit(QuoteUpdating());
      HapticFeedback.vibrate();
      emit(QuoteUpdated());
    });
  }
}
