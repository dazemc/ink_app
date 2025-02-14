part of 'quote_bloc.dart';

sealed class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

final class QuoteInitial extends QuoteState {}

final class QuoteUpdating extends QuoteState {}

final class QuoteUpdated extends QuoteState {}
