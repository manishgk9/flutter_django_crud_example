class Student {
  int? id;
  String? name;
  String? address;
  int? phone;

  Student({this.id, this.name, this.address, this.phone});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}
