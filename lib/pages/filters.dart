import 'package:flutter/material.dart';

enum Filter { glutenFree, latoseFree, vegan, vegetables }

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  bool _glutenFreeFilterSet = false;
  bool _latoseFreeFilterSet = false;
  bool _veganFilterSet = false;
  bool _vegetablesFilterSet = false;

  @override
  void initState() {
    // TODO: implement initState
    // so that we can keep the state as we set before even if we pop the drawer
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _latoseFreeFilterSet = widget.currentFilters[Filter.latoseFree]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
    _vegetablesFilterSet = widget.currentFilters[Filter.vegetables]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      // drawer: MainDrawer(
      //   onSelect: (identifier) {
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (ctx) => const TabsPage()));
      //     } else {
      //       Navigator.of(context).pop();
      //     }
      //   },
      // ),
      // when pop screen, it will return data
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.latoseFree: _latoseFreeFilterSet,
            Filter.vegan: _veganFilterSet,
            Filter.vegetables: _vegetablesFilterSet
          });
          // since, manually adding pop screen, making sure return false to not popping twice
          return false;
        },
        child: Column(children: [
          SwitchListTile(
            value: _glutenFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _glutenFreeFilterSet = isChecked;
              });
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _latoseFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _latoseFreeFilterSet = isChecked;
              });
            },
            title: Text(
              'Latose-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include latose-free meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _veganFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _veganFilterSet = isChecked;
              });
            },
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include vegan meals.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _vegetablesFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _vegetablesFilterSet = isChecked;
              });
            },
            title: Text(
              'Vegetables',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include vegetables.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          )
        ]),
      ),
    );
  }
}
