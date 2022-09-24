import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

class Counter with ChangeNotifier {
  int value = 1;

  void increment() {
    value += 1;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Counter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: const MyHomePage(title: 'Multi Counter Demo using Provider'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  final int nCounter = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Number of counters:',
              ),
              Consumer<Counter>(
                builder: (context, counter, child) => Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<Counter>(
                builder: (context, counter, child) => Expanded(
                  child: ListView(
                    children: List.generate(
                        counter.value, // nCounter,
                        (i) => ListTileItem(
                              title: "Counter #${i + 1}",
                            )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var counter = context.read<Counter>();
          counter.increment();
        },
        tooltip: 'Add Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListTileItem extends StatefulWidget {
  final String title;
  const ListTileItem({super.key, required this.title});
  @override
  // ignore: library_private_types_in_public_api
  _ListTileItemState createState() => _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
          tileColor: Colors.orange[500], // Colors.orange,
          textColor: Colors.white,
          title: Text(widget.title),
          trailing: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => setState(() => _itemCount--),
                  child: _itemCount > 0
                      ? const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 16,
                        )
                      : const Icon(
                          // draw icon in same colour as background to hide it
                          Icons.remove,
                          color: Colors.grey,
                          size: 16,
                        ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white),
                  child: Text(
                    _itemCount.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                InkWell(
                    onTap: () => setState(() => _itemCount++),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
