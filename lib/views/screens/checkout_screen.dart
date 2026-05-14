import 'package:assignment_1/views/widgets/Text_field_widget.dart';
import 'package:assignment_1/views/widgets/payment_widget.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final double totalPrice;

  const CheckoutScreen({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Checkout"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SHIPPING ADDRESS
                _sectionTitle("Shipping Address"),

                const SizedBox(height: 12),
                TextFieldWidget(hint: "Full Name", icon: Icons.person_outline),
                const SizedBox(height: 14),
                TextFieldWidget(
                  hint: "Phone Number",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 14),
                TextFieldWidget(
                  hint: "Address",
                  icon: Icons.location_on_outlined,
                  maxLines: 3,
                ),
                const SizedBox(height: 28),
                // PAYMENT METHOD
                _sectionTitle("Payment Method"),

                const SizedBox(height: 14),

                PaymentWidget(
                  icon: Icons.credit_card,
                  title: "Credit / Debit Card",
                ),
                const SizedBox(height: 12),
                PaymentWidget(
                  icon: Icons.account_balance_wallet_outlined,
                  title: "ABA Pay",
                ),
                const SizedBox(height: 12),
                PaymentWidget(
                  icon: Icons.qr_code_scanner,
                  title: "KHQR Payment",
                ),
                const SizedBox(height: 28),
                // ORDER SUMMARY
                _sectionTitle("Order Summary"),

                const SizedBox(height: 14),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _summaryRow(
                        context,
                        "Subtotal",
                        "\$${totalPrice.toStringAsFixed(2)}",
                      ),

                      const SizedBox(height: 12),

                      _summaryRow(context, "Shipping", "\$5.00"),

                      const Divider(height: 30),

                      _summaryRow(
                        context,
                        "Total",
                        "\$${(totalPrice + 5).toStringAsFixed(2)}",
                        isTotal: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // PLACE ORDER BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Text("Order Successful 🎉"),
                            content: const Text(
                              "Your order has been placed successfully.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).secondaryHeaderColor,
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

  // SECTION TITLE
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  // SUMMARY ROW
  Widget _summaryRow(
    BuildContext context,
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 22 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
