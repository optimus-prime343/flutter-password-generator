import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/generate_password.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _generatedPassword;
  double _length = 4;
  bool _includeNumbers = false;
  bool _includeLetters = false;
  bool _includeSymbols = false;

  CheckboxListTile _buildCheckboxListTile({
    required String title,
    required bool value,
    required void Function(bool? value) onChanged,
  }) {
    return CheckboxListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      tileColor: FlexColor.darkSurface.brighten(),
      value: value,
      onChanged: onChanged,
      title: Text(title),
    );
  }

  Text _buildLabelText({required String title}) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  void _handleGeneratePassword() {
    setState(() {
      _generatedPassword = generatePassword(
        length: _length.toInt(),
        includeNumbers: _includeNumbers,
        includeLetters: _includeLetters,
        includeSymbols: _includeSymbols,
      );
    });
  }

  void _showSnackBar({required String title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }

  void _handleCopyPassword() async {
    try {
      await Clipboard.setData(
        ClipboardData(
          text: _generatedPassword,
        ),
      );
      _showSnackBar(title: 'Copied password to clipboard');
    } catch (_) {
      _showSnackBar(title: 'Failed to copy password to clipboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Generate Password"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabelText(title: 'Generated Password'),
              const SizedBox(height: 16.0),
              Ink(
                decoration: BoxDecoration(
                  color: FlexColor.darkSurface.brighten(),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: _handleCopyPassword,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 24.0,
                    ),
                    child: Center(
                      child:
                          Text(_generatedPassword ?? "Press generate password"),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              _buildLabelText(title: 'Length : ${_length.toInt()}'),
              const SizedBox(height: 16.0),
              Slider(
                value: _length,
                onChanged: (newLength) {
                  setState(() {
                    _length = newLength;
                  });
                },
                min: 4.0,
                max: 32.0,
              ),
              const SizedBox(height: 16.0),
              _buildLabelText(title: 'Settings'),
              const SizedBox(height: 16.0),
              _buildCheckboxListTile(
                title: 'Include numbers',
                value: _includeNumbers,
                onChanged: (_) {
                  setState(() {
                    _includeNumbers = !_includeNumbers;
                  });
                },
              ),
              const SizedBox(height: 8.0),
              _buildCheckboxListTile(
                title: 'Include letters',
                value: _includeLetters,
                onChanged: (_) {
                  setState(() {
                    _includeLetters = !_includeLetters;
                  });
                },
              ),
              const SizedBox(height: 8.0),
              _buildCheckboxListTile(
                title: 'Include symbols',
                value: _includeSymbols,
                onChanged: (_) {
                  setState(() {
                    _includeSymbols = !_includeSymbols;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: _handleGeneratePassword,
                child: const Text("Generate Password"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
