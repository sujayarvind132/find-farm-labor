import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_state.dart';

class LaborerHomeScreen extends StatefulWidget {
  const LaborerHomeScreen({Key? key}) : super(key: key);

  @override
  State<LaborerHomeScreen> createState() => _LaborerHomeScreenState();
}

class _LaborerHomeScreenState extends State<LaborerHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text(
              '🌾 ',
              style: TextStyle(fontSize: 24),
            ),
            Text('Krishi Sahayak'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => appState.toggleTheme(),
            icon: Icon(appState.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
          TextButton(
            onPressed: () => appState.logout(),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: '💼 Available Jobs'),
            Tab(text: '✅ Applied'),
            Tab(text: '👤 Profile'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          // Available Jobs Tab
          _AvailableJobsTab(appState: appState),
          // Applied Jobs Tab
          _AppliedJobsTab(appState: appState),
          // Profile Tab
          _ProfileTab(appState: appState),
        ],
      ),
    );
  }
}

class _AvailableJobsTab extends StatefulWidget {
  final AppState appState;

  const _AvailableJobsTab({Key? key, required this.appState})
      : super(key: key);

  @override
  State<_AvailableJobsTab> createState() => _AvailableJobsTabState();
}

class _AvailableJobsTabState extends State<_AvailableJobsTab> {
  String selectedWorkType = '';

  @override
  Widget build(BuildContext context) {
    final appState = widget.appState;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Nearby Jobs',
                  value: appState.jobs.length.toString(),
                  icon: Icons.work,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Applied',
                  value: appState.appliedJobs.length.toString(),
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Filter
          DropdownButton<String>(
            value: selectedWorkType.isEmpty ? null : selectedWorkType,
            hint: const Text('Filter by work type'),
            items: ['', 'harvesting', 'planting', 'irrigation', 'machinery']
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.isEmpty ? 'All Types' : type),
                    ))
                .toList(),
            onChanged: (value) => setState(() => selectedWorkType = value ?? ''),
          ),
          const SizedBox(height: 20),

          // Jobs List
          if (appState.jobs.isEmpty)
            Center(
              child: Column(
                children: const [
                  Icon(Icons.search, size: 48, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No jobs available nearby'),
                ],
              ),
            )
          else
            Column(
              children: appState.jobs
                  .where((job) => selectedWorkType.isEmpty ||
                      job['type'] == selectedWorkType)
                  .map((job) {
                final isApplied =
                    appState.appliedJobs.contains(job['id']);
                return _JobCard(
                  job: job,
                  isApplied: isApplied,
                  onApply: () {
                    appState.applyForJob(job['id']);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('✅ Applied successfully!')),
                    );
                  },
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _AppliedJobsTab extends StatelessWidget {
  final AppState appState;

  const _AppliedJobsTab({Key? key, required this.appState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appliedJobs = appState.getAppliedJobs();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: appliedJobs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.inbox, size: 48, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No applications yet'),
                  SizedBox(height: 8),
                  Text('Apply for jobs to get started!',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            )
          : Column(
              children: appliedJobs.map((job) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle,
                        color: Color(0xFF10b981)),
                    title: Text(job['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(job['location']),
                        Text('Farmer: ${job['farmerName']}',
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    trailing: Chip(
                      label: const Text('Applied'),
                      backgroundColor: const Color(0xFF10b981).withOpacity(0.2),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}

class _ProfileTab extends StatefulWidget {
  final AppState appState;

  const _ProfileTab({Key? key, required this.appState}) : super(key: key);

  @override
  State<_ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<_ProfileTab> {
  late TextEditingController nameController;
  late TextEditingController wageController;
  Set<String> selectedSkills = {};
  String selectedAvailability = 'daily';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    wageController = TextEditingController(text: '500');
  }

  @override
  void dispose() {
    nameController.dispose();
    wageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Avatar
          Center(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2d7d3d), Color(0xFF1e5a2d)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(Icons.person,
                      size: 40, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Complete Your Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Name
          const Text('Full Name',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Enter your full name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 20),

          // Skills
          const Text('Skills', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: ['harvesting', 'planting', 'irrigation', 'machinery']
                .map((skill) => FilterChip(
                      label: Text(skill),
                      selected: selectedSkills.contains(skill),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedSkills.add(skill);
                          } else {
                            selectedSkills.remove(skill);
                          }
                        });
                      },
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),

          // Expected Wage
          const Text('Expected Daily Wage (₹)',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: wageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter wage',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.currency_rupee),
            ),
          ),
          const SizedBox(height: 20),

          // Availability
          const Text('Availability',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedAvailability,
            items: ['daily', 'weekly', 'seasonal']
                .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                .toList(),
            onChanged: (value) =>
                setState(() => selectedAvailability = value ?? 'daily'),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.calendar_today),
            ),
          ),
          const SizedBox(height: 28),

          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    selectedSkills.isNotEmpty) {
                  widget.appState.currentUser = {
                    'name': nameController.text,
                    'skills': selectedSkills.toList(),
                    'wage': int.tryParse(wageController.text) ?? 500,
                    'availability': selectedAvailability,
                  };
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('✅ Profile saved successfully!')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2d7d3d),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Save Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2d7d3d), Color(0xFF1e5a2d)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final Map<String, dynamic> job;
  final bool isApplied;
  final VoidCallback onApply;

  const _JobCard({
    Key? key,
    required this.job,
    required this.isApplied,
    required this.onApply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job['location'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFf59e0b),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '₹${job['wage']}/day',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.people, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${job['workersNeeded']} needed',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Color(0xFFfbbf24)),
                    const SizedBox(width: 4),
                    Text('${job['farmerRating']}',
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isApplied ? null : onApply,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isApplied ? Colors.grey : const Color(0xFF2d7d3d),
                  disabledBackgroundColor: Colors.grey,
                ),
                child: Text(
                  isApplied ? '✅ Applied' : '📝 Apply Now',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
