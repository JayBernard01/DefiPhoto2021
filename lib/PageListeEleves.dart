import 'package:flutter/material.dart';
import 'PageCreationProfil.dart';
import 'Services.dart';
import 'Utilisateur.dart';
import 'PageProfil.dart';
import 'PageProgression.dart';

class PageListeEleves extends StatefulWidget {
  PageListeEleves(this.utilisateur);
  final Utilisateur utilisateur;

  @override
  _PageListeEleves createState() => _PageListeEleves(utilisateur);
}

class _PageListeEleves extends State<PageListeEleves> {
  _PageListeEleves(this.utilisateur);

  final Utilisateur utilisateur;
  List<Utilisateur> liste = List<Utilisateur>.empty(growable: true);

  void initState() {
    ajouterEtudiant();
    super.initState();
  }

  ajouterEtudiant() {
    Services.getUtilisateursListe().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              if (value[i].id_prof == utilisateur.id)
                {
                  setState(() {
                    liste.add(value[i]);
                  })
                }
            }
        });
  }

  naviguerProfileEtudiant(Utilisateur etudiant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageProfil(etudiant)),
    );
  }

  naviguerProgresEtudiant(Utilisateur etudiant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageProgression(etudiant)),
    );
  }

  List<Widget> creerCarte() {
    List<Widget> listeWidget = List<Widget>.empty(growable: true);
    if (liste != null) {
      for (int i = 0; i < liste.length; i++) {
        listeWidget.add(Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                        text: TextSpan(
                            text: (liste[i].prenom + ' ' + liste[i].nom),
                            style: TextStyle(fontSize: 24),
                            children: [
                          TextSpan(
                              text: ("#" + liste[i].id),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey))
                        ])),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () => naviguerProfileEtudiant(liste[i])),
                    IconButton(
                        icon: Icon(Icons.bar_chart),
                        onPressed: () => naviguerProgresEtudiant(liste[i]))
                  ],
                )
              ],
            ),
          ),
        ));
      }
    }
    listeWidget.add(SizedBox(
      height: 100,
    ));
    return listeWidget;
  }

  naviguerCreationUtilsateur(Utilisateur etudiant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageCreationProfile(etudiant)),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => naviguerCreationUtilsateur(utilisateur),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Liste des élèves"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: creerCarte(),
        ),
      ),
    );
  }
}
