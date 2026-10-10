
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bio-Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          primary: const Color(0xFF1B5E20),
          secondary: const Color(0xFF81C784),
          surface: const Color(0xFFF1F8E9),
        ),
        scaffoldBackgroundColor: const Color(0xFFE8F5E9),
      ),
      home: const BioDataScreen(),
    );
  }
}

class BioDataScreen extends StatefulWidget {
  const BioDataScreen({super.key});

  @override
  State<BioDataScreen> createState() => _BioDataScreenState();
}

class _BioDataScreenState extends State<BioDataScreen> {
  final TextEditingController nameController =
      TextEditingController();
  final TextEditingController dobController =
      TextEditingController();
  final TextEditingController pobController =
      TextEditingController();
  final TextEditingController ageController =
      TextEditingController();
  final TextEditingController genderController =
      TextEditingController();
  final TextEditingController civilStatusController =
      TextEditingController();
  final TextEditingController heightWeightController =
      TextEditingController();
  final TextEditingController nationalityController =
      TextEditingController();
  final TextEditingController religionController =
      TextEditingController();

  final TextEditingController addressController =
      TextEditingController();
  final TextEditingController phoneController =
      TextEditingController();
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController fatherNameController =
      TextEditingController();
  final TextEditingController fatherOccController =
      TextEditingController();
  final TextEditingController motherNameController =
      TextEditingController();
  final TextEditingController motherOccController =
      TextEditingController();

  final TextEditingController elemController =
      TextEditingController();
  final TextEditingController highSchoolController =
      TextEditingController();
  final TextEditingController collegeController =
      TextEditingController();
  final TextEditingController courseController =
      TextEditingController();

  final TextEditingController experienceController =
      TextEditingController();
  final TextEditingController skillsController =
      TextEditingController();
  final TextEditingController referenceController =
      TextEditingController();

  String generatedBioData = '';
  bool isSaving = false;

  Future<void> _generateBioData() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;

      generatedBioData = '''

             COMPLETE BIO-DATA

1. PERSONAL INFORMATION
- Full Name: ${nameController.text}
- Date of Birth: ${dobController.text}
- Place of Birth: ${pobController.text}
- Age: ${ageController.text}
- Gender: ${genderController.text}
- Civil Status: ${civilStatusController.text}
- Height & Weight: ${heightWeightController.text}
- Nationality: ${nationalityController.text}
- Religion: ${religionController.text}

2. CONTACT INFORMATION
- Address: ${addressController.text}
- Phone: ${phoneController.text}
- Email: ${emailController.text}

3. FAMILY BACKGROUND
- Father's Name: ${fatherNameController.text} (${fatherOccController.text})
- Mother's Name: ${motherNameController.text} (${motherOccController.text})

4. EDUCATIONAL BACKGROUND
- Elementary: ${elemController.text}
- High School: ${highSchoolController.text}
- College: ${collegeController.text}
- Course/Degree: ${courseController.text}

5. WORK EXPERIENCE & SKILLS
- Work Experience: ${experienceController.text}
- Key Skills: ${skillsController.text}

6. CHARACTER REFERENCE
${referenceController.text}

==========================================
I hereby certify that the information above is true
and correct to the best of my knowledge and belief.
''';
    });

    try {
      await FirebaseFirestore.instance
          .collection('biodata')
          .add({
        'fullName': nameController.text.trim(),
        'dateOfBirth': dobController.text.trim(),
        'placeOfBirth': pobController.text.trim(),
        'age': ageController.text.trim(),
        'gender': genderController.text.trim(),
        'civilStatus': civilStatusController.text.trim(),
        'heightWeight': heightWeightController.text.trim(),
        'nationality': nationalityController.text.trim(),
        'religion': religionController.text.trim(),
        'address': addressController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'fatherName': fatherNameController.text.trim(),
        'fatherOccupation': fatherOccController.text.trim(),
        'motherName': motherNameController.text.trim(),
        'motherOccupation': motherOccController.text.trim(),
        'elementary': elemController.text.trim(),
        'highSchool': highSchoolController.text.trim(),
        'college': collegeController.text.trim(),
        'course': courseController.text.trim(),
        'workExperience': experienceController.text.trim(),
        'skills': skillsController.text.trim(),
        'characterReference': referenceController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Bio-Data saved successfully to Firebase!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save Bio-Data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    pobController.dispose();
    ageController.dispose();
    genderController.dispose();
    civilStatusController.dispose();
    heightWeightController.dispose();
    nationalityController.dispose();
    religionController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    fatherNameController.dispose();
    fatherOccController.dispose();
    motherNameController.dispose();
    motherOccController.dispose();
    elemController.dispose();
    highSchoolController.dispose();
    collegeController.dispose();
    courseController.dispose();
    experienceController.dispose();
    skillsController.dispose();
    referenceController.dispose();
    super.dispose();
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 8.0,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1B5E20),
        ),
      ),
    );
  }

  Widget _buildGreenTextField(
    String label,
    TextEditingController controller, {
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.green.shade800,
            fontSize: 13,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Color(0xFFA5D6A7),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Color(0xFF2E7D32),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complete Bio-Data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    '1. Personal Information',
                  ),
                  _buildGreenTextField(
                    'Full Name',
                    nameController,
                  ),
                  _buildGreenTextField(
                    'Date of Birth',
                    dobController,
                  ),
                  _buildGreenTextField(
                    'Place of Birth',
                    pobController,
                  ),
                  _buildGreenTextField(
                    'Age',
                    ageController,
                    inputType: TextInputType.number,
                  ),
                  _buildGreenTextField(
                    'Gender',
                    genderController,
                  ),
                  _buildGreenTextField(
                    'Civil Status',
                    civilStatusController,
                  ),
                  _buildGreenTextField(
                    'Height & Weight',
                    heightWeightController,
                  ),
                  _buildGreenTextField(
                    'Nationality',
                    nationalityController,
                  ),
                  _buildGreenTextField(
                    'Religion',
                    religionController,
                  ),

                  const Divider(
                    height: 24,
                    color: Color(0xFFC8E6C9),
                  ),

                  _buildSectionHeader(
                    '2. Contact Information',
                  ),
                  _buildGreenTextField(
                    'Address',
                    addressController,
                    maxLines: 2,
                  ),
                  _buildGreenTextField(
                    'Phone Number',
                    phoneController,
                    inputType: TextInputType.phone,
                  ),
                  _buildGreenTextField(
                    'Email Address',
                    emailController,
                    inputType: TextInputType.emailAddress,
                  ),

                  const Divider(
                    height: 24,
                    color: Color(0xFFC8E6C9),
                  ),

                  _buildSectionHeader(
                    '3. Family Background',
                  ),
                  _buildGreenTextField(
                    "Father's Name",
                    fatherNameController,
                  ),
                  _buildGreenTextField(
                    "Father's Occupation",
                    fatherOccController,
                  ),
                  _buildGreenTextField(
                    "Mother's Maiden Name",
                    motherNameController,
                  ),
                  _buildGreenTextField(
                    "Mother's Occupation",
                    motherOccController,
                  ),

                  const Divider(
                    height: 24,
                    color: Color(0xFFC8E6C9),
                  ),

                  _buildSectionHeader(
                    '4. Educational Background',
                  ),
                  _buildGreenTextField(
                    'Elementary School',
                    elemController,
                  ),
                  _buildGreenTextField(
                    'High School',
                    highSchoolController,
                  ),
                  _buildGreenTextField(
                    'College / University',
                    collegeController,
                  ),
                  _buildGreenTextField(
                    'Course / Degree',
                    courseController,
                  ),

                  const Divider(
                    height: 24,
                    color: Color(0xFFC8E6C9),
                  ),

                  _buildSectionHeader(
                    '5. Experience & References',
                  ),
                  _buildGreenTextField(
                    'Work Experience',
                    experienceController,
                    maxLines: 2,
                  ),
                  _buildGreenTextField(
                    'Skills',
                    skillsController,
                    maxLines: 2,
                  ),
                  _buildGreenTextField(
                    'Character Reference Name & Contact',
                    referenceController,
                    maxLines: 2,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4CAF50),
                    Color(0xFF1B5E20),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: isSaving
                    ? null
                    : _generateBioData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  isSaving
                      ? 'Saving...'
                      : 'Generate Bio-Data',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            if (generatedBioData.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F8E9),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: const Color(0xFFA5D6A7),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.08),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: SelectableText(
                  generatedBioData,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Color(0xFF1B5E20),
                    fontFamily: 'monospace',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}