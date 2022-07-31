import 'package:flutter/material.dart';
import 'package:coffee_masters/data_manager.dart';
import 'package:coffee_masters/data_model.dart';

class OrdersPage extends StatefulWidget {
  final DataManager dataManager;

  const OrdersPage({Key? key, required this.dataManager}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return widget.dataManager.cart.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your cart is empty",
              style: Theme.of(context).textTheme.headline5,
            ),
          )
        : ListView.builder(
            itemCount: widget.dataManager.cart.length,
            itemBuilder: (context, index) => OrderItem(
              item: widget.dataManager.cart[index],
              onRemove: (p) {
                setState(() {
                  widget.dataManager.cartRemove(p);
                });
              },
            ),
          );
  }
}

class OrderItem extends StatelessWidget {
  final ItemInCart item;
  final void Function(Product) onRemove;
  const OrderItem({Key? key, required this.item, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("${item.quantity}x"),
                )),
            Expanded(
                flex: 6,
                child: Text(
                  item.product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(
              flex: 2,
              child: Text(
                  "\$${(item.product.price * item.quantity).toStringAsFixed(2)}"),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      onRemove(item.product);
                    },
                    icon: const Icon(Icons.delete)))
          ],
        ),
      ),
    );
  }
}
