import 'package:dino_runner/screens/game.screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showSettings = false;
  bool _sfxEnabled;
  bool _bgmEnabled;

  SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();

    getPreferences();
  }

  getPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _sfxEnabled = _prefs.getBool('SFX') ?? true;
    _bgmEnabled = _prefs.getBool('BGM') ?? true;

    if (mounted) {
      setState(() {});
    }
  }

  setPreference(String key, bool value) {
    _prefs?.setBool(key, value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(16)),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: _showSettings
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          Text(
                            'Settings',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(children: [
                              Row(mainAxisSize: MainAxisSize.min, children: [
                                Text('BGM',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(width: 56),
                                Switch(
                                  activeColor: Colors.white,
                                  inactiveThumbColor: Colors.grey,
                                  value: _bgmEnabled,
                                  onChanged: (val) {
                                    _bgmEnabled = val;
                                    setPreference('BGM', val);
                                  },
                                )
                              ]),
                              Row(mainAxisSize: MainAxisSize.min, children: [
                                Text('SFX',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(width: 56),
                                Switch(
                                  activeColor: Colors.white,
                                  inactiveThumbColor: Colors.grey,
                                  value: _sfxEnabled,
                                  onChanged: (val) {
                                    _sfxEnabled = val;
                                    setPreference('BGM', val);
                                  },
                                )
                              ])
                            ]),
                          ),
                          RaisedButton.icon(
                              icon: Icon(Icons.chevron_left),
                              label: Text('Back'),
                              onPressed: () => setState(() {
                                    _showSettings = false;
                                  }))
                        ])
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Dino Runner',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RaisedButton(
                              child: Icon(Icons.play_arrow),
                              onPressed: () => Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => GameScreen(),
                              )),
                            ),
                            SizedBox(width: 16),
                            RaisedButton(
                              child: Icon(Icons.settings),
                              onPressed: () => setState(() {
                                _showSettings = true;
                              }),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
