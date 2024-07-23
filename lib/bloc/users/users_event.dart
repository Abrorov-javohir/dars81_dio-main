part of 'users_bloc.dart';

abstract class UsersEvent {}

class GetUsersEvent extends UsersEvent {}

class AddProductEvent extends UsersEvent {
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;

  AddProductEvent(
      this.name, this.description, this.price, this.image, this.category);
}

class DeleteProductEvent extends UsersEvent {
  final int id;

  DeleteProductEvent(this.id);
}

class UpdateProductEvent extends UsersEvent {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;

  UpdateProductEvent(this.id, this.name, this.description, this.price,
      this.image, this.category);
}

class UpdateProductImageEvent extends UsersEvent {
  final int productId;
  final String newImageUrl;

  UpdateProductImageEvent(this.productId, this.newImageUrl);
}
