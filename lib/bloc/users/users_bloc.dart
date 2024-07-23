import 'package:bloc/bloc.dart';
import 'package:dars81_dio/data/repositories/users_repository.dart';
import '../../data/models/product.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository _usersRepository;

  UsersBloc({required UsersRepository usersRepository})
      : _usersRepository = usersRepository,
        super(InitialUsersState()) {
    on<GetUsersEvent>(_getUsers);
    on<AddProductEvent>(_addProduct);
    on<DeleteProductEvent>(_deleteProduct);
    on<UpdateProductEvent>(_updateProduct);
    on<UpdateProductImageEvent>(_updateProductImage);
  }

  void _getUsers(
    GetUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(LoadingUsersState());
    try {
      final products = await _usersRepository.getUsers();
      emit(LoadedUsersState(products));
    } catch (e) {
      emit(ErrorUsersState(e.toString()));
    }
  }

  void _addProduct(
    AddProductEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(LoadingUsersState());
    try {
      await _usersRepository.addUser(event.name, event.description, event.price,
          event.category, event.image);
      emit(SuccessState());
      add(GetUsersEvent());
    } catch (e) {
      emit(ErrorUsersState(e.toString()));
    }
  }

  void _deleteProduct(
    DeleteProductEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(LoadingUsersState());
    try {
      await _usersRepository.deleteProduct(event.id);
      emit(SuccessState());
      add(GetUsersEvent());
    } catch (e) {
      emit(ErrorUsersState(e.toString()));
    }
  }

  void _updateProduct(
    UpdateProductEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(LoadingUsersState());
    try {
      await _usersRepository.updateProduct(event.id, event.name, event.description, event.price, event.image, event.category);
      emit(SuccessState());
      add(GetUsersEvent());
    } catch (e) {
      emit(ErrorUsersState(e.toString()));
    }
  }

  void _updateProductImage(
    UpdateProductImageEvent event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(LoadingUsersState());

      // Add logic to update the product's image URL in your data source
      await _usersRepository.updateProductImage(
          event.productId, event.newImageUrl);

      // Fetch updated list of products
      final products = await _usersRepository.getUsers();

      emit(LoadedUsersState(products));
    } catch (e) {
      emit(ErrorUsersState(e.toString()));
    }
  }
}