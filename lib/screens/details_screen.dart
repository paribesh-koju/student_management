
import 'package:flutter/material.dart';
import 'package:student_management/models/student.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late TextEditingController _fnameController;
  late TextEditingController _lnameController;
  late TextEditingController _cityController;

  final _gap = const SizedBox(height: 10);


  void inState(){
    super.initState();
    _fnameController = TextEditingController(text: 'Paribesh');
    _lnameController = TextEditingController(text: 'koju');
    _cityController = TextEditingController();
  }

  List<DropdownMenuItem> cities = [
    const DropdownMenuItem(
      value: 'Kathmandu', // timile select garda
      child: Text('Kathmandu'), // user lai dekhaune
    ),
    const DropdownMenuItem(value: 'Bhaktapur', child: Text('Bhaktapur')),
    const DropdownMenuItem(value: 'Lalitpur', child: Text('Lalitpur')),
  ];

  final _key = GlobalKey<FormState>();

  List<Student> students = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _fnameController,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter fname';
                  }
                  return null;
                },
              ),
              _gap,
              TextFormField(
                controller: _lnameController,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter lname';
                  }
                  return null;
                },
              ),
              _gap,
              DropdownButtonFormField(
                items: cities,
                onChanged: (value) {
                  _cityController.text = value.toString();
                },
                decoration: const InputDecoration(
                  hintText: 'Select city',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select city';
                  }
                  return null;
                },
              ),
              _gap,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      final student = Student(
                        fname: _fnameController.text,
                        lname: _lnameController.text,
                        city: _cityController.text,
                      );
                      setState(() {
                        students.add(student);
                      });
                    }
                  },
                  child: const Text('Add Student'),
                ),
              ),
              _gap,
              const Text(
                'Student List',
                style: TextStyle(fontSize: 20),
              ),
              students.isEmpty

                  ? const Text('No data')
                  : Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    // return ListTile(
                    //   leading: const Icon(Icons.person),
                    //   title: Text(students[index].fname),
                    //   subtitle: Text(students[index].city),
                    //   trailing: IconButton(
                    //     icon: const Icon(Icons.delete),
                    //     onPressed: () {
                    //       setState(() {
                    //         students.removeAt(index);
                    //       });
                    //     },
                    //   ),
                    // );
                    return SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Card(
                        color: Colors.amberAccent,
                        child: Text(
                          students[index].fname,
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}