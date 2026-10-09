import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:libra/core/config/app_config.dart';
import 'package:libra/core/constans/app_breakpoints.dart';
import 'package:libra/core/util/logger.dart';
import 'package:libra/core/util/prefs_token_storage.dart';
import 'package:libra/core/util/secure_token_storage.dart';
import 'package:libra/core/util/token_interceptor.dart';
import 'package:libra/core/util/token_storage.dart';
import 'package:libra/feature/app/cubit/locale_cubit.dart';
import 'package:libra/feature/app/widget/libra_app.dart';
import 'package:libra/feature/auth/authorization/bloc/authorization_bloc.dart';
import 'package:libra/feature/auth/authorization/data/authorization_repository.dart';
import 'package:libra/feature/initialization/startup_error_app.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class Runner {
  static Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.deferFirstFrame();

    try {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        final view = PlatformDispatcher.instance.views.first;
        final shortestSide =
            view.physicalSize.shortestSide / view.devicePixelRatio;
        final isTablet = shortestSide >= AppBreakpoints.mobile;

        await SystemChrome.setPreferredOrientations(
          isTablet
              ? [
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]
              : [DeviceOrientation.portraitUp],
        );
      }

      final prefs = await SharedPreferences.getInstance();

      const flutterSecureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(resetOnError: true),
      );

      final TokenStorage tokenStorage = kIsWeb
          ? PrefsTokenStorage(prefs)
          : const SecureTokenStorage(flutterSecureStorage);

      final authRepository = AuthorizationRepositoryImpl(
        tokenStorage: tokenStorage,
      );

      final dio = Dio(
        BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          receiveDataWhenStatusError: true,
          baseUrl: AppConfig.baseUrl,
        ),
      );

      dio.interceptors.addAll([
        TokenInterceptor(authorizationRepository: authRepository),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
          enabled: kDebugMode,
        ),
      ]);

      try {
        await authRepository.initAuthSession();
      } catch (e, stackTrace) {
        logger.w(
          'Auth session recovery failed',
          error: e,
          stackTrace: stackTrace,
        );
      }

      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<SharedPreferences>.value(value: prefs),
            RepositoryProvider<Dio>.value(value: dio),
            RepositoryProvider<TokenStorage>.value(value: tokenStorage),
            RepositoryProvider<AuthorizationRepository>.value(
              value: authRepository,
            ),
            // Репозитории фич: RepositoryProvider<XRepository>(
            //   create: (context) => XRepositoryImpl(dio: context.read<Dio>()),
            // ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
              BlocProvider<AuthorizationBloc>(
                create: (context) => AuthorizationBloc(
                  authorizationRepository: context
                      .read<AuthorizationRepository>(),
                )..add(StartedListenAuthChanges()),
              ),
              // BLoC фич: BlocProvider<XBloc>(
              //   create: (context) => XBloc(repository: context.read<XRepository>()),
              // ),
            ],
            child: const LibraApp(),
          ),
        ),
      );
    } catch (e, stackTrace) {
      logger.e('FATAL ERROR DURING INIT', error: e, stackTrace: stackTrace);
      runApp(StartupErrorApp(error: e));
    } finally {
      binding.allowFirstFrame();
    }
  }
}
