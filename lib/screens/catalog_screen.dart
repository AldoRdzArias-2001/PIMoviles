import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Catálogo de Películas")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('peliculas').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final peliculas = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: peliculas.length,
                  itemBuilder: (context, index) {
                    var pelicula = peliculas[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(pelicula['imagen'], width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(pelicula['titulo']),
                        onTap: () {
                          Navigator.pushNamed(context, '/detail', arguments: pelicula);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/admin'),
              icon: Icon(Icons.admin_panel_settings),
              label: Text('Ir a administración'),
            ),
          ),
        ],
      ),
    );
  }
}