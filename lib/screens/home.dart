import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testing_codelabs/models/favourites.dart';
import 'package:testing_codelabs/screens/favourite.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text("Testing Sample"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/${FavouriteScreen.routeName}');
        },
        child: const Icon(Icons.favorite_rounded),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 100,
          cacheExtent: 20,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => ItemTile(itemNo: index),
        ),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.itemNo});
  final int itemNo;

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<Favourite>(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: CupertinoListTile.notched(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo',
          key: Key('text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: favoritesList.items.contains(itemNo)
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          onPressed: () {
            !favoritesList.items.contains(itemNo)
                ? favoritesList.add(itemNo)
                : favoritesList.remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(favoritesList.items.contains(itemNo)
                    ? 'Added to favorites.'
                    : 'Removed from favorites.'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
