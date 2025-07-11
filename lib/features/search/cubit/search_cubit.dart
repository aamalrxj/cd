import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/company.dart';
import 'package:injectable/injectable.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  String _lastQuery = '';
  String get lastQuery => _lastQuery;

  SearchCubit() : super(const SearchState.initial());

  Future<void> search(String query) async {
    _lastQuery = query;
    emit(const SearchState.loading());
    await Future.delayed(const Duration(milliseconds: 500));
    final results = _mockCompanies
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()) || c.isin.contains(query))
        .toList();
    emit(SearchState.loaded(results));
  }
}

const _mockCompanies = [
  Company(
    isin: 'INE06E507172',
    name: 'Hella Infra Market Private Limited',
    rating: 'AAA',
    description: 'Hella Infra is a construction materials platform...',
    isActive: true,
    ebitda: [1.2, 1.4, 1.3, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3],
    revenue: [2.2, 2.4, 2.3, 2.5, 2.6, 2.7, 2.8, 2.9, 3.0, 3.1, 3.2, 3.3],
  ),
  Company(
    isin: 'INE123A01016',
    name: 'Reliance Industries Limited',
    rating: 'AA+',
    description: 'Reliance is a diversified conglomerate in India.',
    isActive: true,
    ebitda: [2.5, 2.7, 2.8, 3.0, 3.2, 3.3, 3.5, 3.7, 3.9, 4.0, 4.2, 4.4],
    revenue: [5.0, 5.1, 5.3, 5.6, 5.8, 6.0, 6.2, 6.5, 6.7, 7.0, 7.2, 7.5],
  ),
  Company(
    isin: 'INE002A01018',
    name: 'Tata Consultancy Services',
    rating: 'AAA',
    description: 'TCS is a leading global IT services company.',
    isActive: true,
    ebitda: [1.8, 1.9, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9],
    revenue: [3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4.0, 4.1],
  ),
  Company(
    isin: 'INE040A01034',
    name: 'Infosys Limited',
    rating: 'AA',
    description: 'Infosys is a multinational corporation providing IT consulting.',
    isActive: true,
    ebitda: [1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2],
    revenue: [2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 3.0, 3.1, 3.2],
  ),
  Company(
    isin: 'INE467B01029',
    name: 'HDFC Bank Limited',
    rating: 'AAA',
    description: 'HDFC Bank is a major Indian banking and financial services company.',
    isActive: true,
    ebitda: [2.0, 2.2, 2.3, 2.5, 2.6, 2.7, 2.9, 3.0, 3.2, 3.3, 3.5, 3.6],
    revenue: [4.0, 4.1, 4.3, 4.4, 4.6, 4.7, 4.9, 5.0, 5.2, 5.3, 5.5, 5.6],
  ),
  // Add as many more as you want in this format
];
