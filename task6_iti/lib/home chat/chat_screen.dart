import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../api_provider.dart';
import '../components/search.dart';
import '../controller/cubit/products_cubit.dart';
import '../controller/cubit/products_state.dart';

class ChatsScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const ChatsScreen({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(ApiProvider())..fetchProducts(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            const MySearchBar(),
            const Divider(height: 1),
            const Expanded(child: _ProductsGrid()),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('Assets/images/image.png'),
        ),
      ),
      title: const Text(
        "Products",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: onToggleTheme,
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is ProductsLoaded) {
          return _buildGrid(context, state.products);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildGrid(BuildContext context, List products) {
    return MasonryGridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final heightFactor = (index % 2 + 3.5) * 60.0;

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          height: heightFactor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.thumbnail ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                product.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[400]
                      : Colors.grey[700],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${product.price?.toStringAsFixed(2)} \$',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
