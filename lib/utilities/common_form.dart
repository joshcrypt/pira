import "package:flutter/material.dart";
import "package:pira/models/petrol_expense_item.dart";
import "package:pira/services/pira/pira_service.dart";

// Create common form
class CommonForm extends StatefulWidget {
  final String buttonTitle;
  final PetrolExpenseItem? expenseItem;

  // Constructor for adding button name
  const CommonForm({
    super.key,
    required this.buttonTitle,
    this.expenseItem,
  });

  @override
  State<StatefulWidget> createState() => _CommonFormState();
}

// State class for Common Form
class _CommonFormState extends State<CommonForm> {
  // Controllers

  final _formKey = GlobalKey<FormState>();
  final _pplController = TextEditingController();
  final _capacityController = TextEditingController();
  final _dateController = TextEditingController();
  final _mileageController = TextEditingController();
  final _additionalInformationController = TextEditingController();
  final _amountController = TextEditingController();

  // Firestore instance
  final PiraService _piraService = PiraService();

  @override
  void initState() {
    super.initState();
    _dateController.text =
        widget.expenseItem?.createdAt.toString() ?? DateTime.now().toString();
    _mileageController.text = widget.expenseItem?.mileage.toString() ?? '';
    _pplController.text = widget.expenseItem?.pricePerLitre.toString() ?? '';
    _additionalInformationController.text =
        widget.expenseItem?.additionalInfo.toString() ?? '';
    _amountController.text = widget.expenseItem?.amount.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //   Price Per Litre Field
          TextFormField(
            controller: _pplController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Price Per Litre cannot be empty";
              }
              return null;
            },
            decoration: _decorationFormTheme(
                "PRICE/LITRE", Icons.local_gas_station_outlined),
          ),
          const SizedBox(
            height: 10,
          ),
          //   Capacity Field
          // TextFormField(
          //   controller: _capacityController,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return "Capacity cannot be empty";
          //     }
          //     return null;
          //   },
          //   decoration: _decorationFormTheme("LITRES", Icons.water_drop),
          // ),
          TextFormField(
            controller: _amountController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Amount cannot be empty";
              }
              return null;
            },
            decoration: _decorationFormTheme(
                "AMOUNT", Icons.currency_exchange_outlined),
          ),
          const SizedBox(
            height: 10,
          ),
          //   Date Field
          TextFormField(
            onTap: () {
              _selectDate();
            },
            decoration: _decorationFormTheme(
              "DATE",
              Icons.calendar_today,
            ),
            controller: _dateController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter the Date";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          //   Mileage Field
          TextFormField(
            controller: _mileageController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Mileage cannot be empty";
              }
              return null;
            },
            decoration: _decorationFormTheme("MILEAGE", Icons.speed),
          ),
          const SizedBox(
            height: 10,
          ),
          // Additional Information
          TextFormField(
            controller: _additionalInformationController,
            decoration: _decorationFormTheme(
                "Additional Information", Icons.info_outline),
          ),
          const SizedBox(
            height: 10,
          ),
          //   Submit button
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                final petrolExpenseItem = PetrolExpenseItem(
                  id: widget.expenseItem?.id,
                  pricePerLitre: double.parse(_pplController.text),
                  capacity: double.parse((double.parse(_amountController.text) /
                          double.parse(_pplController.text))
                      .toStringAsFixed(2)),
                  // amount: (double.parse(_pplController.text) *
                  //     double.parse(_capacityController.text)),
                  amount: double.parse(_amountController.text),
                  createdAt: DateTime.parse(_dateController.text),
                  mileage: int.parse(_mileageController.text),
                  additionalInfo: _additionalInformationController.text,
                );
                showDialog(
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                // Add new consumption
                (bool, String) result;
                if (petrolExpenseItem.id == null) {
                  result = await _piraService.createUserConsumptionDocument(
                      petrolExpenseItem, context);
                } else {
                  result = await _piraService.updateUserConsumptionDocument(
                      petrolExpenseItem, context);
                }

                if (context.mounted) {
                  if (result.$1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result.$2),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(result.$2),
                      ),
                    );
                  }
                }

                _pplController.clear();
                _capacityController.clear();
                _pplController.clear();
                _dateController.clear();
                _mileageController.clear();
                _additionalInformationController.clear();

                if (context.mounted) {
                  Navigator.pop(context);
                  Navigator.of(context).pop();
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xff7c94b6)
                  // color: const Color(0x79757E),
                  ),
              height: 60,
              child: Center(child: Text(widget.buttonTitle)),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration _decorationFormTheme(String label, IconData icon) {
    return InputDecoration(
      // filled: true,
      // enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      // border: const OutlineInputBorder(),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      labelText: label,
      suffixIcon: Icon(icon),
      suffixIconColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return Colors.blue;
        }
        if (states.contains(MaterialState.focused)) {
          return Colors.red;
        }
        return Colors.grey;
      }),
    );
  }

  Future<void> _selectDate() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (datePicked != null) {
      setState(() {
        _dateController.text = datePicked.toString().split(" ")[0];
      });
    }
  }
}
