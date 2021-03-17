import 'package:flutter/material.dart';
import './models/checkIn.dart';
import './services/callRestApi.dart';

void main() => runApp(FilterFlutter());

class FilterFlutter extends StatefulWidget {
  @override
  _FilterFlutterState createState() => _FilterFlutterState();
}

class _FilterFlutterState extends State<FilterFlutter> {
  List<CheckIn> _users = [];
  List<CheckIn> _filterUser = [];

  void _fetchFromApis() {
    CallApis().fetchUsers().then((value) {
      // print(value);
      setState(() {
        _users = value;
        _filterUser = _users;
      });
      // print(_users);
    });
  }

  @override
  void initState() {
    // _users.length == null ? 0 : _users.length;
    super.initState();
    _fetchFromApis();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: GestureDetector(
      onTap: () {
        print("Gesture detect!!");
        FocusScope.of(context).requestFocus(FocusScopeNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Filters'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search User",
                  icon: Icon(
                    Icons.search_rounded,
                    // size: 50.0,
                  ),

                  // border: OutlineInputBorder(),
                ),
                onChanged: (string) {
                  setState(() {
                    _filterUser = _users
                        .where((u) => (u.username
                            .toLowerCase()
                            .contains(string.toLowerCase())))
                        .toList();
                  });
                },
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       _fetchFromApis();
            //     },
            //     child: Text(
            //       'refresh',
            //       style: TextStyle(fontSize: 16),
            //     )),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(20.0),
                    itemCount: _filterUser.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _filterUser[index].username,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                _filterUser[index].datetime.toString(),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                _filterUser[index].readerId,
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.refresh),
          onPressed: () {
            _fetchFromApis();
          },
        ),
      ),
    ));
  }
}
