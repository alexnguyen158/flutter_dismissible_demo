import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Dismissible Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  final List<String> _items = new List<String>.generate(10, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            var item = _items[index];
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  dynamic deleteItem = _items.removeAt(index);
                  _key.currentState
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text("Delete \"${deleteItem}\""),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          setState(() {
                            _items.insert(index, deleteItem);
                          });
                        },
                      ),
                    ));
                });
              },
              background: Container(
                padding: EdgeInsets.only(right: 20.0),
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              child: ListTile(
                title: Text('$item'),
              ),
            );
          }),
    );
  }
}
