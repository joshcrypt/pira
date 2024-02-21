import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:intl/intl.dart";
import "package:pira/models/petrol_expense_item.dart";
import "package:provider/provider.dart";

import "../../services/pira/pira_service.dart";
import "../../utilities/common_form.dart";

class ViewPage extends StatelessWidget {
  ViewPage({super.key, this.onPressed});

  final void Function(BuildContext)? onPressed;
  final PiraService _piraService = PiraService();

  @override
  Widget build(BuildContext context) {
    // Provider
    List<PetrolExpenseItem> petrolExpenseItems =
        Provider.of<List<PetrolExpenseItem>>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("View"),
        ),
        body: MediaQuery.of(context).size.width <= 768
            ? _buildLMobileList(context, petrolExpenseItems)
            : _buildConsumptionTable(context, petrolExpenseItems));
  }

  Widget _buildConsumptionTable(
      BuildContext context, List<PetrolExpenseItem> petrolExpenseItems) {
    var consumptionDataSource = PaginatedConsumptionTable(petrolExpenseItems);
    return SingleChildScrollView(
      child: PaginatedDataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                "Date",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                "Mileage",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                "Price",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                "Capacity",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                "Amount",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                "Additional Info",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
        source: consumptionDataSource,
      ),
    );
  }

  Widget _buildLMobileList(
      BuildContext context, List<PetrolExpenseItem> petrolExpenseItems) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Center(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                PetrolExpenseItem item = petrolExpenseItems[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        label: "Delete",
                        icon: Icons.delete_forever_outlined,
                        onPressed: (context) {
                          _piraService.removeUserConsumptionDocument(
                              item, context);
                        },
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Update Expense"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: CommonForm(
                                    expenseItem: item, buttonTitle: 'Update'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? const Color(0xFFFEFEFE)
                            : const Color(0xFFE9E9E9),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateFormat.yMMMEd().format(item.createdAt)),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.speed_outlined,
                                    size: 14,
                                    color: Colors.cyan,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text("${item.mileage}"),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${item.capacity} Litres @  ${formatCurrency(item.pricePerLitre)}',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(
                                formatCurrency(item.amount),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.w900),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                    height: 10,
                  ),
              itemCount: petrolExpenseItems.length)),
    );
  }

  static String formatCurrency(
    double value, {
    String locale = 'en_KE',
    String symbol = 'KES',
    int decimalDigits = 2,
  }) {
    final numberFormat = NumberFormat.currency(
      locale: locale,
      symbol: '$symbol ',
      decimalDigits: decimalDigits,
    );
    return numberFormat.format(value);
  }
}

class PaginatedConsumptionTable extends DataTableSource {
  final List<PetrolExpenseItem> petrolExpenseItems;

  PaginatedConsumptionTable(this.petrolExpenseItems);

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(cells: [
      DataCell(Text(petrolExpenseItems[index].createdAt.toString())),
      DataCell(Text(petrolExpenseItems[index].mileage.toString())),
      DataCell(Text(petrolExpenseItems[index].pricePerLitre.toString())),
      DataCell(Text(petrolExpenseItems[index].capacity.toString())),
      DataCell(Text(petrolExpenseItems[index].amount.toString())),
      DataCell(Text(petrolExpenseItems[index].additionalInfo.toString())),
    ], index: index);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => petrolExpenseItems.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
