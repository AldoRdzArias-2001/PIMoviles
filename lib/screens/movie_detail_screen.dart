import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot pelicula = ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;

    return Scaffold(
      appBar: AppBar(title: Text(pelicula['titulo'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(pelicula['imagen'], height: 200),
            ),
            SizedBox(height: 20),
            Text('Año: ${pelicula['anio']}', style: TextStyle(fontSize: 16)),
            Text('Director: ${pelicula['director']}', style: TextStyle(fontSize: 16)),
            Text('Género: ${pelicula['genero']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Sinopsis:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(pelicula['sinopsis'], style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}