import 'package:flutter/material.dart';
import 'package:galeri_teknologi_technical/view/login_screen.dart';
import 'package:galeri_teknologi_technical/view_model/provider/artist_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late SharedPreferences logindata;
  String name = "";

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      name = logindata.getString('name').toString();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataArtist =
        Provider.of<ArtistDetailProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search your Favorite Artist"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  logindata.setBool('login', true);
                  logindata.remove('name');
                  logindata.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Hi... $name",
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Cari",
                          // CLICK BUTTON SEARCH
                          suffixIcon: IconButton(
                            onPressed: () {
                              dataArtist.getSearch(_searchController.text);
                            },
                            icon: const Icon(Icons.search),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer(
                    builder: (context, ArtistDetailProvider dataArtistProvider,
                            _) =>
                        dataArtistProvider.state == StateGetSearch.loadingData
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : dataArtistProvider.state == StateGetSearch.noData
                                ? const Center(
                                    child: Text("No Data"),
                                  )
                                : ListView.builder(
                                    itemCount: dataArtistProvider.result.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 100,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 70,
                                                  width: 70,
                                                  child: Image.network(
                                                      dataArtistProvider
                                                          .result[index]
                                                          .artworkUrl100!),
                                                ),
                                                const SizedBox(width: 20),
                                                Expanded(
                                                  flex: 5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        dataArtistProvider
                                                            .result[index]
                                                            .trackName!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        dataArtistProvider
                                                            .result[index]
                                                            .artistName!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Text(
                                                        dataArtistProvider
                                                            .result[index]
                                                            .collectionName!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
