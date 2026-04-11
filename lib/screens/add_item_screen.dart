import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/item_model.dart';
import '../services/firebase_service.dart';
import '../services/storage_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  File? _image;
  bool _loading = false;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (picked == null) return;

    // Verifica o tamanho do arquivo
    final file = File(picked.path);
    final sizeInBytes = await file.length();
    final sizeInMB = sizeInBytes / (1024 * 1024);

    if (sizeInMB > 5) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Imagem muito grande. Escolha uma foto menor que 5MB.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    setState(() => _image = file);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    String? imageUrl;
    if (_image != null) {
      imageUrl = await StorageService().uploadImage(_image!);
    }

    // Pega número limpo e já adiciona o DDI 55
    final cleanPhone = '55${_maskFormatter.getUnmaskedText()}';

    final item = ItemModel(
      id: '',
      name: _nameCtrl.text.trim(),
      phone: cleanPhone, // salva com DDI direto
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
    );

    await FirebaseService().addItem(item);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Item'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Aviso de responsabilidade
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  border: Border.all(color: Colors.amber),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '⚠️ O conteúdo publicado é de responsabilidade do usuário.',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(height: 24),

              // Foto
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Adicionar foto (opcional)', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Nome
              TextFormField(
                controller: _nameCtrl,
                maxLength: 200,
                decoration: const InputDecoration(
                  labelText: 'Nome do item *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe o nome do item' : null,
              ),
              const SizedBox(height: 16),

              // WhatsApp
              TextFormField(
                controller: _phoneCtrl,
                inputFormatters: [_maskFormatter],
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'WhatsApp (com DDD) *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: '(51) 98888-7777',
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Informe o WhatsApp';

                  final digits = _maskFormatter.getUnmaskedText();

                  if (digits.length != 11) {
                    return 'Informe o número completo com o 9. Ex: (51) 98888-7777';
                  }

                  if (digits[2] != '9') {
                    return 'O celular deve começar com 9 após o DDD';
                  }

                  const dddsValidos = [
                    11, 12, 13, 14, 15, 16, 17, 18, 19,
                    21, 22, 24, 27, 28,
                    31, 32, 33, 34, 35, 37, 38,
                    41, 42, 43, 44, 45, 46, 47, 48, 49,
                    51, 53, 54, 55,
                    61, 62, 63, 64, 65, 66, 67, 68, 69,
                    71, 73, 74, 75, 77, 79,
                    81, 82, 83, 84, 85, 86, 87, 88, 89,
                    91, 92, 93, 94, 95, 96, 97, 98, 99,
                  ];

                  final ddd = int.tryParse(digits.substring(0, 2));
                  if (ddd == null || !dddsValidos.contains(ddd)) {
                    return 'DDD inválido';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Botão
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _loading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Publicar doação', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}