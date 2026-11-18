const menu = {
  'Adobo rice': 85.0,
  'Iced tea': 35.0,
  'Turon': 25.0,
};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem(this.name, this.price, this.qty);

  double get subtotal => price * qty;
}

OrderItem orderOf(String name, int qty) {
  final price = menu[name];

  if (price == null) {
    throw ArgumentError('Item $name is not on the menu.');
  }

  return OrderItem(name, price, qty);
}

double total(List<OrderItem> items) {
  return items.fold(
    0.0,
    (sum, item) => sum + item.subtotal,
  );
}

void printReceipt(List<OrderItem> items, {String? customer}) {
  final customerName = customer ?? 'Guest';
  final subtotal = total(items);

  final discount = subtotal >= 300 ? subtotal * 0.10 : 0.0;
  final finalTotal = subtotal - discount;

  print('\nOrder for $customerName');

  for (var item in items) {
    final description = '${item.qty} x ${item.name}';

    print(
      '${description.padRight(19)}'
      '${item.subtotal.toStringAsFixed(2).padLeft(6)}',
    );
  }

  print(
    '${'Subtotal'.padRight(19)}'
    '${subtotal.toStringAsFixed(2).padLeft(6)}',
  );

  if (discount > 0) {
    print(
      '${'Discount 10%'.padRight(19)}'
      '${('-${discount.toStringAsFixed(2)}').padLeft(6)}',
    );
  }

  print(
    '${'Total'.padRight(19)}'
    '${finalTotal.toStringAsFixed(2).padLeft(6)}',
  );
}

void main() {
  final guestOrder = [
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ];

  printReceipt(guestOrder);

  final customerOrder = [
    orderOf('Adobo rice', 1),
    orderOf('Iced tea', 1),
    orderOf('Turon', 1)
  ];

  printReceipt(customerOrder, customer: 'Dee Jae');
}