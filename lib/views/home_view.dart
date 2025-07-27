import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/get_all_product_service.dart';
import 'package:store_app/services/categories_service.dart';
import 'package:store_app/widgets/custom_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String id = 'Home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> categories = [
    'all',
    'men\'s clothing',
    'women\'s clothing',
    'jewelery',
    'electronics',
  ];
  late Future<List<ProductModel>> _productsFuture;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _loadProducts('all');

    // Listen to tab changes
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _loadProducts(categories[_tabController.index]);
      }
    });
  }

  void _loadProducts(String category) {
    setState(() {
      _isLoading = true; // Set loading to true when starting to fetch
    });

    // Define the future based on category
    Future<List<ProductModel>> future;
    if (category == 'all') {
      future = AllProductsService().getAllProducts();
    } else {
      future = CategoriesService().getCategoriesProducts(
        categoryName: category,
      );
    }

    // Update state with the new future
    setState(() {
      _productsFuture = future;
    });

    // When future completes, update loading state
    future
        .then((_) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        })
        .catchError((error) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.white,
            actionsPadding: EdgeInsets.only(right: 8),
            centerTitle: false,
            title: Text(
              'Discover',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 'RationalDisplaySemiBold',
                letterSpacing: 0.01,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/notifi.svg'),
              ),
            ],
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
            snap: true,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 64),
              child: TabBar(
                controller: _tabController,
                padding: EdgeInsets.symmetric(horizontal: 16),
                labelPadding: EdgeInsets.symmetric(horizontal: 4),
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Container(
                      width: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColor900),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text('All')),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 128,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColor900),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text('Men\'s clothing')),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 142,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColor900),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text('Women\'s clothing')),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColor900),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text('Jewelery')),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 98,
                      decoration: BoxDecoration(
                        border: Border.all(color: kColor900),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text('Electronics')),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading indicator when switching tabs
          if (_isLoading)
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),

          // Products grid
          if (!_isLoading)
            SliverToBoxAdapter(
              child: FutureBuilder<List<ProductModel>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 48,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      clipBehavior: Clip.none,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 64,
                        crossAxisSpacing: 16,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        return CustomCard(product: product);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Error loading products: ${snapshot.error}',
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink(); // This should not happen as we handle loading state separately
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
