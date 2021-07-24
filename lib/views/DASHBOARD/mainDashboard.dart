import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/mainDrawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:MOrder/views/MATERIAL/bottomBar.dart';

class MainDashBoard extends StatefulWidget {
  final int productName;

  const MainDashBoard(this.productName);

  @override
  _MainDashBoardState createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  List<charts.Series<Products, String>> _seriesBarData;
  _generateData() {
    var barData = [
      new Products("Cookies", 19.5, Colors.lightBlueAccent),
      new Products("Cakes", 37.0, Colors.orangeAccent),
      new Products("Fruits", 49.0, Colors.lightGreenAccent),
      new Products("Chocolate", 67.8, Colors.lightBlueAccent),
    ];

    _seriesBarData.add(
      charts.Series(
          data: barData,
          domainFn: (Products products, _) => products.Targer_v,
          measureFn: (Products products, _) => products.Achieved_v,
          colorFn: (Products products, _) =>
              charts.ColorUtil.fromDartColor(products.color_v),
          id: "Daily Income",
          labelAccessorFn: (Products products, _) => '${products.Achieved_v}'),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesBarData = List<charts.Series<Products, String>>();
    _generateData();
  }

  Material myItems(IconData icon, String headline, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.black12,
      borderRadius: BorderRadius.circular(14.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        (headline),
                        style: TextStyle(color: Color(color), fontSize: 14.0),
                      ),
                    ),
                  ),
                  Material(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("DASH BOARD"),
      ),
      drawer: MainDrawer(),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          myItems(Icons.graphic_eq, "TARGET", 0XFFCD622B),
          myItems(Icons.unarchive, "ACHIEVED", 0XFF1D852B),
          myItems(Icons.account_balance_wallet, "BALANCE", 0XFF6D852B),
          myItems(Icons.margin, "GP MARGIN", 0XFF7B622B),
          Container(
            // padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            // color: Colors.red,
            child: charts.PieChart(
              _seriesBarData,
              animate: true,
              animationDuration: Duration(seconds: 4),
              behaviors: [
                charts.DatumLegend(
                    outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                    horizontalFirst: false,
                    desiredMaxRows: 2,
                    cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                    entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.purple.shadeDefault,
                        fontSize: 11))
              ],
              defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 100,
                  arcRendererDecorators: [
                    charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.inside)
                  ]),
            ),
          ),
          myItems(Icons.account_balance_wallet, "BALANCE", 0XFF6D852B),
          myItems(Icons.margin, "GP MARGIN", 0XFF7B622B),
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(2, 200.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}

class Products {
  String Targer_v;
  double Achieved_v;
  Color color_v;

  Products(this.Targer_v, this.Achieved_v, this.color_v);
}
