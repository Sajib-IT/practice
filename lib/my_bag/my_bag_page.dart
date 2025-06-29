import 'package:flutter/material.dart';
import 'package:practice/my_bag/helper.dart';
import 'package:practice/my_bag/widget/circle_icon_button.dart';
import 'package:practice/my_bag/widget/my_elevated_button.dart';
import 'package:practice/my_bag/widget/my_rich_text.dart';

class MyBagPage extends StatefulWidget {
  const MyBagPage({super.key});

  @override
  State<MyBagPage> createState() => _MyBagPageState();
}

class _MyBagPageState extends State<MyBagPage> {
  Helper helper = Helper();
  int totalAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Bag")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final product = helper.products[index];
                String url = product['productImg'];
                String title = product['title'];
                String color = product['color'];
                String size = product['size'];
                int price = product['price'];
                int item = product['item'];
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(url, fit: BoxFit.cover, height: 140),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                MyRichText(title: "Color: ", value: color),
                                SizedBox(width: 8),
                                MyRichText(title: "Size: ", value: size),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                CircleIconButton(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    if(item != 0) {
                                      removeItem(index);
                                    }
                                  },
                                ),
                                SizedBox(width: 8),
                                Text(
                                  item.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 8),
                                CircleIconButton(
                                  icon: Icons.add,
                                  onPressed: () {
                                    addItem(index);
                                    // calculate(item, price);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        SizedBox(
                          height: 95,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.more_vert),
                              // SizedBox(height: 12,),
                              Text(
                                "$price\$",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
              itemCount: helper.products.length,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total amount:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "$totalAmount\$",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: MyElevatedButton(text: "Check out", onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Congratulations! Your order has been placed.'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );

              }),
            ),
          ],
        ),
      ),
    );
  }

  void addItem(int index) {
    final product = helper.products[index];
    product['item']++;
    setState(() {
      calculate();
    });
  }

  void removeItem(int index) {
    final product = helper.products[index];
    product['item']--;
    setState(() {
      calculate();
    });
  }

  void calculate() {
    final products = helper.products;
    // for(int i = 0; i<= products.length; i++){
    //   totalAmount = products[i]['item']*products[i]['price'];
    // }
    totalAmount =
        products[0]['item'] * products[0]['price'] +
        products[1]['item'] * products[1]['price'] +
        products[2]['item'] * products[2]['price'];
    setState(() {});
  }
}
