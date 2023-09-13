import 'package:flutter_bloc/flutter_bloc.dart';
import 'animation_event.dart';
import 'animation_state.dart';

class AnimatedBloc extends Bloc<AnimatedEvent, AnimatedState> {
  AnimatedBloc() : super(AnimatedIntial()) {
    on<AnimatedEvent>((event, emit) {
      if (event is InitialEvent) {
        emit(AnimatedIntial());
      } else {
        emit(AnimatedSuccess(success: "Success"));
      }
    });
  }
}
