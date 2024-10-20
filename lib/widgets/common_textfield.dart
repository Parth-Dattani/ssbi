
import 'package:flutter/material.dart';

import '../constant/constant.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final bool isObscure;
  final TextStyle? hintTextStyle;
  final double? borderRadius;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final bool? filled;
  final bool? isMaxLength;
  final bool? fillColors;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmit;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool? multiline;
  final int? maxlength;
  final Color? maxValueColor;

  const CommonTextField({
    Key? key,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.hintText,
    this.isObscure = false,
    this.validator,
    this.hintTextStyle,
    this.borderRadius,
    required this.controller,
    this.filled = true,
    this.isMaxLength = false,
    this.fillColors,
    this.onChanged,
    this.multiline = false,
    this.maxlength,
    this.maxValueColor,
    this.contentPadding,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.onFieldSubmit,
    this.readOnly = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      //cursorColor:AppConstants.errorColor,
      textDirection: TextDirection.ltr,
      maxLines: multiline == false ? 1 : 6,
      maxLength:
      isMaxLength  == true ?
      maxlength ?? TextField.noMaxLength : null,
      readOnly: readOnly!,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        hintText: hintText,
        hintStyle: hintTextStyle ,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding,
        filled: filled,
        fillColor: fillColors ==  true ? ColorsConfig.whiteColor : Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(
            color: ColorsConfig.blackColor,
            width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(
            color: ColorsConfig.blueButtonColor,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorsConfig.errorColor,
            width: 1.0,
          )
        ),
        errorStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize:12),
        counterStyle: TextStyle(
          color: maxValueColor ?? ColorsConfig.whiteColor,
        ),
      ),
      validator: validator,
      obscureText: isObscure,
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmit,
      keyboardType: keyboardType,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:glosaary_app/common/validator.dart';
//
// class CommonTextField extends StatefulWidget {
//   String? hintText;
//   IconData? prefixIcon;
//   IconData? suffixIcon;
//   //String? suffix;
//   Color? prefixIconColor;
//   Color? suffixIconColor;
//   Color? hintTextColor;
//   TextEditingController? controller;
//   FormFieldValidator<String>? validator;
//
//    CommonTextField({super.key,
//      this.hintText,
//      this.prefixIcon,
//      required this.controller,
//      //required this.suffix,
//      this.suffixIcon,
//      this.prefixIconColor,
//      this.suffixIconColor,
//      this.hintTextColor,
//      this.validator,
//   });
//
//   @override
//   State<CommonTextField> createState() => _CommonTextFieldState();
// }
//
// class _CommonTextFieldState extends State<CommonTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return  TextFormField(
//       cursorColor:const Color(0xff070534),
//       style: const TextStyle(  color:  Color(0xff070534),fontFamily: 'Avenir'),
//       //keyboardType: TextInputType.emailAddress,
//       decoration: InputDecoration(
//         disabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color:  Color(0xff070534),
//               width: 1,
//             ), borderRadius: BorderRadius.circular(15)
//           //borderRadius: BorderRadius.circular(50.0),
//         ),
//         errorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color:  Colors.redAccent,
//               width: 1,
//             ), borderRadius: BorderRadius.circular(15)
//           //borderRadius: BorderRadius.circular(50.0),
//         ),
//         enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color:  Color(0xff070534),
//               width: 1,
//             ), borderRadius: BorderRadius.circular(15)
//           //borderRadius: BorderRadius.circular(50.0),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color:  Colors.redAccent,
//               width: 1,
//             ), borderRadius: BorderRadius.circular(15)
//           //borderRadius: BorderRadius.circular(50.0),
//         ),
//         focusedBorder:  OutlineInputBorder(
//           borderSide: const BorderSide(
//             width: 2,   color:  Color(0xff070534),),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         //errorText: _validate?"Enter Username!":null,
//         prefixIcon: Icon(
//           widget.prefixIcon,
//           color:  widget.prefixIconColor,
//         ),
//
//         suffixIcon:  Icon(widget.suffixIcon!,color: widget.suffixIconColor),
//         hintStyle: const TextStyle(
//           color:  Color(0xff070534),
//         ),
//         hintText: widget.hintText,
//
//       ),
//       maxLines: 1,
//       controller: widget.controller,
//       validator: widget.validator,
//     );
//   }
// }
