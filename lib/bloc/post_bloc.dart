import 'package:appdemo/model/post_model.dart';
import 'package:appdemo/network/repository/post_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(null);

  @override
  PostState get initialState => PostInitial();
 
  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    TransitionFunction<PostEvent, PostState> transition,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transition,
    );
  }

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    final currentState = state;
    if (event is PostFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostInitial) {
          final posts = await PostRepository.postList(0);
          yield PostSuccess(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostSuccess) {
          final posts = await PostRepository.postList(currentState.posts.length);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostSuccess(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield PostFailure();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
    state is PostSuccess && state.hasReachedMax;
}