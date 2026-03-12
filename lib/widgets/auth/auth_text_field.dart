import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;
  double _strength = 0.0;
  Color _strengthColor = Colors.transparent;
  String _strengthLabel = '';

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _calculateStrength(String value) {
    if (!widget.isPassword || widget.label.toLowerCase().contains('confirm')) {
      return;
    }

    double strength = 0;
    if (value.isEmpty) {
      strength = 0;
    } else {
      if (value.length >= 6) strength += 0.25;
      if (value.length >= 10) strength += 0.25;
      if (RegExp(r'[A-Z]').hasMatch(value)) strength += 0.25;
      if (RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]').hasMatch(value)) strength += 0.25;
    }

    setState(() {
      _strength = strength;
      if (strength <= 0.25) {
        _strengthColor = Colors.red;
        _strengthLabel = 'Weak';
      } else if (strength <= 0.5) {
        _strengthColor = Colors.orange;
        _strengthLabel = 'Fair';
      } else if (strength <= 0.75) {
        _strengthColor = Colors.blue;
        _strengthLabel = 'Good';
      } else {
        _strengthColor = Colors.green;
        _strengthLabel = 'Strong';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            if (widget.isPassword &&
                !widget.label.toLowerCase().contains('confirm') &&
                widget.controller != null &&
                widget.controller!.text.isNotEmpty)
              Text(
                _strengthLabel,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _strengthColor,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: _calculateStrength,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: Icon(widget.prefixIcon, color: Colors.green.shade600),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.green.shade600, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
        if (widget.isPassword &&
            !widget.label.toLowerCase().contains('confirm') &&
            widget.controller != null &&
            widget.controller!.text.isNotEmpty) ...[
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _strength,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(_strengthColor),
              minHeight: 4,
            ),
          ),
        ],
      ],
    );
  }
}
