part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int count;
  const CounterState({required this.count});

  @override
  List<Object?> get props => [];
}

final class CounterInitial extends CounterState {
  const CounterInitial({required super.count});

  @override
  List<Object> get props => [count];
}

final class CounterUpdate extends CounterState {
  const CounterUpdate({required super.count});

  @override
  List<Object> get props => [count];
}
