import 'package:app/src/locale/app_translations.dart';
import 'package:app/src/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class InputFieldWidget extends StatefulWidget {
  final ValueChanged onSaved;
  final String label;
  final String hintText;
  final String errorText;
  final TextInputType keyboardType;
  final bool isRequiredField;
  final Widget suffix;
  final bool obscureText;
  final Color color;

  InputFieldWidget({
    Key key,
    @required this.onSaved,
    this.label,
    this.errorText,
    this.obscureText,
    this.keyboardType,
    this.hintText,
    this.suffix,
    this.color,
    this.isRequiredField,
  }) : super(key: key);
  @override
  _InputFieldWidgetState createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  Widget _buildInputField() {
    return CustomCard(
      color: widget.color != null ? widget.color : null,
      child: TextFormField(
        obscureText: widget.obscureText ?? false,
        keyboardType: widget.keyboardType,
        validator: MultiValidator([
          RequiredValidator(errorText: widget.errorText),
          MinLengthValidator(3,
              errorText: AppTranslations.of(context)
                  .text('field_min_length_validation_error')),
          MaxLengthValidator(11,
              errorText: AppTranslations.of(context)
                  .text('field_max_length_validation_error'))
        ]),
        onSaved: widget.onSaved,
        style: Theme.of(context).textTheme.caption,
        decoration: InputDecoration(
            labelText: widget.label ?? '',
            hintText: widget.hintText ?? '',
            suffixIcon: widget.suffix),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildInputField();
  }
}
