import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_app/Widgets/TextForm.dart';
import '../Constant/Colors.dart';

class Home_Page extends StatefulWidget {
  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final List<Map<String, TextEditingController>> _controllers = [
    {'name': TextEditingController(), 'price': TextEditingController()}
  ];

  double totalprice = 0;

  void addprice() {
    setState(() {
      _controllers.add({
        'name': TextEditingController(),
        'price': TextEditingController(),
      });
    });
  }

  void removeprice(int index) {
    setState(() {
      _controllers[index]['name']?.dispose();
      _controllers[index]['price']?.dispose();
      _controllers.removeAt(index);
      calculation();
    });
  }

  void calculation() {
    double total = 0.0;
    for (var controllerMap in _controllers) {
      double price = double.tryParse(controllerMap['price']?.text ?? '') ?? 0.0;
      total += price;
    }
    setState(() {
      totalprice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 7),
                blurRadius: 8,
                spreadRadius: -4,
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(
              child: Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.w600, color: blue),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: _controllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  var controllerMap = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppTextForm(
                            hintText: 'Name Product',
                            controller: controllerMap['name']!,
                            keybordType: TextInputType.text,
                          ),
                        ),
                        SizedBox(width: 15),
                        SizedBox(
                          width: 110,
                          child: AppTextForm(
                            hintText: 'Price',
                            controller: controllerMap['price']!,
                            keybordType: TextInputType.phone,
                            onChanged: (value) {
                              calculation();
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => removeprice(index),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        shape: CircleBorder(),
        onPressed: addprice,
        child: Icon(
          Icons.add,
          color: white,
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
        child: BottomAppBar(
          height: 105,
          color: white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$ $totalprice',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: blue),
                child: Center(
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: white,
                        fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
