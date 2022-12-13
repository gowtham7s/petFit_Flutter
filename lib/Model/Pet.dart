class Pet {
  int? id;
  String? name;
  String? dob;
  String? location;
  String? breed;
  String? ownerDetails;

  petMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['dob'] = dob;
    mapping['location'] = location;
    mapping['breed'] = breed;
    mapping['ownerDetails'] = ownerDetails;
    return mapping;
  }
}

class Product {
  int? id;
  String? name;
  String? image;
  int? price;
  int? quantity;

  productMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['image'] = image;
    mapping['price'] = price;
    mapping['quantity'] = quantity;
    return mapping;
  }
}


class Schedule {
  int? id;
  int? petId;
  String? name;
  String? whenDate;
  String? notes;

  scheduleMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['petId'] = petId;
    mapping['name'] = name;
    mapping['whenDate'] = whenDate;
    mapping['notes'] = notes;
    return mapping;
  }
}

class Feedbacks {
  int? id;
  String? expression;
  String? category;
  String? feedback;

  feedbackMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['expression'] = expression;
    mapping['category'] = category;
    mapping['feedback'] = feedback;
    return mapping;
  }
}