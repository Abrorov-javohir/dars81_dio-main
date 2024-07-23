import 'package:dars81_dio/bloc/users/users_bloc.dart';
import 'package:dars81_dio/ui/screens/download_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/product.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  Future<void> _pickImage(
      BuildContext context, Function(String) onImagePicked) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      String uploadedImageUrl = await _uploadImage(image);
      onImagePicked(uploadedImageUrl);
    }
  }

  Future<String> _uploadImage(XFile image) async {
    // Implement your image upload logic here and return the image URL
    return 'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg/${image.name}';
  }

  void _showAddProductDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController categoryIdController = TextEditingController();
    String imageUrl = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mahsulot qo\'shish'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nomi'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Tavsifi'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Narxi'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: categoryIdController,
                  decoration: const InputDecoration(labelText: 'Kategoriya ID'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _pickImage(context, (pickedImageUrl) {
                      imageUrl = pickedImageUrl;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Rasm muvaffaqiyatli tanlandi')),
                      );
                    });
                  },
                  child: const Text('Rasm tanlash'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Bekor qilish'),
            ),
            TextButton(
              onPressed: () {
                String name = nameController.text;
                String description = descriptionController.text;
                double? price = double.tryParse(priceController.text);
                String categoryId = categoryIdController.text;

                if (name.isNotEmpty &&
                    description.isNotEmpty &&
                    price != null &&
                    categoryId.isNotEmpty &&
                    imageUrl.isNotEmpty) {
                  context.read<UsersBloc>().add(
                        AddProductEvent(
                            name, description, price, imageUrl, categoryId),
                      );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Iltimos, barcha maydonlarni to\'ldiring')),
                  );
                }
              },
              child: const Text('Qo\'shish'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(BuildContext context, Product product) {
    final TextEditingController nameController =
        TextEditingController(text: product.title);
    final TextEditingController descriptionController =
        TextEditingController(text: product.description);
    final TextEditingController priceController =
        TextEditingController(text: product.price.toString());
    final TextEditingController categoryIdController =
        TextEditingController(text: product.category.toString());
    String imageUrl = product.images.isNotEmpty ? product.images.first : '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mahsulotni tahrirlash'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nomi'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Tavsifi'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Narxi'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: categoryIdController,
                  decoration: const InputDecoration(labelText: 'Kategoriya ID'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _pickImage(context, (pickedImageUrl) {
                      imageUrl = pickedImageUrl;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Rasm muvaffaqiyatli tanlandi')),
                      );
                    });
                  },
                  child: const Text('Rasm tanlash'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Bekor qilish'),
            ),
            TextButton(
              onPressed: () {
                String name = nameController.text;
                String description = descriptionController.text;
                double? price = double.tryParse(priceController.text);
                String categoryId = categoryIdController.text;

                if (name.isNotEmpty &&
                    description.isNotEmpty &&
                    price != null &&
                    categoryId.isNotEmpty &&
                    imageUrl.isNotEmpty) {
                  context.read<UsersBloc>().add(
                        UpdateProductEvent(product.id, name, description, price,
                            imageUrl, categoryId),
                      );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Iltimos, barcha maydonlarni to\'ldiring')),
                  );
                }
              },
              child: const Text('Yangilash'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            onPressed: () {
              _showAddProductDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        bloc: context.read<UsersBloc>()..add(GetUsersEvent()),
        listener: (context, state) {
          if (state is SuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product operation successful")),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingUsersState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorUsersState) {
            return Center(
              child: Text(state.message),
            );
          }

          List<Product> products = [];

          if (state is LoadedUsersState) {
            products = state.users;
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (ctx, index) {
              final product = products[index];
              return ListTile(
                leading: InkWell(
                  onTap: () {
                    _pickImage(context, (imageUrl) {
                      context.read<UsersBloc>().add(
                            UpdateProductImageEvent(product.id, imageUrl),
                          );
                    });
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(product.images.first),
                  ),
                ),
                title: Text("${product.title}\n ${product.price} dollar"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _showEditProductDialog(context, product);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<UsersBloc>().add(
                              DeleteProductEvent(product.id),
                            );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                subtitle: Text(product.description),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home_filled,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DownloadVideoScreen();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.video_call,
              ),
            )
          ],
        ),
      ),
    );
  }
}
