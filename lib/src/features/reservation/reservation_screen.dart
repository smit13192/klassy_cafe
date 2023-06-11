import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/config/color/app_color.dart';
import 'package:klassy_cafe/src/config/string/app_strings.dart';
import 'package:klassy_cafe/src/features/auth/widget/text_field_border.dart';
import 'package:klassy_cafe/src/features/home/service/firebase_service.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final dateController = TextEditingController();
  final noOfSeatController = TextEditingController();

  DateTime? date;
  TimeOfDay? time;

  @override
  void dispose() {
    nameController.dispose();
    phoneNoController.dispose();
    dateController.dispose();
    noOfSeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  AppStrings.reservationTitle,
                  style: TextStyle(
                    color: Colors.black87,
                    letterSpacing: 2,
                    fontSize: 40,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty || value.contains(' ')) {
                        return AppStrings.nameError;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                        ),
                        onPressed: () {
                          nameController.clear();
                        },
                      ),
                      hintText: AppStrings.nameHint,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      focusedErrorBorder: focusedErrorBorder,
                      filled: true,
                      fillColor: AppColors.kFAFAFA,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneNoController,
                    validator: (value) {
                      if (value!.isEmpty || value.contains(' ')) {
                        return AppStrings.phoneNoError;
                      } else if (value.length < 10) {
                        return AppStrings.phoneNoLengthError;
                      } else {
                        return null;
                      }
                    },
                    maxLength: 10,
                    decoration: InputDecoration(
                      hintText: AppStrings.phoneNoHint,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      focusedErrorBorder: focusedErrorBorder,
                      filled: true,
                      fillColor: AppColors.kFAFAFA,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: TextFormField(
                    onTap: dateSelect,
                    keyboardType: TextInputType.datetime,
                    controller: dateController,
                    validator: (value) {
                      if (value!.isEmpty || value.contains(' ')) {
                        return AppStrings.dateError;
                      } else {
                        return null;
                      }
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: AppStrings.dateHint,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      focusedErrorBorder: focusedErrorBorder,
                      filled: true,
                      fillColor: AppColors.kFAFAFA,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: noOfSeatController,
                    validator: (value) {
                      if (value!.isEmpty || value.contains(' ')) {
                        return AppStrings.noOfSeatError;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: AppStrings.noOfSeatHint,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      errorBorder: errorBorder,
                      focusedErrorBorder: focusedErrorBorder,
                      filled: true,
                      fillColor: AppColors.kFAFAFA,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        reservation();
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          AppStrings.confirmReservation,
                          style: TextStyle(
                            color: AppColors.kFAFAFA,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  reservation() async {
    FirebaseService.instance().reservation(
      name: nameController.text,
      phoneNo: phoneNoController.text,
      date: date!,
      noOfSeat: int.parse(noOfSeatController.text),
    );
    Navigator.pop(context);
  }

  void dateSelect() async {
    date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 5)),
    );
    if (date != null) {
      timeSelect();
    }
  }

  timeSelect() async {
    time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      date = DateTime(
        date!.year,
        date!.month,
        date!.day,
        time!.hour,
        time!.minute,
      );
      dateController.text = '${date!.day}-${date!.month}-${date!.year}';
    }
  }
}
