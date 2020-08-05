import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/analog_clock_view.dart';
import 'view_models/stopwatch_viewmodel.dart';
import 'extensions/duration_extension.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => StopWatchViewModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StopwatchPage());
  }
}

class StopwatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnalogClock(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Consumer<StopWatchViewModel>(
                    builder: (context, viewmodel, child) {
                  if (viewmodel.isRunning) {
                    return Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Provider.of<StopWatchViewModel>(context,
                                    listen: false)
                                .lap();
                          },
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.grey)),
                          padding: EdgeInsets.all(25),
                          child: Text('Lap',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        FlatButton(
                          onPressed: () {
                            Provider.of<StopWatchViewModel>(context,
                                    listen: false)
                                .pause();
                          },
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.redAccent)),
                          padding: EdgeInsets.all(25),
                          child: Text(
                            'Stop',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.redAccent,
                        )
                      ],
                    );
                  } else {
                    return Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Provider.of<StopWatchViewModel>(context,
                                    listen: false)
                                .reset();
                          },
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.grey)),
                          padding: EdgeInsets.all(25),
                          child: Text('Reset',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        FlatButton(
                          onPressed: () {
                            Provider.of<StopWatchViewModel>(context,
                                    listen: false)
                                .start();
                          },
                          shape: CircleBorder(
                              side: BorderSide(
                                  color: Color.fromRGBO(28, 150, 30, 1))),
                          padding: EdgeInsets.all(25),
                          child: Text(
                            'Start',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.greenAccent,
                        )
                      ],
                    );
                  }
                })),
            Consumer<StopWatchViewModel>(
              builder: (context, viewmodel, child) {
                return Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: false,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemCount: viewmodel.laps().length,
                        itemBuilder: (context, idx) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
                            child: Row(children: <Widget>[
                              Text(
                                'Lap $idx',
                                style: TextStyle(fontSize: 18, fontFeatures: [
                                  FontFeature.tabularFigures()
                                ]),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Text(
                                ClokcDuratiion(viewmodel.laps()[idx])
                                    .digitalClockString(),
                                style: TextStyle(fontSize: 18, fontFeatures: [
                                  FontFeature.tabularFigures()
                                ]),
                              )
                            ]),
                          );
                        }),
                  ),
                );
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
