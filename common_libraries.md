# FLUTTER LIBRARIES

## url_launcher

Kullanıcının varsayılan uygulamasında, belirtilen linki çalıştırmak için kullanılır.

```dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://flutter.dev');

void main() => runApp(
      const MaterialApp(
        home: Material(
          child: Center(
            child: ElevatedButton(
              onPressed: _launchUrl,
              child: Text('Show Flutter homepage'),
            ),
          ),
        ),
      ),
    );

Future<void> _launchUrl() async {
  //URL'de sorun yoksa onPressed URL'i açar.
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}


// Girilen linki tarayıcıda aç.
launch('https://www.google.com');

// Spesifik adres ile haritaları aç.
launch('google.maps://maps.google.com/maps?daddr=Los+Angeles,+CA&saddr=San+Francisco,+CA');

// Belirtilen numaraya çağrı ekranına yönlendir.
launch('tel:+1777777777');

// Girilen adres ile maile yönlendir.
launch('mailto:loremipsum@example.com');

// Herhangi bir uygulama için spesifik adres belirt.
launch('twitter://status/1234567890');

```

## get

Uygulama içi navigasyon, state yönetimi ve depolama gibi işlemler için kullanılan yüksek performanslı bir kütüphanedir.

```dart

Get.to(Home());
Get.back() // Onceki ekrana dön.

var count => 0.obs;
Obx(()=> Text(count.string)); // updates the text when count changes

Get.put(Instance());
Instance inst = Get.find();
Text(inst.name);

GetStorage box = GetStorage();
box.write('key','value');
box.read('key');

Text('merhaba dunya'.tr);
Get.changeLocale(Locale('en')); // output: hello world



```

## path_provider

Dosya sisteminde sık kullanılan konumlara kolayca erişmek için kullanılır.

```dart

final Directory tempDir = await getTemporaryDirectory();
final String tempPath = tempDir.path;

final Directory? downloadsDir = await getDownloadsDirectory();
final String downloadsPath = downloadsDir.path;

```

## intro_slider

Uygulamaya slaytlar halinde giriş ekranı hazırlamak için kullanılır.
Slayt geçiş hızı, otomatik geçiş ya da slaytları atlayabilme gibi özelleştirmeler sunar.

```dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroSlider(
        slides: [
          Slide(
            title: 'Slide 1',
            description: 'Birinci slayt ekranı ve içeriği',
            image: AssetImage('assets/images/slide1.png'),
          ),
          Slide(
            title: 'Slide 2',
            description: 'İkinci slayt ekranı ve içeriği',
            image: AssetImage('assets/images/slide2.png'),
          ),
          Slide(
            title: 'Slide 3',
            description: 'Üçüncü slayt ekranı ve içeriği',
            image: AssetImage('assets/images/slide3.png'),
          ),
        ],
        onDone: () {
          // Tüm slaytlar gösterildikten sonra yapılacak işlemler.
        },
      ),
    );
  }
}

```

## local_auth

Parmak izi veya yüz tanıma gibi cihaz güvenliğiyle kimlik doğrulamak için kullanılır.

```dart

final localAuth = LocalAuth();

// Cihazda parmak izi gibi onaylama methodu olup olmadığını kontrol et.
bool canCheckBiometrics = false;

try {
  canCheckBiometrics = await localAuth.canCheckBiometrics;
} on PlatformException catch (e) {
  // Hata alınması durumunda kullanıcıyı bilgilendir.
}

// Onaylama methodu bulunuyorsa, işleme devam et.
if (canCheckBiometrics) {
  bool didAuthenticate = false;

  try {
    didAuthenticate = await localAuth.authenticateWithBiometrics(
      localizedReason: 'Devam etmek için kimliğinizi doğrulayın',
    );
  } on PlatformException catch (e) {
    // Hata alınması durumunda kullanıcıyı bilgilendir.
  }

  if (didAuthenticate) {
    // Kimlik doğrulaması yapıldıysa devam et.
  } else {
    // Hata alınması durumunda kullanıcıyı bilgilendir.
  }
}

```

## dio

Form verisi, istek iptali, dosya yükleme/indirme ve zaman aşımı gibi ağ işlemlerini destekleyen kullanımı kolay HTTP request ve response yönetim paketidir.

```dart

// GET request
Future<Response> makeGetRequest() async {
  final dio = Dio();

  final response = await dio.get('https://example.com/api/users');

  return response;
}

//POST request
Future<Response> makePostRequest() async {
  final dio = Dio();

  final data = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
  };

  final response = await dio.post('https://example.com/api/users', data: data);

  return response;
}

// Dosya indirme
Future<void> downloadFile() async {
  final dio = Dio();

  final response = await dio.download('https://example.com/file.pdf', destination: '/path/to/file.pdf');

  if (response.statusCode == 200) {
    print('Dosya basariyla indirildi.');
  } else {
    print('Dosya indirilirken bir hata olustu.');
  }
}

```

## cached_network_image

Internet üzerinden gösterilen görseli cache dizininde saklamak için kullanılır.

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CachedNetworkImage(
          imageUrl: 'https://example.com/image.jpg',
          cacheKey: 'image-key',
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}

```

## image_picker

Cihazda bulunan görsellerden seçmeye ya da kamera ile yeni görseli kullanmaya olanak sağlar.

```dart

// Galeriden seçilen fotoğrafı kullan.
Future<XFile?> pickImage() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.gallery);

  return image;
}

//Yeni fotoğraf çek.
Future<XFile?> takePicture() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.camera);

  return image;
}

```

## flutter_svg

Flutter ile SVG görsel renderlamak için kullanılır. Kullanım esnasında SVG görseli özelleştirmeye olanak tanır.

```dart

final String assetName = 'assets/arrow.svg';
final Widget svgIcon = SvgPicture.asset(
  assetName,
  colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
  semanticsLabel: 'A red arrow',
  placeholderBuilder: (BuildContext context) => Container(
      padding: const EdgeInsets.all(30.0),
      child: const CircularProgressIndicator()),
);

```

## Hive

Farklı farklı veri tiplerini depolamak için hafif ve hızlı bir yöntem sunar.
Kullanıcı ayarları, önbellek verisi, uygulama ayarları ya da daha büyük verileri saklamak için kullanılır.

```dart

import 'package:hive/hive.dart';

class UserData {
  String name;
  String email;

  UserData({required this.name, required this.email});
}

Future<void> saveUserData(UserData UserData) async {
  // Kullanıcı verilerini saklamak için bir Hive kutusu aç.
  final box = await Hive.openBox('user_settings');

  // Verileri Hive kutusuna kaydet.
  await box.put('user_settings', UserData);
}

Future<UserData> getUserData() async {
  // Kullanıcı ayarlarını Hive üzerinden al.
  final box = await Hive.openBox('user_settings');

  // Kullanıcı verilerini döndür.
  return box.get('user_settings');
}

```

## shared_preferences

Basit key-kalue depolama işlemleri için kullanılır.

```dart

final SharedPreferences prefs = await SharedPreferences.getInstance();
// Veri yazma
await prefs.setInt('counter', 10);
await prefs.setBool('repeat', true);
await prefs.setDouble('decimal', 1.5);
await prefs.setString('action', 'Start');
await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);

// Veri okuma
final int? counter = prefs.getInt('counter');
final bool? repeat = prefs.getBool('repeat');
final double? decimal = prefs.getDouble('decimal');
final String? action = prefs.getString('action');
final List<String>? items = prefs.getStringList('items');

// Veri silme
prefs.remove('counter')

```

## flutter_secure_storage

Veriyi cihazın güvenli depolamasına kaydetmek için kullanılır. Hive ve shared_preferences'a göre daha az performans daha çok güvenlik sağlar.

```dart

// Android ayarlarindan encryptedSharedPreferences parametresini aç.
AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

final storage = new FlutterSecureStorage();

// Veri yazma okuma ve silme islemleri.
await storage.write(key: 'my_key', value: 'my_data')
final data = await storage.read(key: 'my_key');
await storage.delete(key: 'my_key');

```

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

## google_fonts

[fonts.google.com](https://fonts.google.com/) fontlarını uygulama içerisinde kullanmayı sağlar.
Font üzerinde stil değişikliğine izin verir.

```dart

Text(
  'This is Google Fonts',
  style: GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.displayLarge,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  ),
),

```

## permission_handler

Cihazda bulunan uygulamalara erişim izni istemek için kullanılır.

```dart

  // Kamera iznini kontrol et
  var status = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
  // İzin verilmediyse iste
  if (status != PermissionStatus.granted) {
    await PermissionHandler().requestPermissions([PermissionGroup.camera]);
  }

  // Mikrofon iznini kontrol et
  var status = await PermissionHandler().checkPermissionStatus(PermissionGroup.microphone);
  // İzin verilmediyse iste
  if (status != PermissionStatus.granted) {
    await PermissionHandler().requestPermissions([PermissionGroup.microphone]);
  }

  // Depolama iznini kontrol et
  var status = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  // İzin verilmediyse iste
  if (status != PermissionStatus.granted) {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }


  var status = await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
  // İzin durumuna göre işlem yap
  switch (status) {
    case PermissionStatus.granted:
      // İzin verilmiş
      break;
    case PermissionStatus.denied:
      // İzin verilmemiş
      break;
    case PermissionStatus.permanentlyDenied:
      // İzin kalıcı olarak reddedilmiş
      break;
  }

```

## geolocator

Cihazın konum bilgilerine erişmek için kullanılır.

```dart

Future<Position> _determinePosition() async {

  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  // Konumun açık olup olmadığını kontrol et.
  if (!serviceEnabled) {
    return Future.error('Konum bilgisi devre dışı.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Izin reddedildiyse tekrar izin iste.
      return Future.error('Konum erişimi reddedildi.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Izın kalıcı olarak reddedildiyse bilgilendir.
    return Future.error(
      'Konum izni devre dışı. Erişim için uygulamaya izin verin.');
  }

  // Cihazın konumunu al.
  return await Geolocator.getCurrentPosition();
}

```

## intl

Tarih, para birimi veya metin çevirisi gibi işlemleri kullanıcının konumuna göre yerelleştirmek için kullanılır.

```dart

// Anlık tarihi GG/AA/YYYY şeklinde string olarak formatla.
DateFormat dateFormat = DateFormat.dMy();
String formattedDate = dateFormat.format(DateTime.now());

// Girilen sayıyı belirtilen para birimi olarak formatla
NumberFormat numberFormat = NumberFormat.currency(locale: 'en_US');
String formattedNumber = numberFormat.format(123.45) // $123.45

// Girilen mesajı cihazın yerel ayarlarına göre formatla.
String message = Intl.message('hello world', desc: 'A greeting');

// Bidirectional formatlayıcı ile girilen mesajı istenen dile çevir.
BidiFormatter bidiFormatter = BidiFormatter.wrapText('Hello, world!', locale: 'ar');
String formattedText = bidiFormatter.toString(); // Soldan sağa arapça olarak çevir.

```

## auto_size_text

Girilen metnin belirtilen satır sayısına kendisini sığdırması için kullanılır.

```dart

AutoSizeText(
  'Cok uzun bir metin',
  style: TextStyle(fontSize: 30),
  minFontSize: 18,
  maxLines: 4,
  overflow: TextOverflow.ellipsis,
)

```

## file_picker

Uygulama içerisinden cihaz dosya yöneticisini kullanarak dosya seçmek için kullanılır.
Seçilecek dosyanın uzantısını belirleme esnekliği sunar.

```dart

FilePickerResult? result = await FilePicker.platform.pickFiles();

if (result != null) {
  File file = File(result.files.single.path);
} else {
  // Kullanici secimi iptal etti
}

// Birden fazla dosya secimi
FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

if (result != null) {
  List<File> files = result.paths.map((path) => File(path)).toList();
} else {
  // Kullanici secimi iptal etti
}

// Dosya uzantisi filtreleyerek secim
FilePickerResult? result = await FilePicker.platform.pickFiles(
  type: FileType.custom,
  allowedExtensions: ['jpg', 'pdf', 'doc'],
);

// Secilen dosyanin detaylarini goster
FilePickerResult? result = await FilePicker.platform.pickFiles();

if (result != null) {
  PlatformFile file = result.files.first;

  print(file.name);
  print(file.bytes);
  print(file.size);
  print(file.extension);
  print(file.path);
} else {
   // Kullanici secimi iptal etti
}

```

> developer's note;
>
> this article only contains the main features of stated libraries. for detailed information, please check the library documentation
