import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_codelabs/models/favourites.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  static const routeName = 'favourite';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Favourite"),
      ),
      child: SafeArea(
        child: Consumer<Favourite>(
          builder: (context, value, child) => ListView.builder(
            itemCount: value.items.length,
            itemBuilder: (context, index) => FavouriteItemTile(
              itemNo: value.items[index],
            ),
          ),
        ),
      ),
    );
  }
}

class FavouriteItemTile extends StatelessWidget {
  const FavouriteItemTile({super.key, required this.itemNo});
  final int itemNo;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(0.8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
          ),
          title: Text(
            "Item Number: $itemNo",
            key: Key('favorites_text_$itemNo'),
          ),
          trailing: IconButton(
            key: Key("remove_icon_$itemNo"),
            onPressed: () {
              Provider.of<Favourite>(context, listen: false).remove(itemNo);
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return const CupertinoActionSheet(
                    title: Text(
                      "Removed from favourites.",
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.close),
          ),
        ),
      ),
    );
  }
}
