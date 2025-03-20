# generic_selector

A package to help you select stuff, without having to worry about writing all that selecting logic, or being forced to use a radio button. A flexible, customizable Flutter selector widget that supports both single and multi-select modes with multiple layout options.

## Features

* **Type-safe selections** - Works with any data type through generics
* **Multiple layouts** - Column, row, wrap, or grid layouts to fit your UI needs
* **Single & multi-select modes** - Choose between allowing one or multiple selections
* **Extensible architecture** - Create custom selectable widgets that work with the selector
* **Fully customizable** - Bring your own selectable widgets (This is the best part btw), design exactly how you want your widget to behave when selected, deselected, etc. No more radio buttons lol

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  generic_selector: ^latest_version
```

Run `flutter pub get` to install.

## Usage

### Basic example with strings

```dart
GenericSelector<String, SelectableChip>(
  items: ['Apple', 'Banana', 'Cherry', 'Date'],
  onItemSelected: (selectedItems) {
    print('Selected: $selectedItems');
  },
  selectableWidgetBuilder: (item, isSelected, onPressed) {
    return SelectableChip(
      label: Text(item),
      isSelected: isSelected,
      onSelected: onPressed,
    );
  },
)
```

### Multi-select with custom objects

```dart
class Product {
  final String name;
  final double price;
  
  Product(this.name, this.price);
}

// In your widget build method:
GenericSelector<Product, SelectableProductCard>(
  isMultiSelectMode: true,
  layout: SelectorLayout.wrap, 
  items: [
    Product('Shirt', 29.99),
    Product('Pants', 49.99),
    Product('Shoes', 79.99),
  ],
  onItemSelected: (selectedProducts) {
    // Do something with the selected item
    double total = selectedProducts.fold(
      0, (sum, product) => sum + product.price);

    print('Total: \$${total.toStringAsFixed(2)}');
  },
  selectableWidgetBuilder: (product, isSelected, onPressed) {
    return SelectableProductCard(
      product: product,
      isSelected: isSelected,
      onSelected: onPressed,
    );
  },
)
```

### Creating a custom selectable widget

Implement the `SelectableWidget` abstract class:

```dart
class SelectableChip extends StatelessWidget implements SelectableWidget {
  final Widget label;
  @override
  final bool isSelected; // Use this to change the appearance of your widget when selected
  @override
  final VoidCallback onSelected; // Callback to be called when the widget is selected, this will be handled by the Generic Selector

  const SelectableChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: label,
      selected: isSelected,
      onSelected: (_) => onSelected(),
    );
  }
}
```

## Available layouts

The GenericSelector supports four layouts:

- **Column**: Arranges items vertically
- **Row**: Arranges items horizontally
- **Wrap**: Arranges items in rows, wrapping to new lines when needed
- **Grid**: Arranges items in a grid layout

```dart
// Row layout (default)
GenericSelector<String, SelectableChip>(
  layout: SelectorLayout.row,
  // Other properties...
)

// Column layout
GenericSelector<String, SelectableChip>(
  layout: SelectorLayout.column,
  // Other properties...
)

// Wrap layout
GenericSelector<String, SelectableChip>(
  layout: SelectorLayout.wrap,
  wrapSpacing: 8.0,
  wrapRunSpacing: 8.0,
  // Other properties...
)

// Grid layout
GenericSelector<String, SelectableChip>(
  layout: SelectorLayout.grid,
  crossAxisCount: 3,
  childAspectRatio: 1.5,
  mainAxisSpacing: 10.0,
  crossAxisSpacing: 10.0,
  // Other properties...
)
```

## Customization options

The GenericSelector provides several properties for customization:

| Property            | Description                                      |
|---------------------|--------------------------------------------------|
| `layout`            | The layout type: column, row, wrap, or grid      |
| `isMultiSelectMode` | Whether multiple selections are allowed          |
| `initialSelection`  | List of initially selected items                 |
| `spacing`           | Spacing between items in row/column layouts      |
| `wrapAlignment`     | Alignment of items within a run in wrap layout   |
| `wrapRunAlignment`  | Alignment of runs in wrap layout                 |
| `wrapSpacing`       | Spacing between items in wrap layout             |
| `wrapRunSpacing`    | Spacing between runs in wrap layout              |
| `crossAxisCount`    | Number of items on the cross axis in grid layout |
| `mainAxisSpacing`   | Spacing between rows in grid layout              |
| `crossAxisSpacing`  | Spacing between columns in grid layout           |
| `childAspectRatio`  | Aspect ratio of grid items                       |
| `mainAxisExtent`    | Fixed height for items in grid layout            |


## Additional information

This package is designed to be highly reusable across different Flutter applications that need selection UI components. The architecture allows for creating custom selectable widgets to match your app's design language.

### Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### License

This package is released under the BSD 3-Clause License
