import 'package:flutter/material.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPrisonerLogin = true;
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> availableLawyers = ['Lawyer 1', 'Lawyer 2', 'Lawyer 3'];
  String selectedLawyer = 'Lawyer 1';

  void handleLogin() {
    String userId = userIdController.text;
    String password = passwordController.text;

    if (isPrisonerLogin && userId == 'user' && password == 'password') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen(isAdmin: false)),
      );
    } else if (!isPrisonerLogin &&
        userId == 'admin' &&
        password == 'adminpassword') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen(isAdmin: true)),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid credentials. Please try again.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/law_justice_logo.jpg",
                width: 120.0,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPrisonerLogin = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 24.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Prisoner Login',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPrisonerLogin = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.admin_panel_settings,
                      size: 24.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Admin Login',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: isPrisonerLogin
                    ? Icon(
                        Icons.person,
                        size: 60.0,
                        color: Colors.grey,
                      )
                    : Icon(
                        Icons.admin_panel_settings,
                        size: 60.0,
                        color: Colors.green,
                      ),
              ),
              SizedBox(height: 10.0),
              Text(isPrisonerLogin ? 'Prisoner Login' : 'Admin Login'),
              SizedBox(height: 10.0),
              Container(
                width: 200.0,
                child: TextField(
                  controller: userIdController,
                  decoration: InputDecoration(
                    hintText: 'Enter ID',
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: 200.0,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: handleLogin,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class WelcomeScreen extends StatelessWidget {
  final bool isAdmin;

  WelcomeScreen({required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
      ),
      body: WelcomePageContent(isAdmin: isAdmin),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('App Menu'),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
            Divider(),
            ExpansionTile(
              title: Text('Legal Assistance Platform'),
              children: [
                ListTile(
                  title: Text('Get Connected to a Lawyer'),
                ),
                ListTile(
                  title: Text('Chat with your Lawyer'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Legal Information Portal'),
              children: [
                ListTile(
                  title: Text('UTP Rights,Laws and Policies'),
                ),
                ListTile(
                  title: Text('UTRCs Recommendations and Documentation'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Mental Health and Rehabilitation Portal'),
              children: [
                ListTile(
                  title: Text('Get connected with a Mental Health Expert'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                      'NIOS Platform for Vocational and Educational Training'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            if (isAdmin)
              ExpansionTile(
                title: Text('UTP Status Tracker'),
                children: [
                  ListTile(
                    title: Text('View Complete Prisoner Information'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Prisoner Monitoring Portal'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('View Similar Previous Case Histories'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class WelcomePageContent extends StatelessWidget {
  final bool isAdmin;

  WelcomePageContent({required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        WelcomePageItem(
          imageAsset: 'assets/welcome_image1.png',
          text: 'MODEL PAGE',
        ),
        WelcomePageItem(
          imageAsset: 'assets/welcome_image2.png',
          text: 'MODEL PAGE',
        ),
      ],
    );
  }
}

class WelcomePageItem extends StatelessWidget {
  final String imageAsset;
  final String text;

  WelcomePageItem({required this.imageAsset, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          imageAsset,
          width: 200,
          height: 200,
        ),
        SizedBox(height: 20),
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage userMessage = ChatMessage(
      text: text,
      isUser: true,
    );
    setState(() {
      _messages.insert(0, userMessage);
    });

    Future.delayed(Duration(seconds: 2), () {
      String botResponse = 'Hello, how can I assist you?';
      ChatMessage botMessage = ChatMessage(
        text: botResponse,
        isUser: false,
      );
      setState(() {
        _messages.insert(0, botMessage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Lawyer'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.amber),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final messageAlignment =
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: messageAlignment,
        children: <Widget>[
          isUser ? Container() : CircleAvatar(),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isUser ? Colors.amberAccent : Colors.grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
