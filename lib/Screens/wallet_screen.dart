import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double balance = 50.0; // Initial balance
  TextEditingController depositController = TextEditingController();
  TextEditingController withdrawController = TextEditingController();

  List<Map<String, dynamic>> transactionHistory = [];

  // Function to add money
  void addMoney() {
    double amount = double.tryParse(depositController.text) ?? 0;
    if (amount > 0) {
      setState(() {
        balance += amount;
        transactionHistory.insert(0, {
          'type': 'Deposited',
          'amount': amount,
          'time': DateTime.now(),
        });
      });
      depositController.clear();
    }
  }

  // Function to withdraw money
  void withdrawMoney() {
    double amount = double.tryParse(withdrawController.text) ?? 0;
    if (amount > 0 && amount <= balance) {
      setState(() {
        balance -= amount;
        transactionHistory.insert(0, {
          'type': 'Withdrawn',
          'amount': amount,
          'time': DateTime.now(),
        });
      });
      withdrawController.clear();
    }
  }

  // Generate date dividers for transaction history
  List<Widget> buildTransactionHistory() {
    Map<String, List<Map<String, dynamic>>> groupedTransactions = {};
    for (var transaction in transactionHistory) {
      String date = transaction['time'].toLocal().toString().split(' ')[0];
      if (!groupedTransactions.containsKey(date)) {
        groupedTransactions[date] = [];
      }
      groupedTransactions[date]!.add(transaction);
    }

    List<Widget> historyWidgets = [];
    groupedTransactions.forEach((date, transactions) {
      historyWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            date,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );

      for (var transaction in transactions) {
        historyWidgets.add(
          ListTile(
            leading: Icon(
              transaction['type'] == 'Withdrawn'
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
              color:
                  transaction['type'] == 'Withdrawn'
                      ? Colors.red
                      : Colors.green,
            ),
            title: Text(
              '${transaction['type']}: ₹${transaction['amount'].toStringAsFixed(2)}',
            ),
            subtitle: Text(
              '${transaction['time'].hour}:${transaction['time'].minute.toString().padLeft(2, '0')} ${transaction['time'].hour >= 12 ? 'PM' : 'AM'}',
            ),
          ),
        );
      }
    });
    return historyWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Balance
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Balance:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '₹${balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Deposit Money Section
              const Text(
                'Deposit Money',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: depositController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.add),
                        labelText: 'Enter Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: addMoney, child: const Text('Add')),
                ],
              ),
              const SizedBox(height: 20),

              // Withdraw Money Section
              const Text(
                'Withdraw Money',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: withdrawController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.remove),
                        labelText: 'Enter Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: withdrawMoney,
                    child: const Text('Withdraw'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Transaction History Section
              const Text(
                'Transaction History',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildTransactionHistory(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
