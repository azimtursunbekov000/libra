import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:equatable/equatable.dart';
import 'package:libra/core/model/access.dart';
import 'package:meta/meta.dart';

import '../data/authorization_repository.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc({required this._authorizationRepository})
    : super(const UnAuthorized()) {
    on<AuthorizationEvent>(
      (event, emit) => switch (event) {
        StartedListenAuthChanges() => _onStartedListenAuthChanges(event, emit),
        LogoutRequested() => _onLogoutRequested(event, emit),
      },
      transformer: bloc_concurrency.concurrent(),
    );
  }

  final AuthorizationRepository _authorizationRepository;

  Future<void> _onStartedListenAuthChanges(
    StartedListenAuthChanges event,
    Emitter<AuthorizationState> emit,
  ) {
    return emit.onEach(
      _authorizationRepository.accessSubj,
      onData: (access) => emit(
        access != null ? Authorized(access: access) : const UnAuthorized(),
      ),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthorizationState> emit,
  ) {
    return _authorizationRepository.unAuthorize();
  }
}
