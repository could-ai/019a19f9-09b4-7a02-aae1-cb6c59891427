import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dating App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class User {
  final String name;
  final int age;
  final String bio;
  final String imageUrl;

  User({
    required this.name,
    required this.age,
    required this.bio,
    required this.imageUrl,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<User> _users = [
    User(
      name: 'Alice',
      age: 25,
      bio: 'Lover of art, travel, and good food. Looking for someone to share adventures with.',
      imageUrl: 'https://picsum.photos/id/1011/800/800',
    ),
    User(
      name: 'Bob',
      age: 28,
      bio: 'Software engineer by day, musician by night. Let\'s talk about tech and tunes.',
      imageUrl: 'https://picsum.photos/id/1012/800/800',
    ),
    User(
      name: 'Clara',
      age: 23,
      bio: 'Fitness enthusiast and dog lover. My golden retriever is my world!',
      imageUrl: 'https://picsum.photos/id/1027/800/800',
    ),
     User(
      name: 'David',
      age: 30,
      bio: 'I enjoy hiking, photography, and exploring new coffee shops.',
      imageUrl: 'https://picsum.photos/id/1005/800/800',
    ),
  ];

  int _currentIndex = 0;

  void _nextUser() {
    setState(() {
      if (_currentIndex < _users.length - 1) {
        _currentIndex++;
      } else {
        // Optional: Handle case when all users are viewed
        // For now, let's just show a "no more users" message
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Dating App'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentIndex < _users.length
            ? Column(
                children: [
                  Expanded(
                    child: ProfileCard(user: _users[_currentIndex]),
                  ),
                  const SizedBox(height: 20),
                  _buildActionButtons(),
                ],
              )
            : const Center(
                child: Text(
                  'No more profiles to show!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.red, size: 40),
          onPressed: _nextUser,
        ),
        IconButton(
          icon: const Icon(Icons.favorite, color: Colors.green, size: 40),
          onPressed: _nextUser,
        ),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final User user;

  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Image.network(
            user.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            // Simple loading builder
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}, ${user.age}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.bio,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
