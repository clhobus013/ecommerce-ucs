class Rate {
  final num rate;
  final int count;

  const Rate({required this.rate, required this.count});

  factory Rate.fromJson(Map<String, dynamic> json) =>
      Rate(rate: json['rate'], count: json['count']);
}
