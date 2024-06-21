import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        visualDensity: VisualDensity.compact,
      ),
      home: Scaffold(
        body: AmbientMode(builder: (context, mode, _) {
          bool isAmbient = mode == WearMode.ambient;
          return Opacity(
            opacity: isAmbient ? 0.5 : 1,
            child: const MainScreen(),
          );
        }),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          scrollDirection: Axis.vertical,
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text('July, 2024',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: 40,
                      itemBuilder: (context, index) {
                        // final isToday = DateTime.now().day ==
                        //     DateTime.parse(dayData.date).day;

                        if (index < 7) {
                          return Container(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              DaysOfWeek[index].substring(0, 1),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          // final isPast = DateTime.now()
                          //     .isAfter(DateTime.parse(dayData.date));
                          // final present = (totaldays[index] as Day).present;

                          // final isToday =
                          //     DateTime.now() == DateTime.parse(dayData.date);
                          return GestureDetector(
                              onTap: () {},
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: index == 22
                                          ? Colors.red
                                          : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  )));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '21',
                  style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('SUN', style: TextStyle(fontSize: 20, color: Colors.red))
              ],
            )),
            Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (context) {
                        return Container(
                          height: 300,
                          // color: Colors.grey[800],
                          child: Center(
                            child: Text("Add Reminder",
                                style: TextStyle(color: Colors.white)),
                          ),
                        );
                      });
                },
                mini: true,
                child: const Icon(Icons.add),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Reminders", style: TextStyle(fontSize: 14)),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[800],
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text('${index + 1}. ',
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                                Text("Working in progess...",
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          );
                        },
                        itemCount: 3),
                  ),
                ],
              ),
            )
          ],
        ),
        // PageIndicator(
        //   tabController: _tabController,
        //   currentPageIndex: _currentPageIndex,
        //   onUpdateCurrentPageIndex: _updateCurrentPageIndex,
        //   isOnDesktopAndWeb: _isOnDesktopAndWeb,
        // ),
      ],
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }
}

// ignore: non_constant_identifier_names
final DaysOfWeek = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

final MonthsList = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
