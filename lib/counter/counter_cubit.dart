import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends HydratedCubit<CounterState> {
  CounterCubit() : super(const CounterInitial(count: 0));

  void increment() => emit(CounterUpdate(count: state.count + 1));
  void decrement() => emit(CounterUpdate(count: state.count - 1));

  /*
  @override
  int fromJson(Map<String, dynamic> json) => json['value'] as int;

  @override
  Map<String, int> toJson(int state) => {'value': state};
  */

  @override
  CounterState fromJson(Map<String, dynamic> json) {
    return CounterState(count: json['value'] as int);
  }

  @override
  Map<String, dynamic> toJson(CounterState state) {
    return <String, int>{'value': state.count};
  }
}
