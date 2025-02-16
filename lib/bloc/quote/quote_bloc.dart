import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:ink_app/services/api_service.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final Quote quoteServiceProvider;

  QuoteBloc(this.quoteServiceProvider) : super(QuoteInitial()) {
    on<QuoteUpdate>((event, emit) async {
      emit(QuoteUpdating());
      HapticFeedback.vibrate();
      await quoteServiceProvider.quoteDisplay();
      emit(QuoteUpdated());
    });
  }
}
