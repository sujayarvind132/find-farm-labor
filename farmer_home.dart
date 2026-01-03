import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_state.dart';

class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({Key? key}) : super(key: key);

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen>
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
            Tab(text: '📋 My Jobs'),
            Tab(text: '👥 Find Laborers'),
            Tab(text: '⭐ Favorites'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          // My Jobs Tab
          _MyJobsTab(appState: appState),
          // Find Laborers Tab
          _FindLaborersTab(appState: appState),
          // Favorites Tab
          _FavoritesTab(appState: appState),
        ],
      ),
    );
  }
}

class _MyJobsTab extends StatelessWidget {
  final AppState appState;

  const _MyJobsTab({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Stats
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Active Jobs',
                  value: appState.jobs.length.toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Applications',
                  value: appState.jobs.fold(0, (sum, job) => sum + (job['applications'] as int)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Create Job Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showCreateJobDialog(context, appState),
              icon: const Icon(Icons.add),
              label: const Text('Create New Job Posting'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: const Color(0xFF2d7d3d),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Jobs List
          if (appState.jobs.isEmpty)
            Center(
              child: Column(
                children: const [
                  Icon(Icons.assignment, size: 48, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No job postings yet'),
                ],
              ),
            )
          else
            Column(
              children: appState.jobs.map((job) {
                return _JobCard(job: job);
              }).toList(),
            ),
        ],
      ),
    );
  }

  void _showCreateJobDialog(BuildContext context, AppState appState) {
    final formKey = GlobalKey<FormState>();
    String workType = '';
    int workersNeeded = 1;
    int wage = 0;
    String duration = 'daily';
    String location = '';
    String description = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Job Posting'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Type of Work'),
                  items: ['Harvesting', 'Planting', 'Irrigation', 'Machinery', 'Livestock']
                      .map((t) => DropdownMenuItem(value: t.toLowerCase(), child: Text(t)))
                      .toList(),
                  onChanged: (v) => workType = v ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Workers Needed'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => workersNeeded = int.tryParse(v) ?? 1,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Daily Wage (₹)'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => wage = int.tryParse(v) ?? 0,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Duration'),
                  value: 'daily',
                  items: ['daily', 'weekly', 'seasonal']
                      .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                      .toList(),
                  onChanged: (v) => duration = v ?? 'daily',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Location'),
                  onChanged: (v) => location = v,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  onChanged: (v) => description = v,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (workType.isNotEmpty &&
                  wage > 0 &&
                  location.isNotEmpty) {
                appState.createJob({
                  'title': workType,
                  'type': workType,
                  'workersNeeded': workersNeeded,
                  'wage': wage,
                  'duration': duration,
                  'location': location,
                  'description': description,
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ Job posted successfully!')),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Post Job'),
          ),
        ],
      ),
    );
  }
}

class _FindLaborersTab extends StatelessWidget {
  final AppState appState;

  const _FindLaborersTab({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nearby Laborers',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: appState.laborers.length,
            itemBuilder: (context, index) {
              final laborer = appState.laborers[index];
              return _LaborerCard(laborer: laborer, appState: appState);
            },
          ),
        ],
      ),
    );
  }
}

class _FavoritesTab extends StatelessWidget {
  final AppState appState;

  const _FavoritesTab({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: appState.favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star, size: 48, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No favorite laborers yet'),
                ],
              ),
            )
          : Column(
              children: appState.favorites.map((laborer) {
                return _LaborerCard(laborer: laborer, appState: appState);
              }).toList(),
            ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({
    Key? key,
    required this.label,
    required this.value,
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
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final Map<String, dynamic> job;

  const _JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(job['title']),
        subtitle: Text('${job['location']} • ₹${job['wage']}/day'),
        trailing: Text('₹${job['wage']}'),
        leading: const Icon(Icons.work),
      ),
    );
  }
}

class _LaborerCard extends StatelessWidget {
  final Map<String, dynamic> laborer;
  final AppState appState;

  const _LaborerCard({
    Key? key,
    required this.laborer,
    required this.appState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFavorite = appState.favorites.any((f) => f['id'] == laborer['id']);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Text(laborer['avatar'], style: const TextStyle(fontSize: 32)),
        title: Text(laborer['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('⭐ ${laborer['rating']} • ${laborer['reviews']} reviews'),
            Text('${laborer['experience']} • ₹${laborer['wage']}/day'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          color: isFavorite ? Colors.red : Colors.grey,
          onPressed: () {
            if (isFavorite) {
              appState.removeFromFavorites(laborer['id']);
            } else {
              appState.addToFavorites(laborer);
            }
          },
        ),
      ),
    );
  }
}
