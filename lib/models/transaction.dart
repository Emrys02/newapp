class Transaction {
  final String id;
  final String item;
  final int price;
  final DateTime date;
  final int? total;
  final int? specific;

  const Transaction({
    required this.id,
    required this.item,
    required this.price,
    required this.date,
    this.total,
    this.specific,
  });
}
