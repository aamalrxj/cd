import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import '../cubit/search_cubit.dart';
import '../models/company.dart';
import 'company_detail_page.dart';
import '../../../core/di/injection.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by Issuer Name or ISIN',
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onChanged: (value) {
                      context.read<SearchCubit>().search(value);
                      HapticFeedback.selectionClick();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    final query = context.read<SearchCubit>().lastQuery;
                    return state.when(
                      initial: () => _buildSectionedSuggestedResults(context),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      loaded: (companies) => _buildSectionedSearchResults(context, companies, query),
                      error: (msg) => Center(child: Text(msg)),
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

  Widget _buildSectionedSuggestedResults(BuildContext context) {
    final suggestedCompanies = [
      {
        'isin': 'INE06E507172',
        'rating': 'AAA',
        'name': 'Hella Infra Market Private Limited',
      },
      {
        'isin': 'INE123A01016',
        'rating': 'AA+',
        'name': 'Reliance Industries Limited',
      },
      {
        'isin': 'INE002A01018',
        'rating': 'AAA',
        'name': 'Tata Consultancy Services',
      },
      {
        'isin': 'INE040A01034',
        'rating': 'AA',
        'name': 'Infosys Limited',
      },
      {
        'isin': 'INE467B01029',
        'rating': 'AAA',
        'name': 'HDFC Bank Limited',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SUGGESTED RESULTS',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFFB2B2B2),
              fontSize: 13,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: suggestedCompanies.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final company = suggestedCompanies[index];
                return _companyCard(
                  context,
                  isin: company['isin']!,
                  rating: company['rating']!,
                  name: company['name']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CompanyDetailPage(),
                      ),
                    );
                    HapticFeedback.lightImpact();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionedSearchResults(BuildContext context, List<Company> companies, String query) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SEARCH RESULTS',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFFB2B2B2),
              fontSize: 13,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: companies.isEmpty
                ? const Center(child: Text('No results found.'))
                : ListView.separated(
              itemCount: companies.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final company = companies[index];
                return _companyCard(
                  context,
                  isin: company.isin,
                  rating: company.rating,
                  name: company.name,
                  query: query,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CompanyDetailPage(company: company),
                      ),
                    );
                    HapticFeedback.heavyImpact();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _companyCard(
      BuildContext context, {
        required String isin,
        required String rating,
        required String name,
        String query = "",
        required VoidCallback onTap,
      }) {
    TextSpan highlight(String text) {
      if (query.isEmpty) return TextSpan(text: text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16));
      final lcText = text.toLowerCase();
      final lcQuery = query.toLowerCase();
      final start = lcText.indexOf(lcQuery);
      if (start == -1) return TextSpan(text: text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16));
      return TextSpan(
        children: [
          TextSpan(text: text.substring(0, start)),
          TextSpan(
            text: text.substring(start, start + query.length),
            style: const TextStyle(
              backgroundColor: Color(0xFFFFE082),
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          TextSpan(text: text.substring(start + query.length)),
        ],
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      );
    }

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange[100],
          child: Text('IM', style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.bold)),
        ),
        title: RichText(text: highlight(isin)),
        subtitle: Row(
          children: [
            Text(
              '$rating • ',
              style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFB2B2B2)),
            ),
            Expanded(
              child: RichText(
                text: highlight(name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}
