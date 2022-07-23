import 'package:flutter/material.dart';

class SampleItemListView extends StatelessWidget {
  SampleItemListView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  final List<int> items = [1, 1, 6, 1, 6, 7, 2, 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RowRenderer(
            items: items,
            filterMethod: (index, element) {
              return index % 2 == 0;
            },
          ),
          RowRenderer(
            items: items,
            filterMethod: (index, element) {
              return index % 2 != 0;
            },
          ),
        ],
      ),
    );
  }
}

class RowRenderer extends StatelessWidget {
  const RowRenderer({
    Key? key,
    required this.items,
    required this.filterMethod,
  }) : super(key: key);

  final List<int> items;
  final bool Function(int, int) filterMethod;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...items
            .indexedFilter(filterMethod)
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(e.toString()),
                ))
            .toList(),
      ],
    );
  }
}

extension IndexedFilter<T> on Iterable<T> {
  Iterable<T> indexedFilter(bool Function(int index, T element) f) {
    List<T> res = [];
    for (var i = 0; i < length; i++) {
      if (f(i, elementAt(i))) {
        res.add(elementAt(i));
      }
    }
    return res;
  }
}
