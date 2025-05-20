import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreen extends StatelessWidget {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController anioController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  final TextEditingController generoController = TextEditingController();
  final TextEditingController sinopsisController = TextEditingController();
  final TextEditingController imagenController = TextEditingController();

  void agregarPelicula(BuildContext context) async {
    await FirebaseFirestore.instance.collection('peliculas').add({
      'titulo': tituloController.text,
      'anio': anioController.text,
      'director': directorController.text,
      'genero': generoController.text,
      'sinopsis': sinopsisController.text,
      'imagen': imagenController.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Película agregada')));
  }

  void eliminarPelicula(String id, BuildContext context) async {
    await FirebaseFirestore.instance.collection('peliculas').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Película eliminada')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Administrar Películas")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: tituloController, decoration: InputDecoration(labelText: 'Título')),
            TextField(controller: anioController, decoration: InputDecoration(labelText: 'Año')),
            TextField(controller: directorController, decoration: InputDecoration(labelText: 'Director')),
            TextField(controller: generoController, decoration: InputDecoration(labelText: 'Género')),
            TextField(controller: sinopsisController, decoration: InputDecoration(labelText: 'Sinopsis')),
            TextField(controller: imagenController, decoration: InputDecoration(labelText: 'URL de la imagen')),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => agregarPelicula(context),
              child: Text('Agregar Película'),
            ),
            SizedBox(height: 20),
            Text('Películas existentes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('peliculas').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(doc['titulo']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => eliminarPelicula(doc.id, context),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
