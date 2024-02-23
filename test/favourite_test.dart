import 'package:flutter_test/flutter_test.dart';
import 'package:testing_codelabs/models/favourites.dart';

void main() {
  group("Testing App Provider Test => ", () {
    var favourite = Favourite();

    test("A new item should be added", () {
      int numberToAdd = 3;
      favourite.add(numberToAdd);

      // Case we're expecting is a sutation where the favoriteItemsList
      // contains the number in variable numberToAdd
      expect(
        favourite.items.contains(numberToAdd),
        true,
      );
    });

    test("An Item should be removed", () {
      int numberToPlayWith = 20;

      favourite.add(numberToPlayWith);

      expect(
        favourite.items.contains(numberToPlayWith),
        true,
      );

      favourite.remove(numberToPlayWith);

      expect(
        favourite.items.contains(numberToPlayWith),
        false,
      );
    });
  });
}
