# UX Libraries

## flutter_launcher_icons

Flutter uygulamasının başlatma simgesini güncellemek için kullanılır. Minimum SDK versiyonu seçme ve hangi platformlar için güncelleneceğini seçme esnekliği verir.

```dart

flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icon/icon.png"
  min_sdk_android: 21
  web:
    generate: true
    image_path: "path/to/image.png"
    background_color: "#hexcode"
    theme_color: "#hexcode"
  windows:
    generate: true
    image_path: "path/to/image.png"
    icon_size: 48
  macos:
    generate: true
    image_path: "path/to/image.png"

```

pubspec.yaml içerisinde konfigürasyon yapıldıktan sonra konsol üzerinden çalıştırılır.

```bash

flutter pub get
flutter pub run flutter_launcher_icons

```

## flutter_native_splash

Uygulama yükleme ekranında Flutter'ın varsayılan temasını değiştirmek için kullanılır. Karanlık mod, arka plan resmi gibi özellikleri destekler.

pubspec.yaml içerisinde;

```yaml
flutter_native_splash:

color: "#ffffff"
background_image: assets/backgroud.png
```

## IntroductionScreen

Uygulama yüklendikten sonra slaytlar halinde bilgilendirme ekranı oluşturmak için kullanılır. Sayfanın görünüşü ve animasyonları üzerinde özelleştirme yapma imkanı sunar.

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Birinci bilgilendirme ekrani',
            body: 'Birinci bilgilendirme metni',
            image: Image.asset('assets/images/asset.png'),
            decoration: PageDecoration(
              pageColor: Colors.white,
              titleTextStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 16,
              ),
            ),
            animationDuration: 1000,
            animationCurve: Curves.easeIn,
            indicator: DotIndicator(
              color: Colors.blue,
              activeColor: Colors.white,
              size: 10,
            ),
          ),
          PageViewModel(
            title: 'Ikinci bilgilendirme ekrani',
            body: 'Ikinci bilgilendirme metni',
            image: Image.asset('assets/images/asset.png'),
            decoration: PageDecoration(
              pageColor: Colors.white,
              titleTextStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                fontSize: 16,
              ),
            ),
            animationDuration: 1000,
            animationCurve: Curves.easeIn,
            indicator: DotIndicator(
              color: Colors.blue,
              activeColor: Colors.white,
              size: 10,
            ),
          ),
        ]
        next: Text('Next'),
        done: Text('Done'),
      ),
    );
  }
}

```

## showcaseview

Uygulama içerisinde belli kısımları sırayla öne çıkarmak ve o kısım hakkında ekstra bilgi sağlamak için kullanılır. Yeni gelen özellikleri kullanıcıya tanıtma gibi durumlarda iyi bir çözüm sunar.

```dart
GlobalKey _one = GlobalKey();
GlobalKey _two = GlobalKey();
GlobalKey _three = GlobalKey();

Showcase(
  key: _one,
  title: 'Menu',
  description: 'Menu ayarlarini gormek icin buraya dokun',
  child: Icon(
    Icons.menu,
    color: Colors.black45,
  ),
),

Showcase.withWidget(
  key: _three,
  height: 80,
  width: 140,
  targetShapeBorder: CircleBorder(),
  container: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      ...
    ],
  ),
  child: ...,
),
```

Sekansı başlatmak için;

```dart
someEvent(){
    ShowCaseWidget.of(context).startShowCase([_one, _two, _three]);
}
```

Arayüz yüklendikten sonra otomatik olarak başlatmak için;

```dart
WidgetsBinding.instance.addPostFrameCallback((_) =>
  ShowCaseWidget.of(context).startShowCase([_one, _two, _three])
);
```

## firebase_auth

Uygulamaya girişte Firebase API kullanarak kimlik doğrulama imkanı sunar.

[Firebase](https://console.firebase.google.com/u/0/?pli=1) üzerinde proje oluşturup proje yapılandırmasında kullanılacak kimlik doğrulama metodları aktifleştirilir.

Uygulama içerisinden applicationId'yi alarak Firebase üzerinden kaydettikten sonra, Firebase SDK'nın projeye eklenmesi ile birlikte kullanılmaya hazır hale getirilir.

Uygulama içerisinde kullanılabilecek bazı Firebase metodları;

```dart

// kullanicinin giris yapip yapmadigini kontrol et
bool isLoggedIn() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  return auth.currentUser != null;
}

// kullanici olusturup Firebase ile kaydet
Future<UserCredential> createUserWithEmailAndPassword(String email, String password) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  return await auth.createUserWithEmailAndPassword(email: email, password: password);
}

// varolan bir kullanici ile giris yap
Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  return await auth.signInWithEmailAndPassword(email: email, password: password);
}

```

## pinput

Uygulama içerisinde şifre giriş ekranlarını özelleştirmek için kullanılır. Firebase API ile birlikte kullanıldığında gelen doğrulama SMS'lerini otomatik doldurma özelliği sunar.

```dart

// default pin temasi
final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    borderRadius: BorderRadius.circular(20),
  ),
);

// focus sonrasi pin temasi
final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(8),
);

// pin girildikten sonraki tema
final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration.copyWith(
    color: Color.fromRGBO(234, 239, 243, 1),
  ),
);

return Pinput(
  defaultPinTheme: defaultPinTheme,
  focusedPinTheme: focusedPinTheme,
  submittedPinTheme: submittedPinTheme,
  validator: (s) {
    return s == '2222' ? null : 'Pin is incorrect';
  },
  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
  showCursor: true,
  onCompleted: (pin) => print(pin),
);

```

Firebase ile kullanmak için:

```dart
//androidSmsAutofillMethod none olarak ayarla
Pinput(
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
      controller: pinController,
    );

// onaylama islemini Firebase ile yap
await FirebaseAuth.instance.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {
        pinController.setText(credential.smsCode);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
```

## in_app_review

Google Play In-App Review API ile çalışır. Kullanıcıdan uygulama içinde değerlendirme almak için kullanılır.
En son yapılan değerlendirme tarihi, kullanıcının ayarları gibi etkenleri kontrol etmek için isAvailable() methodu çağrılır.

```dart
final InAppReview inAppReview = InAppReview.instance;

if (await inAppReview.isAvailable()) {
    inAppReview.requestReview();
}
```

## upgrader

Uygulamanın daha üst bir versiyonu bulunması durumunda kullanıcıya bilgilendirme mesajı göndermek için kullanılır.

```dart

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Example',
      home: UpgradeAlert(
          child: Scaffold(
        appBar: AppBar(title: Text('Upgrader Example')),
        body: Center(child: Text('Checking...')),
      )),
    );
  }
}

```

# Functionality

## google_mobile_ads

Seçilen reklam formatına göre uygulama içerisinde kullanıcıya reklam göstermek için kullanılır. (Google reklam yöneticisi)[https://developers.google.com/ad-manager/mobile-ads-sdk/flutter/quick-start]'nin Flutter eklentisidir.

```dart

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Reklamlari yukle
  }
}

```

## firebase_analytics

Firebase API ile uygulama içerisinde kullanıcının etkileşimine göre veri toplamak için kullanılır.

```dart

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

analytics.setUserId('1234567890');


analytics.setCurrentScreen('Home Screen');


analytics.logScreenView();

analytics.logEvent(
  eventName: 'user_engagement',
  eventParameters: {
    'feature_name': 'Button',
    'time_spent': 1000, // in milliseconds
  },
);

```

## uuid

Uygulama içerisinde birbirinden farklı id'ler oluşturmak için kullanılır.

```dart

var uuid = Uuid();

// time-based id
uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'

// random id
uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

// namespace-name-sha1-based id
uuid.v5(Uuid.NAMESPACE_URL, 'www.google.com'); // -> 'c74a196f-f19d-5ea9-bffd-a2742432fc9c'

```

## easy_localization

Uygulama içi yerelleştirme ve arayüzde kullanıcı konumuna göre çeviri işlemleri yapmak için kullanılır.

Proje yapılandırmasına çeviriler için klasör oluşturulduktan sonra pubspec.yaml içerisinde tanımlanır.

```yaml
flutter:
  assets:
    - assets/translations/
```

Daha sonra uygulama içerisinde;

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('de', 'DE')],
      path: 'assets/translations', // <-- çevirilerin olduğu klasör belirtilir
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: MyHomePage()
    );
  }
}

```

# Storage Libraries

## sqflite

Flutter için SQLite eklentisidir. Uygulama içerisinde veri tabanı işlemleri yapabilmeyi sağlar.

```dart
var db = await openDatabase('my_db.db');

var databasesPath = await getDatabasesPath();
String path = join(databasesPath, 'demo.db');

List<Map> list = await database.rawQuery('SELECT * FROM Test');
List<Map> expectedList = [
  {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
  {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
];
print(list);
print(expectedList);
assert(const DeepCollectionEquality().equals(list, expectedList));

```

## mongo_dart

Uygulama içerisinde mongoDB veritabanına erişim sağlar. mongoDB queryleri kullanmaya olanak sağlar.

```dart
var db = Db("mongodb://localhost:27017/mongo_dart-blog");
await db.open();

var coll = db.collection('find');
await collection.find(where.eq('name', 'Tom').gt('rating', 10)).toList();

await usersCollection.insertAll([
    {'login': 'jdoe', 'name': 'John Doe', 'email': 'john@doe.com'},
    {'login': 'lsmith', 'name': 'Lucy Smith', 'email': 'lucy@smith.com'}
  ]);

coll.update(where.eq('name', 'Daniel Robinson'), modify.set('age', 31), multiUpdate: true);

await coll.deleteMany({"name": "Karl"});

```

## cloud_firestore

Flutter için Cloud Firestore API eklentisidir. Uygulama içerisinde cloud'a erişmek için kullanılır.

```dart

// veri ekleme
final user = <String, dynamic>{
  "first": "John",
  "middle": "Lorem",
  "last": "Doe",
  "born": 1912
};
db.collection("users").add(user).then((DocumentReference doc) =>
    print('DocumentSnapshot added with ID: ${doc.id}'));


// veri okuma
await db.collection("users").get().then((event) {
  for (var doc in event.docs) {
    print("${doc.id} => ${doc.data()}");
  }
});


```

## flutter_cache_manager

Uygulama içerisinde dosyaları önbelleğe almak için özelleştirmeler sunar. Önbelleğe alınan veriler varsayılan olarak uygulamanın "temporary" dizinine kaydedilir.

```dart

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 20,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileSystem: IOFileSystem(key),
      fileService: HttpFileService(),
    ),
  );
}

```

# Scan/Print

## qr_flutter

Uygulama içerisinde QR kod renderlamak için kullanılır.

```dart

final qrImage = QrImage(
  data: 'https://example.com',
  version: QrVersions.auto,
);


final qrImage = QrImage(
  data: 'Hello, world!',
  version: QrVersions.auto,
  errorCorrectionLevel: QrErrorCorrectionLevels.H,
  foregroundColor: Colors.red,
);

```

## pdf

Uygulama içerisinde PDF dosya oluşturma, okuma ya da düzenleme imkanı sunar.

```dart

import 'package:pdf/widgets.dart' as pw;

Future<void> main() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text('Hello World!'),
      ),
    ),
  );

  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}

```

# UI/Theme

## flex_color_scheme

Uygulama içerisinde kullanılabilecek renk şemaları sunar. Karanlık mod için özelleştirme yapma imkanı sunar.

```dart

final FlexSchemeColor _schemeDark = FlexSchemeColor.from(
  primary: const Color(0xFF6B8BC3),
  secondary: const Color(0xffff7155),
  brightness: Brightness.dark,
);



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

```

## getwidget

Uygulama içerisinde hazır UI bileşenlerine erişim sağlar. Kullanılan bileşenleri özelleştirme imkanı sunar.

```dart
import 'package:getwidget/getwidget.dart';

GFDrawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      ListTile(
        title: Text('Item 1'),
        onTap: // tap behaviour,
      ),
      ListTile(
         title: Text('Item 2'),
         onTap: // tap behaviour,
      ),
    ],
  ),
),


GFImageOverlay(
  height: 200,
  width: 300,
  image: NetworkImage('your network image')
)
```

## flutter_screenutil

Uygulama içi elementleri farklı ekran boyutlarına göre responsive şekilde oluşturmak için kullanılır.

```dart

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Homepage',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const HomePage(title: 'Homepage'),
    );
  }
}

```

# MISCELLANEOUS

## socket_io_client

Uygulama içerisinde server-client arası anlık bağlantı oluşturmak için kullanılır.

Dart server;

```dart
import 'package:socket_io/socket_io.dart';

main() {
  // Dart server
  var io = Server();
  var nsp = io.of('/some');
  nsp.on('connection', (client) {
    print('connection /some');
    client.on('msg', (data) {
      print('data from /some => $data');
      client.emit('fromServer', "ok 2");
    });
  });
  io.on('connection', (client) {
    print('connection default namespace');
    client.on('msg', (data) {
      print('data from default => $data');
      client.emit('fromServer', "ok");
    });
  });
  io.listen(3000);
}

```

dart client

```dart

import 'package:socket_io_client/socket_io_client.dart' as IO;

main() {
  // Dart client
  IO.Socket socket = IO.io('http://localhost:3000');
  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });
  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));
}

```

## video_player

Uygulama içerisinde widgetlarda video oynatmak için kullanılır.

```dart

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoApp());

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

```

## shimmer

Uygulama içerisinde arayüz yüklenirken widgetlar üzerinde parıltı efekti oluşturmak için kullanılır

```dart

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Shimmer gradient = Shimmer(
    gradient: LinearGradient(
      colors: [Colors.white, Colors.grey[200]!],
      stops: [0.2, 0.8],
    ),
    child: Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        color: Colors.grey[200]!,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yukleniyor...'),
      ),
      body: Center(
        child: Shimmer.fromChild(
          child: Text('Bu text partilti efektiyle yukleniyor...'),
        ),
      ),
    );
  }
}

```

## flutter_spinkit

Çeşitli özelleştirmelerle birlikte kullanılabilecek yükleniyor işaretleri kütüphanesidir.

```dart
const spinkit = SpinKitRotatingCircle(
  color: Colors.white,
  size: 50.0,
);

final spinkit = SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);

final spinkit = SpinKitSquareCircle(
  color: Colors.white,
  size: 50.0,
  controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
);

```

## image_cropper

Uygulama içerisinde kullanılacak fotoğrafları kırpmak için kullanılır.

```dart

import 'package:image_cropper/image_cropper.dart';

CroppedFile croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

```

## flutter_image_compress

Kullanılan görsellerin özelleştirilerek sıkıştırılması için kullanılır.

```dart


  // dosyayı sıkıstır
  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    print(file.lengthSync());
    print(result.length);
    return result;
  }

  // dosyayı sıkıstır ve getir
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 88,
        rotate: 180,
      );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

```

## go_router

Router API ile ekranlar arası navigasyonu sağlamaya yarar.

```dart


void main() => runApp(const MyApp());

// route tanimlari
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
        ),
      ],
    ),
  ],
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

// ana ekran
class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ana sayfa')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/details'),
          child: const Text('detaylara git'),
        ),
      ),
    );
  }
}

// detaylar ekrani
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('detaylar')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('ana sayfaya don'),
        ),
      ),
    );
  }
}

```

## badges

Uygulama içerisindeki widgetlara hem tasarım hem de animasyon olarak özelleştirilebilir rozetler eklemek için kullanılır.

```dart
badges.Badge(
      position: badges.BadgePosition.topEnd(top: -10, end: -12),
      showBadge: true,
      ignorePointer: false,
      onTap: () {},
      badgeContent:
          Icon(Icons.check, color: Colors.white, size: 10),
      badgeAnimation: badges.BadgeAnimation.rotation(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.square,
        badgeColor: Colors.blue,
        padding: EdgeInsets.all(5),
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderGradient: badges.BadgeGradient.linear(
            colors: [Colors.red, Colors.black]),
        badgeGradient: badges.BadgeGradient.linear(
            colors: [Colors.blue, Colors.yellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
        ),
        elevation: 0,
      ),
      child: Text('Badge'),
    ),
```

## flutter_local_notifications

Bildirim zamanı ayarlama, sesini özelleştirme, periyodik olarak gösterme gibi özellikler sunan bir kütüphanedir.

```dart
// eklentiyi baslat
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
        defaultActionName: 'Open notification');
final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux);
flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

...

void onDidReceiveLocalNotification(
    int id, String title?, String? body, String? payload) async {
  // bildirim detaylarini goster, tamam'a basilmasi durumunda sayfayi ac
  showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondScreen(payload),
              ),
            );
          },
        )
      ],
    ),
  );
}

```

## awesome_dialog

Uygulama içerisinde kullanıcıya kısa diyaloglar göstermek için kullanılır.

```dart

AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,,
            title: 'Uyari',
            desc: 'Uyari detaylari',
            btnCancelOnPress: () {
              // iptal butonuna basilirsa yapilacaklar
            },
            btnOkOnPress: () {
              // tamam butonuna basilirsa yapilacaklar
            },
            )..show();

```

> developer's note;
>
> this article only contains the main features of stated libraries. for detailed information, please check the library documentation
