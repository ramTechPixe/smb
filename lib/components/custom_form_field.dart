import 'package:political/untils/export_file.dart';

class CustomFormField extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  dynamic validator;
  dynamic contentPadding;
  bool obscureText;
  bool readOnly;
  dynamic value;
  dynamic focusNode;
  int maxLines;
  dynamic onChanged;
  Widget? prefix;
  dynamic keyboardType;

  TextStyle? hintStyle;
  double? fontSize;
  FontWeight? fontWeight;

  final textColor;

  //keyboardType: TextInputType.datetime,

  Widget? suffix;
  CustomFormField(
      {Key? key,
      this.keyboardType,
      this.prefix,
      this.focusNode,
      required this.maxLines,
      required this.obscureText,
      this.suffix,
      this.hintStyle,
      this.value,
      this.onChanged,
      this.contentPadding,
      this.validator,
      required this.readOnly,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.controller,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Ktextcolor.withOpacity(0.5),
            blurRadius: 5.r,
            offset: Offset(1, 1),
            spreadRadius: 1.r,
          )
        ],
        color: Kwhite,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          maxLines: maxLines,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: GoogleFonts.roboto(
              fontSize: 14.sp, fontWeight: kFW500, color: kblack),
          decoration: InputDecoration(
            focusColor: Kwhite,
            filled: true,

            contentPadding: contentPadding,
            // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kblack.withOpacity(0.6), width: 1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kblack.withOpacity(0.6), width: 1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kblack.withOpacity(0.6), width: 1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: KOrange.withOpacity(0.6), width: 1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: KOrange.withOpacity(0.6), width: 1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            fillColor: Kwhite,
            suffixIcon: suffix,
            prefixIcon: prefix,
            hintText: hintText,
            alignLabelWithHint: true,
            //make hint text
            hintStyle: hintStyle ??
                GoogleFonts.roboto(
                  color: KdarkText.withOpacity(0.5),
                  fontSize: 14.sp,
                  fontWeight: kFW500,
                ),

            //create lable
          ),
          validator: validator,
          onChanged: onChanged),
    );
  }
}

class CustomFormFieldOutilined extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  dynamic validator;
  dynamic contentPadding;
  bool obscureText;
  bool readOnly;
  dynamic value;
  dynamic focusNode;
  int maxLines;
  dynamic onChanged;
  Widget? prefix;
  dynamic keyboardType;
  String label;

  TextStyle? hintStyle;
  double? fontSize;
  FontWeight? fontWeight;
  bool? enable;

  final textColor;

  Widget? suffix;
  CustomFormFieldOutilined(
      {Key? key,
      this.keyboardType,
      this.prefix,
      this.focusNode,
      required this.maxLines,
      required this.obscureText,
      required this.label,
      this.suffix,
      this.enable,
      this.hintStyle,
      this.value,
      this.onChanged,
      this.contentPadding,
      this.validator,
      required this.readOnly,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.controller,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Ktextcolor.withOpacity(0.5),
            blurRadius: 5.r,
            offset: Offset(1, 1),
            spreadRadius: 1.r,
          )
        ],
        color: Kwhite,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextFormField(
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enable,
          cursorColor: KOrange,
          controller: controller,
          maxLines: maxLines,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: GoogleFonts.roboto(
              fontSize: 13.sp,
              fontWeight: kFW500,
              color: kblack.withOpacity(0.8)),
          decoration: InputDecoration(
            focusColor: Kwhite.withOpacity(0.5),
            filled: true,
            labelText: label,
            labelStyle: GoogleFonts.roboto(
                fontSize: 12.sp,
                fontWeight: kFW600,
                color: kblack.withOpacity(0.6),
                letterSpacing: 1),
            contentPadding: contentPadding,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kblack, width: 1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: kblack.withOpacity(0.6), width: 0.5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: kblack.withOpacity(0.6), width: 0.5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: KOrange, width: 1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: KOrange, width: 1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            fillColor: Kwhite,
            suffixIcon: suffix,
            prefixIcon: prefix,
            hintText: hintText,
            alignLabelWithHint: true,
            hintStyle: hintStyle ??
                GoogleFonts.roboto(
                  color: KTextgery.withOpacity(0.5),
                  fontSize: 12.sp,
                  fontWeight: kFW500,
                ),
          ),
          validator: validator,
          onChanged: onChanged),
    );
  }
}

//3rd
class CustomFormFields extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  dynamic validator;
  dynamic ontap;
  dynamic contentPadding;
  bool obscureText;
  bool readOnly;
  bool enabled;
  dynamic value;
  dynamic focusNode;
  int maxLines;
  dynamic onChanged;
  Widget? prefix;
  dynamic keyboardType;
  dynamic inputFormatters;
  dynamic maxLength;
  String label;
  TextStyle? hintStyle;
  TextStyle? textStyle;
  double? fontSize;
  FontWeight? fontWeight;

  final textColor;
  final labelColor;
  final hintColor;
  //keyboardType: TextInputType.datetime,

  Widget? suffix;
  CustomFormFields(
      {Key? key,
      this.keyboardType,
      this.prefix,
      this.focusNode,
      required this.enabled,
      required this.maxLines,
      required this.obscureText,
      this.inputFormatters,
      this.suffix,
      this.textStyle,
      this.hintStyle,
      this.maxLength,
      this.value,
      this.onChanged,
      this.contentPadding,
      this.validator,
      this.ontap,
      required this.readOnly,
      this.textColor,
      this.labelColor,
      this.hintColor,
      this.fontSize,
      this.fontWeight,
      required this.label,
      this.controller,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /////////////
        ///#D2D6DE
        /////////////
        Text(
          label,
          textAlign: TextAlign.start,
          style: GoogleFonts.robotoCondensed(
              fontSize: kSixteenFont,
              //  letterSpacing: 1,
              color: labelColor,
              fontWeight: kFW400),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Kwhite,
          ),
          child: TextFormField(
            cursorColor: Kform_border_twg,
            maxLength: maxLength,
            obscureText: obscureText,
            readOnly: readOnly,
            controller: controller,
            maxLines: maxLines,
            enabled: enabled,
            focusNode: focusNode,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: textStyle ??
                GoogleFonts.robotoCondensed(
                    fontSize: 14.sp, fontWeight: kFW500, color: kblack),
            decoration: InputDecoration(
              focusColor: Kwhite,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: contentPadding,
              // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: KText_border_twg, width: 0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: KRed_twg, width: 0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: KText_border_twg, width: 0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: KPartyThemeOne, width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: KPartyThemeOne, width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              fillColor: Kwhite,
              suffixIcon: suffix,
              prefixIcon: prefix,
              hintText: hintText,
              alignLabelWithHint: true,
              //make hint text
              hintStyle: GoogleFonts.robotoCondensed(
                color: KLighText_twg,
                fontSize: 14.sp,
                fontWeight: kFW400,
              ),
              //////////////////

              ////////////

              //create lable
            ),
            validator: validator,
            onChanged: onChanged,
            onTap: ontap,
          ),
        ),
      ],
    );
  }
}
