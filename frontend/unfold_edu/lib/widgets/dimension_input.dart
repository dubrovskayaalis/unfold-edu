import 'package:flutter/material.dart';

class DimensionInput extends StatefulWidget {
  final List<(String name, double value)> dimensions;
  final void Function(List<(String name, double value)>) onChanged;

  const DimensionInput({
    super.key,
    required this.dimensions,
    required this.onChanged,
  });

  @override
  State<DimensionInput> createState() => _DimensionInputState();
}

class _DimensionInputState extends State<DimensionInput> {
  late List<(String name, double value)> _dims;

  @override
  void initState() {
    super.initState();
    _dims = List.of(widget.dimensions);
  }

  void _add() {
    setState(() {
      _dims.add(('new_dim', 0.0));
      widget.onChanged(_dims);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Dimensions'),
            const Spacer(),
            IconButton(onPressed: _add, icon: const Icon(Icons.add)),
          ],
        ),
        for (var i = 0; i < _dims.length; i++)
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  initialValue: _dims[i].$1,
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (v) {
                    setState(() {
                      _dims[i] = (v, _dims[i].$2);
                      widget.onChanged(_dims);
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  initialValue: _dims[i].$2.toString(),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    final parsed = double.tryParse(v) ?? _dims[i].$2;
                    setState(() {
                      _dims[i] = (_dims[i].$1, parsed);
                      widget.onChanged(_dims);
                    });
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }
}
