import 'package:flutter/material.dart';

import '../generic_selector.dart';


class SelectableChip extends StatefulWidget implements SelectableWidget {
  const SelectableChip({
    super.key,
    required this.label,
    required this.onSelected,
    required this.isSelected,
    this.onDeleted,
    this.selectedColor,
    this.selectedBackgroundColor,
    this.icon
  });



  final VoidCallback? onDeleted;
  final IconData? icon;
  final String label;
  final Color? selectedColor;
  final Color? selectedBackgroundColor;

  // Required for the selector to work
  @override
  final bool isSelected;
  @override
  final VoidCallback onSelected;

  @override
  State<SelectableChip> createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ChoiceChip(
      padding: EdgeInsets.only(
        top: 12,
        bottom: 12,
        left: (widget.icon != null)
            ? 8
            : 12,
        right: 12,
      ),
      backgroundColor: widget.isSelected
          ? theme.colorScheme.primary
          : theme.colorScheme.surfaceContainerLow,
      selectedColor: theme.colorScheme.primary,
      showCheckmark:
          (widget.icon != null) ? false : true,
      checkmarkColor: widget.isSelected
          ? theme.scaffoldBackgroundColor
          : theme.iconTheme.color,
      selected: widget.isSelected,
      onSelected: (val) {
        widget.onSelected.call();
      },
      label: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: widget.icon != null,
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: widget.isSelected
                      ? theme.scaffoldBackgroundColor
                      : null,
                ),
                const SizedBox(width: 16)
              ],
            ),
          ),
          Text(
            widget.label,
            style: theme.textTheme.bodyMedium!.copyWith(
                color: widget.isSelected
                    ? theme.scaffoldBackgroundColor
                    : theme.textTheme.bodyMedium?.color),
          ),
        ],
      ),
    );
  }
}
