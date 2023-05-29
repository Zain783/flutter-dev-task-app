import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../resources/firestore_methords.dart';

class UserCrudScreen extends StatefulWidget {
  @override
  _UserCrudScreenState createState() => _UserCrudScreenState();
}

class _UserCrudScreenState extends State<UserCrudScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late CollectionReference _usersCollection;

  @override
  void initState() {
    super.initState();
    _usersCollection = FirebaseFirestore.instance.collection('users');
  }

  void _addUser() {
    FireStoreMethods.createUser(
      context,
      _usersCollection,
      _nameController,
      _emailController,
    );
    _nameController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Crud Management'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordActionScreen2(
                    emailController: _emailController,
                    nameController: _nameController,
                    usersCollection: _usersCollection,
                    isEdit: false,
                    // Pass the appropriate user snapshot here
                  ),
                ),
              );
            },
            child: const Text('Add User'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: _usersCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final users = snapshot.data!.docs;
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ListTile(
                              title: Text(user['name']),
                              subtitle: Text(user['email']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _nameController.text = user['name'];
                                      _emailController.text = user['email'];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RecordActionScreen(
                                            emailController: _emailController,
                                            nameController: _nameController,
                                            isEdit: true,
                                            usersCollection: _usersCollection,
                                            userSnapshot:
                                                user, // Pass the user snapshot here
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      FireStoreMethods.deleteUser(
                                          context, user);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class RecordActionScreen extends StatelessWidget {
  RecordActionScreen({
    Key? key,
    required this.emailController,
    required this.nameController,
    required this.usersCollection,
    required this.isEdit,
    required this.userSnapshot,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;
  final CollectionReference usersCollection;
  final bool isEdit;
  final DocumentSnapshot userSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (isEdit) {
                  FireStoreMethods.updateUser(
                    context,
                    userSnapshot,
                    nameController,
                    emailController,
                  );
                } else {
                  FireStoreMethods.createUser(
                    context,
                    usersCollection,
                    nameController,
                    emailController,
                  );
                }
              },
              child: const Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordActionScreen2 extends StatelessWidget {
  RecordActionScreen2({
    Key? key,
    required this.emailController,
    required this.nameController,
    required this.usersCollection,
    required this.isEdit,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;
  final CollectionReference usersCollection;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FireStoreMethods.createUser(
                  context,
                  usersCollection,
                  nameController,
                  emailController,
                );
              },
              child: const Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}
