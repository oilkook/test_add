class Order {
  String id;
  String name;
  String room;
  String dormitory;
  String status;

  Order({
    this.id,
    this.name,
    this.room,
    this.dormitory,
    this.status,
  });

  @override
  toString() {
    return '$id $name $room $dormitory $status';
  }
}
