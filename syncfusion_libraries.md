# Syncfusion Libraries

## syncfusion_flutter_charts

Veri görüntüleme ve grafik oluşturmak için kullanılır. Grafik tipini ve animasyonlarını seçme özelleştirmeleri sunar.

Veriye gore grafik olusturulur ve kaynak veriyle baglanir.

```dart

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
        child: Container(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),

            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                // veri kaynagi baglanir
                dataSource:  <SalesData>[
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 34),
                  SalesData('Apr', 32),
                  SalesData('May', 40)
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales
              )
            ]
          )
        )
      )
  );
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}




// spark chart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
        child: Container(
          child: SfSparkLineChart(
              data: <double>[
                1, 5, -6, 0, 1, -2, 7, -7, -4, -10, 13, -6, 7, 5, 11, 5, 3
              ],
            )
        )
      )
  );
}

```

## syncfusion_flutter_calendar

Farklı takvim formatları ve farklı görünüş formatları destekleyen takvimler göstermek için kullanılır.

```dart

// takvim gorunusunu ay olarak ayarla
@override
Widget build(BuildContext context) {
  return Scaffold(
      body: SfCalendar(
    view: CalendarView.month,
  ));
}

// calisma gun ve saati belirt
@override
Widget build(BuildContext context) {
  return Scaffold(
      body: SfCalendar(
    view: CalendarView.workWeek,
    timeSlotViewSettings: TimeSlotViewSettings(
        startHour: 9,
        endHour: 16,
        nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
  ));
}

// aylik ajanda gorunumu
@override
Widget build(BuildContext context) {
  return Scaffold(
      body: SfCalendar(
    view: CalendarView.month,
    monthViewSettings: MonthViewSettings(showAgenda: true),
  ));
}


```

## syncfusion_flutter_datepicker

Kullanıcıya tarih seçtirmek için kullanılır. Tek, birden çok ya da belirli bir tarih aralığı seçmek için kullanılır. Minimum veya maksimum tarih aralığı seçme özelliği sunar.

```dart
// minimum tarih belirtme
@override
Widget build(BuildContext context) {
    return Scaffold(
       body: SfDateRangePicker(
      view: DateRangePickerView.month,
      minDate: DateTime(2020, 03, 05, 10 , 0, 0),
     )
  );
}

// maksimum tarih belirtme
@override
Widget build(BuildContext context) {
    return Scaffold(
       body: SfDateRangePicker(
       view: DateRangePickerView.month,
       maxDate: DateTime(2020, 03, 25, 10 , 0, 0),
       )
   );
}


// ozel gun, hafta sonu gibi gunleri ozellestirerek goster
@override
Widget build(BuildContext context) {
    return Scaffold(
        body: SfDateRangePicker(
          view: DateRangePickerView.month,
          monthViewSettings:DateRangePickerMonthViewSettings(blackoutDates:[DateTime(2020, 03, 26)],
              weekendDays: [7,6],
              specialDates:[DateTime(2020, 03, 20),DateTime(2020, 03, 16),DateTime(2020,03,17)],
              showTrailingAndLeadingDates: true),
          monthCellStyle: DateRangePickerMonthCellStyle(
            blackoutDatesDecoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(color: const Color(0xFFF44436), width: 1),
                shape: BoxShape.circle),
            weekendDatesDecoration: BoxDecoration(
                color: const Color(0xFFDFDFDF),
                border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                shape: BoxShape.circle),
            specialDatesDecoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: const Color(0xFF2B732F), width: 1),
                shape: BoxShape.circle),
            blackoutDateTextStyle: TextStyle(color: Colors.white, decoration: TextDecoration.lineThrough),
            specialDatesTextStyle: const TextStyle(color: Colors.white),
          ),
        )
    );
}

```

## syncfusion_flutter_gauges

Uygulama içi özelleştirilebilir gösterge için kullanılır. Göstergede aralıkları belirleme, rengini veya rotasyonunu değiştirme gibi özelleştirmeler sunar.

```dart
// linear gosterge
@override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                body: Center(
                   child: SfLinearGauge(minimum: 100, maximum: 200)
                )
            )
        );
    }


// radial gosterge
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: Center(
        child: Container(
          child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(minimum: 0, maximum: 150,
            ranges: <GaugeRange>[
              GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
              GaugeRange(startValue: 50,endValue: 100,color: Colors.orange),
              GaugeRange(startValue: 100,endValue: 150,color: Colors.red)],
            pointers: <GaugePointer>[
              NeedlePointer(value: 90)],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(widget: Container(child:
                 Text('90.0',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                 angle: 90, positionFactor: 0.5
              )]
          )])
      ))),
    );
  }


```

## syncfusion_flutter_sliders

Uygulama içerisinde özelleştirilebilir slider göstermek için kullanılır.

```dart

// horizontal slider
double _value = 40.0;

@override
Widget build(BuildContext context) {
  return Scaffold(
     appBar: AppBar(
       title: const Text('Syncfusion Flutter Slider'),
     ),
     body: SfSlider(
       min: 0.0,
       max: 100.0,
       value: _value,
       interval: 20,
       showTicks: true,
       showLabels: true,
       enableTooltip: true,
       minorTicksPerInterval: 1,
       onChanged: (dynamic value){
         setState(() {
           _value = value;
         });
       },
     ),
   );
}

//range slider
SfRangeValues _values = SfRangeValues(40.0, 80.0);

@override
Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Syncfusion Flutter Range Slider'),
     ),
     body: SfRangeSlider(
        min: 0.0,
        max: 100.0,
        values: _values,
        interval: 20,
        showTicks: true,
        showLabels: true,
        enableTooltip: true,
        minorTicksPerInterval: 1,
        onChanged: (SfRangeValues values){
          setState(() {
            _values = values;
          });
        },
      ),
   );
}

```

## syncfusion_flutter_pdf

Uygulama içerisinde PDF görüntüleme, oluşturma veya düzenleme gibi özellikler sunar.

```dart
// yeni bir PDF olustur
final PdfDocument document = PdfDocument();
// sayfa ekle ve yaz
document.pages.add().graphics.drawString(
    'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 12),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    bounds: const Rect.fromLTWH(0, 0, 150, 20));
// dosyayi kaydet
File('HelloWorld.pdf').writeAsBytes(await document.save());
document.dispose();


```

## syncfusion_flutter_datagrid

Grid tablo şeklinde veri göstermek veya düzenlemek için kullanılır.Kullanabilmek için Syncfusion ticari lisans veya topluluk lisansı gerektirir.

```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('data grid'),
        ),
        body: SfDataGrid(
          source: MyDataSource(),
          columns: [
            GridColumn(
              columnName: 'Id',
              label: Text('Id'),
              width: 100,
            ),
            GridColumn(
              columnName: 'Isim',
              label: Text('isim'),
              width: 200,
            ),
            GridColumn(
              columnName: 'meslek',
              label: Text('meslek'),
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}

class MyDataSource extends DataGridSource {
  final List<Employee> _employees = [
    Employee(1, 'John Doe', 'Software Engineer'),
    Employee(2, 'Foo Bar', 'Colonel'),
    Employee(3, 'Peter Parker', 'Spiderman'),
  ];

  @override
  List<DataGridRow> get rows => _employees
      .map((employee) => DataGridRow(
          cells: [
            DataGridCell<int>(columnName: 'Id', value: employee.id),
            DataGridCell<String>(columnName: 'Isim', value: employee.name),
            DataGridCell<String>(
                columnName: 'Meslek', value: employee.occupation),
          ]))
      .toList();
}

class Employee {
  final int id;
  final String isim;
  final String meslek;

  Employee(this.id, this.isim, this.meslek);
}

```

## syncfusion_flutter_maps

Uygulama içerisinde özelleştirilebilir ve interaktif harita modelleri oluşturmak için kullanılır. Kullanabilmek için Syncfusion ticari lisans veya topluluk lisansı gerektirir.

```dart
late MapShapeSource dataSource;

@override
void initState() {
  dataSource = MapShapeSource.asset(
    'assets/world_map.json',
    shapeDataField: 'continent',
  );
  super.initState();
}

@override
Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SfMaps(
          layers: <MapLayer>[
            MapShapeLayer(
              source: dataSource,
              loadingBuilder: (BuildContext context) {
                return Container(
                  height: 25,
                  width: 25,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
              },
            ),
          ],
        ),
      ),
   );
}
```

## syncfusion_flutter_xlsio

Uygulama içerisinde Excel tablosu oluşturmak için kullanılır.

```dart

// yeni bir excel dosyasi olustur
final Workbook workbook = new Workbook();

// index ile dosyaya ulas
workbook.worksheets[0];

// dosyayi kaydet
final List<int> bytes = workbook.saveAsStream();
File('CreateExcel.xlsx').writeAsBytes(bytes);
workbook.dispose();




// yeni dosya olustur
final Workbook workbook = new Workbook();
// index ile dosyay ulas
final Worksheet sheet = workbook.worksheets[0];
sheet.getRangeByName('A1').setText('Hello World');
sheet.getRangeByName('A3').setNumber(44);
sheet.getRangeByName('A5').setDateTime(DateTime(2020,12,12,1,10,20));

final List<int> bytes = workbook.saveAsStream();
File('AddingTextNumberDateTime.xlsx').writeAsBytes(bytes);
workbook.dispose();





sheet.getRangeByName('A1').setNumber(22);
sheet.getRangeByName('A2').setNumber(44);
// dosya icin formulleri aktiflestir
sheet.enableSheetCalculations();

// hucre icin hesaplama formulu gir
sheet.getRangeByName('A3').setFormula('=A1+A2');

// kaydet
final List<int> bytes = workbook.saveAsStream();
File('AddingFormula.xlsx').writeAsBytes(bytes);
//Dispose the workbook.
workbook.dispose();

```
