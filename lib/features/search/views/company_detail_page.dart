import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/company.dart';

class CompanyDetailPage extends StatefulWidget {
  final Company? company;
  const CompanyDetailPage({Key? key, this.company}) : super(key: key);

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> with SingleTickerProviderStateMixin {
  bool showEbitda = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.company ??
        Company(
          isin: 'INE06E507157',
          name: 'Hella Infra Market Private Limited',
          rating: 'AAA',
          description: 'Hella Infra is a construction materials platform that enhances operational efficiency...',
          isActive: true,
          ebitda: [1.2, 1.4, 1.3, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3],
          revenue: [2.2, 2.4, 2.3, 2.5, 2.6, 2.7, 2.8, 2.9, 3.0, 3.1, 3.2, 3.3],
        );

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange[100],
              child: Text('IM', style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                c.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.description,
              style: TextStyle(color: Colors.grey[700], fontSize: 15),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Chip(
                  label: Text('ISIN: ${c.isin}', style: TextStyle(color: Colors.blue[900])),
                  backgroundColor: Colors.blue[50],
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(c.isActive ? 'ACTIVE' : 'INACTIVE', style: TextStyle(color: Colors.green[900])),
                  backgroundColor: c.isActive ? Colors.green[50] : Colors.red[50],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.orange,
                    tabs: const [
                      Tab(text: 'ISIN Analysis'),
                      Tab(text: 'Pros & Cons'),
                    ],
                  ),
                  SizedBox(
                    height: 340,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _financialSection(context, c),
                        _prosConsSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _issuerDetailsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _financialSection(BuildContext context, Company c) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                isSelected: [showEbitda, !showEbitda],
                onPressed: (idx) {
                  setState(() => showEbitda = idx == 0);
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('EBITDA'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('Revenue'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: BarChartWidget(data: showEbitda ? c.ebitda : c.revenue),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('J', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('F', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('M', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('A', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('M', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('J', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('J', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('A', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('S', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('O', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('N', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('D', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _prosConsSection() {
    // Design: card with colored icons, clear separation, and modern layout
    final pros = [
      "Majority GoI ownership marked with demonstrated government support and strong integration with the parent",
      "Strategic role in providing financial assistance to meet planned outlay of IR",
      "Strong asset quality considering entire exposure to MoR / MoR-owned entities",
      "Healthy capitalisation profile",
      "Diversified borrowings profile",
      "Liquidity: Adequate",
    ];
    final cons = [
      "Moderate profitability metrics",
      "High concentration risk",
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pros
          Expanded(
            child: Card(
              elevation: 0,
              color: const Color(0xFFE6F4EA),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.check_circle, color: Colors.green, size: 22),
                        SizedBox(width: 6),
                        Text("Pros", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...pros.map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check, color: Colors.green, size: 18),
                          const SizedBox(width: 6),
                          Expanded(child: Text(p, style: const TextStyle(fontSize: 14))),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Cons
          Expanded(
            child: Card(
              elevation: 0,
              color: const Color(0xFFFFEBEE),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.error, color: Colors.red, size: 22),
                        SizedBox(width: 6),
                        Text("Cons", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...cons.map((c) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.close, color: Colors.red, size: 18),
                          const SizedBox(width: 6),
                          Expanded(child: Text(c, style: const TextStyle(fontSize: 14))),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _issuerDetailsCard(BuildContext context) {
    // Modern card with clear label-value pairs, good spacing, and subtle dividers
    final details = [
      {'label': 'Issuer Name', 'value': 'TRUE CREDITS PRIVATE LIMITED'},
      {'label': 'Type of Issuer', 'value': 'Non PSU'},
      {'label': 'Sector', 'value': 'Financial Services'},
      {'label': 'Industry', 'value': 'Finance'},
      {'label': 'Issuer Nature', 'value': 'NBFC'},
      {'label': 'CIN', 'value': 'U65190HR2017PTC070653'},
      {'label': 'Lead Manager', 'value': 'Vivriti Capital'},
      {'label': 'Registrar', 'value': 'KFIN TECHNOLOGIES PRIVATE LIMITED'},
      {'label': 'Debenture Trustee', 'value': 'IDBI Trusteeship Services Limited'},
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8, bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Issuer Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            ...details.map((d) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 130,
                    child: Text('${d['label']}', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                  ),
                  Expanded(
                    child: Text('${d['value']}', style: const TextStyle(color: Colors.black87)),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// Bar chart widget using fl_chart
class BarChartWidget extends StatelessWidget {
  final List<double> data;
  const BarChartWidget({required this.data});
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (data.reduce((a, b) => a > b ? a : b) * 1.3),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: data.asMap().entries.map((e) =>
            BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: e.value,
                  color: Colors.orange,
                  width: 14,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            )
        ).toList(),
      ),
    );
  }
}
