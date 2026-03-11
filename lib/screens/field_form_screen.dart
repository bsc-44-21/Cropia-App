import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/field_model.dart';
import '../providers/field_provider.dart';

class FieldFormScreen extends StatefulWidget {
  final FieldModel? existingField;

  const FieldFormScreen({super.key, this.existingField});

  @override
  State<FieldFormScreen> createState() => _FieldFormScreenState();
}

class _FieldFormScreenState extends State<FieldFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _sizeController;
  
  String _selectedCropType = 'Maize';
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existingField?.name ?? '');
    _locationController = TextEditingController(text: widget.existingField?.location ?? '');
    _sizeController = TextEditingController(text: widget.existingField != null ? widget.existingField!.sizeInAcres.toString() : '');
    
    if (widget.existingField != null) {
      _selectedCropType = widget.existingField!.cropType;
      _selectedDate = widget.existingField!.plantingTime;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final field = FieldModel(
        id: widget.existingField?.id ?? const Uuid().v4(),
        name: _nameController.text.trim(),
        location: _locationController.text.trim(),
        sizeInAcres: double.parse(_sizeController.text.trim()),
        cropType: _selectedCropType,
        plantingTime: _selectedDate,
        activities: widget.existingField?.activities ?? [],
      );

      if (widget.existingField == null) {
        Provider.of<FieldProvider>(context, listen: false).addField(field);
      } else {
        Provider.of<FieldProvider>(context, listen: false).updateField(field);
      }
      
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingField != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Field' : 'Add New Field', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Field Name (e.g., North Plot)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.label_outline),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a name.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a location.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sizeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Size (Acres)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.square_foot),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter the size.';
                  if (double.tryParse(value) == null) return 'Please enter a valid number.';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedCropType,
                decoration: InputDecoration(
                  labelText: 'Crop Type',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.eco_outlined),
                ),
                items: ['Maize', 'Tomato'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCropType = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
                leading: const Icon(Icons.calendar_today),
                title: const Text('Planting Time'),
                subtitle: Text('${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}'),
                trailing: TextButton(
                  onPressed: _pickDate,
                  child: const Text('Change'),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(isEditing ? 'Save Changes' : 'Create Field', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
