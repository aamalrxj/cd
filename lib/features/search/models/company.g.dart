// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyImpl _$$CompanyImplFromJson(Map<String, dynamic> json) =>
    _$CompanyImpl(
      isin: json['isin'] as String,
      name: json['name'] as String,
      rating: json['rating'] as String,
      description: json['description'] as String,
      isActive: json['isActive'] as bool,
      ebitda: (json['ebitda'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      revenue: (json['revenue'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$$CompanyImplToJson(_$CompanyImpl instance) =>
    <String, dynamic>{
      'isin': instance.isin,
      'name': instance.name,
      'rating': instance.rating,
      'description': instance.description,
      'isActive': instance.isActive,
      'ebitda': instance.ebitda,
      'revenue': instance.revenue,
    };
