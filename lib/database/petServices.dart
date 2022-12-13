import 'package:pet_fit/Model/Pet.dart';
import 'package:pet_fit/database/db_manager.dart';

class PetServices {
  late DBManager _dbManager = DBManager();
  petServices() {
    _dbManager = DBManager();
  }

  savePet(Pet pet) async {
    return await _dbManager.insertData("pets", pet.petMap());
  }

  removePet(int id) async {
    return await _dbManager.deleteDataById("pets", id);
  }

  saveProduct(Product product) async {
    return await _dbManager.insertData("products", product.productMap());
  }

  removeProduct(int id) async {
    return await _dbManager.deleteDataById("products", id);
  }

  readAllData() async {
    return await _dbManager.readData('pets');
  }

  readAllProducts() async {
    return await _dbManager.readData('products');
  }

  saveSchedule(Schedule schedule) async {
    return await _dbManager.insertData("schedule", schedule.scheduleMap());
  }

  removeSchedule(int id) async {
    return await _dbManager.deleteDataById("schedule", id);
  }

  readAllSchedules(int id) async {
    return await _dbManager.readDataByField('schedule','petId', id);
  }

  saveFeedback(Feedbacks feedback) async {
    return await _dbManager.insertData("feedback", feedback.feedbackMap());
  }

  readAllFeedbacks() async {
    return await _dbManager.readData('feedback');
  }
}