# libra

Flutter-приложение. Архитектура и правила перенесены из e_kenesh.

## Стек

- **Flutter** (SDK ^3.13)
- **State**: `flutter_bloc` + `bloc_concurrency`
- **Network**: `dio` + `pretty_dio_logger`
- **Storage**: `shared_preferences`, `flutter_secure_storage`
- **Theme**: `theme_tailor` (кодогенерация `ThemeExtension`)
- **Localization**: `flutter_localizations` + ARB (`ru`, `ky`)
- **Logging**: `logger` + `stack_trace`

## Структура

```
lib/
├── main.dart          # runZonedGuarded → Runner.initializeAndRun()
├── core/
│   ├── config/        # AppConfig (dart-define)
│   ├── constans/      # AppBreakpoints, StorageKey
│   ├── model/         # доменные модели (Access, ...)
│   ├── theme/         # MyColor, SfPro (ThemeExtension через theme_tailor), buildLightTheme
│   └── util/          # logger, TokenStorage, TokenInterceptor, appNavigatorKey
├── feature/
│   ├── app/           # корневой LibraApp + LocaleCubit
│   ├── auth/          # AuthorizationRepository + AuthorizationBloc
│   ├── home/          # стартовая страница
│   └── initialization/# Runner (DI, Dio, ориентация, сессия) + StartupErrorApp
└── l10n/              # app_ru.arb, app_ky.arb
```

## Точка входа

- `main.dart` только оборачивает запуск в `runZonedGuarded` и логирует необработанные ошибки.
- `Runner.initializeAndRun()` держит первый кадр (`deferFirstFrame`), фиксирует ориентацию (планшет — landscape, телефон — portrait), создаёт `SharedPreferences`, `TokenStorage`, `Dio` с интерцепторами, восстанавливает сессию и запускает `MultiRepositoryProvider` → `MultiBlocProvider` → `LibraApp`. Если что-то упало, показывает `StartupErrorApp`.
- Новая фича регистрируется в `Runner`: `RepositoryProvider<XRepository>` (интерфейс → `XRepositoryImpl(dio: context.read<Dio>())`) и `BlocProvider<XBloc>`.

## Соглашения

### BLoC

- Один BLoC на feature.
- События в `*_event.dart`, состояния в `*_state.dart`, логика в `*_bloc.dart` (`part of`).
- События — `sealed`, обработка через `switch` в одном `on<XEvent>`.
- В UI: `context.read<XBloc>().add(...)` в `initState`, `BlocBuilder` для рендеринга.

### Авторизация

- Источник правды — `AuthorizationRepository.accessSubj`; `TokenInterceptor` берёт токен оттуда и на 401 разлогинивает.
- Публичные эндпоинты перечислены в `TokenInterceptor._publicPaths`.

### Тема

- Цвета через `Theme.of(context).extension<MyColor>()!`.
- Текстовые стили через `Theme.of(context).extension<SfPro>()!`.
- Стили мутируются через `.copyWith(...)` (не создавать новые `TextStyle` руками).
- После изменения `MyColor`/`SfPro` — `make gen`.

### Локализация

- Все строки — через `AppLocalizations.of(context)!`. Шаблон — `app_ky.arb`.

### Адаптивность

Каждая страница имеет два варианта: `page/tablet/<name>_page_tablet.dart` и `page/mobile/<name>_page_mobile.dart`. Выбор — по `AppBreakpoints.isMobile(context)`.

- Tablet: многоколоночные сетки/таблицы, `padding: 32`.
- Mobile: вертикальный стек, `padding: 16`, карточки вместо таблиц.

Компоненты в `feature/<name>/widget/components/` шарятся между tablet и mobile, либо имеют префикс `mobile_` для мобильной специфики.

## Запуск

```bash
flutter run --dart-define=BASE_URL=https://api.example.com/
```

## Правила кода

### SOLID — обязательно и жёстко

Весь UI и data-слой пишутся по принципам SOLID. Это не рекомендация, а требование. Любой PR/коммит, нарушающий SOLID, переписывается, а не дополняется.

#### S — Single Responsibility

Один класс = одна причина для изменений.

- Виджет рендерит **одну** визуальную единицу (карточка, секция, app bar, error view). Если в `build()` логически две независимые области — раздели на два виджета.
- BLoC отвечает за одно состояние одной фичи. Не смешивать состояния разных фич в одном BLoC.
- Repository отвечает только за загрузку/сохранение данных, не форматирует и не локализует.
- Утилиты — каждая делает ровно одно.

#### O — Open/Closed

Открыто для расширения, закрыто для модификации.

- Виджет параметризуется через конструктор (`color`, `textTheme`, `onTap`, `child`). Если для нового кейса понадобилось править существующий виджет — добавь параметр или новый виджет, а не if/else внутри.
- Темы, форматтеры, локализация — через интерфейсы/расширения (`MyColor`, `SfPro`, `AppLocalizations`), а не через ветвление по флагам внутри виджета.

#### L — Liskov Substitution

Подтипы должны корректно подменять базовый тип.

- Кастомные `PreferredSizeWidget`-обёртки обязаны корректно возвращать `preferredSize`.
- BLoC-состояния, наследующиеся от общего `XxxState`, обязаны быть взаимозаменяемы в `BlocBuilder` — никаких скрытых требований к `state is Concrete` в местах, где ожидается базовый тип.

#### I — Interface Segregation

Не завись от того, чем не пользуешься.

- Виджет принимает **только то, что использует**: не передавай модель целиком, если виджету нужны два её поля — выдели поля или подмодель.
- Callbacks узкие: `onTap: VoidCallback` вместо «жирного» объекта с десятью полями.
- Не подсовывай `BuildContext` методам, которым он не нужен.

#### D — Dependency Inversion

Высокоуровневый код зависит от абстракций, а не от конкретных реализаций.

- UI зависит от BLoC, не от Dio/SharedPreferences напрямую.
- BLoC зависит от Repository-интерфейса, репозиторий зависит от `DioClient`, а не от глобальных синглтонов.

#### Если SOLID и «удобно» конфликтуют

SOLID побеждает. Локальный `Widget _foo()` или приватный `_FooSection` в файле страницы — нарушают S (страница и виджеты смешаны в один файл) и I (зависимости неявные). Не добавлять «временно».

### Выделение виджетов

Следствие из S и I, формализованное правило:

**Каждый виджет — отдельный публичный класс в отдельном файле в `components/`. Не использовать `Widget _foo()` методы и не оставлять приватные `_FooSection` классы в файле страницы.**

Правило действует даже для коротких секций и обёрток (`AppBar`, error view, header). Пример: `home_page_mobile.dart` → `components/mobile_home_header.dart`, `components/mobile_home_body.dart`.

Почему:
- Builder-функции выглядят аккуратно, но ломают оптимизации Flutter: нельзя пометить `const`, нет переиспользования `Element`, сложнее профилировать.
- Приватные классы в одном файле быстро превращают файл страницы в свалку — труднее находить и переиспользовать.
- Отдельный публичный класс в `components/` делает явным список зависимостей (конструктор) и доступен для других страниц при необходимости.

Как применять:
- Файл страницы (`page/.../*_page.dart`) содержит только: lifecycle (`initState`, `dispose`, refresh), выбор tablet/mobile, сборку секций. Никаких приватных виджетов.
- Каждая секция / карточка / app bar / error view выносится в `feature/<name>/widget/components/<имя>.dart` как **публичный** класс.
- Для мобильной специфики имя начинается с `mobile_`; для tablet-специфичных — с `tablet_` (если потребуется), иначе общее имя без префикса.
- Зависимости передаются через конструктор. Локальное состояние (фильтры, флаги раскрытия) живёт в `State` секции, а не поднимается в родителя.
- Правило действует даже если виджет в 10 строк.
