// ignore_for_file: prefer_collection_literals

import 'package:amazon_clone_app/src/shared/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/providers/_export_providers.dart';

class ProductFormPage extends StatefulWidget {
  static String routeName = "/ProductFormPage";
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlController.removeListener(_updateImage);
  }

  void _updateImage() {
    setState(() {});
  }

  Future<void> _submitForm() async {
    final isValid = _formkey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formkey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProductProvider>(
        context,
        listen: false,
      ).saveProduct(_formData);
      Navigator.of(context).pop();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro'),
          actions: [
            TextButton(
              onPressed: (() => Navigator.of(context).pop()),
              child: const Text('Ok'),
            )
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as ProductModel;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save_rounded),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Nome:',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_priceFocus),
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        if (name.trim().length < 3) {
                          return 'Minimo de 3 letras';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Preço:',
                      ),
                      focusNode: _priceFocus,
                      textInputAction: TextInputAction.next,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_descriptionFocus),
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                      validator: (_price) {
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço validao';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Descrição:',
                      ),
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_imageUrlFocus),
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      validator: (_description) {
                        final description = _description ?? '';
                        if (description.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        if (description.trim().length < 10) {
                          return 'Minimo de 3 letras';
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _imageUrlController,
                            decoration: const InputDecoration(
                              labelText: 'url:',
                            ),
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            keyboardType: TextInputType.url,
                            onFieldSubmitted: (_) => _submitForm,
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = imageUrl ?? '',
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(top: 10, left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? const Icon(Icons.upload_rounded)
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
