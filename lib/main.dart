import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

void main() {
  runApp(const ConceptApp());
}

class ConceptApp extends StatefulWidget {
  const ConceptApp({super.key});

  @override
  State<ConceptApp> createState() => _ConceptAppState();
}

class _ConceptAppState extends State<ConceptApp> {
  bool isDarkMode = false;
  bool mostrarDart = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conceptes de Dart',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: ConceptListPage(
        isDarkMode: isDarkMode,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
        mostrarDart: mostrarDart,
        onToggleDartJava: (val) => setState(() => mostrarDart = val),
      ),
    );
  }
}

class ConceptListPage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final bool mostrarDart;
  final ValueChanged<bool> onToggleDartJava;

  const ConceptListPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.mostrarDart,
    required this.onToggleDartJava,
  });

  final List<Map<String, dynamic>> concepts = const [
    {
      'title': 'library en comptes de package',
      'description':
          'En Dart, "library" s’utilitza per agrupar codi dins d’un mateix projecte. En canvi, un "package" és una col·lecció de llibreries que poden compartir-se o instal·lar-se des de pub.dev.',
      'dart': "library my_library;\n\nvoid greet() {\n  print('Hola!');\n}",
      'java': "// Java no té library\nclass MyLibrary {\n  static void greet() { System.out.println(\"Hola!\"); }\n}"
    },
    {
      'title': 'Inferència de tipus',
      'description':
          'Dart pot deduir automàticament el tipus d’una variable segons el valor que se li assigna.',
      'dart': "var x = 10; // x és int\ndynamic y = 'Hola';",
      'java': "int x = 10;\nString y = \"Hola\";"
    },
    {
      'title': 'Funcions fora de classes',
      'description':
          'En Dart, les funcions no han d’estar dins de classes. Pots definir funcions globals.',
      'dart': "int suma(a, b) => a + b;\nprint(suma(3, 4));",
      'java': "int suma(int a, int b) { return a + b; }\nSystem.out.println(suma(3,4));"
    },
    {
      'title': 'Constructors sense claus',
      'description': 'En Dart, no cal usar la paraula clau "new" per crear objectes.',
      'dart': "var p = Persona('Joan', 25);",
      'java': "Persona p = new Persona(\"Joan\", 25);"
    },
    {
      'title': 'const al retorn de les funcions',
      'description': 'Pots retornar valors constants d’una funció amb const.',
      'dart': "const int getFive() => 5;",
      'java': "final int getFive() { return 5; }"
    },
    {
      'title': 'Paràmetres amb valors per defecte',
      'description': 'Es poden definir valors per defecte als paràmetres.',
      'dart': "void greet(String name = 'Amic') {\n  print('Hola \$name');\n}",
      'java': "// Java no permet valors per defecte directament\nvoid greet(String name) {\n  if(name == null) name = \"Amic\";\n  System.out.println(\"Hola \" + name);\n}"
    },
    {
      'title': 'Paràmetres desordenats amb nom (named params)',
      'description': 'Permet passar paràmetres amb nom a la crida.',
      'dart': "void greet({String name = 'Amic'}) {\n  print('Hola \$name');\n}\ngreet(name: 'Joan');",
      'java': "// Java no suporta named params\nvoid greet(String name) {\n  System.out.println(\"Hola \" + name);\n}\ngreet(\"Joan\");"
    },
    {
      'title': 'Paràmetres opcionals',
      'description': 'Paràmetres opcionals poden ser amb {} (named) o [] (posicionals)',
      'dart': "void greet([String name = 'Amic']) {\n  print('Hola \$name');\n}",
      'java': "// Java no suporta optional params\nvoid greet(String name) {\n  if(name == null) name = \"Amic\";\n  System.out.println(\"Hola \" + name);\n}"
    },
    {
      'title': 'Paràmetres de tipus funció',
      'description': 'Pots passar funcions com a paràmetres.',
      'dart': "void execute(Function callback) {\n  callback();\n}\nexecute(() => print('Hola'));",
      'java': "void execute(Runnable callback) {\n  callback.run();\n}\nexecute(() -> System.out.println(\"Hola\"));"
    },
    {
      'title': 'Named constructors',
      'description': 'Constructors amb nom addicional dins d’una classe.',
      'dart': "class Persona {\n  String nom;\n  Persona(this.nom);\n  Persona.fromJson(Map json) : nom = json['nom'];\n}",
      'java': "class Persona {\n  String nom;\n  Persona(String nom) { this.nom = nom; }\n  static Persona fromJson(Map<String,String> json) { return new Persona(json.get(\"nom\")); }\n}"
    },
    {
      'title': 'Guió baix implica classe privada',
      'description': 'A Dart, un nom amb _ és privat dins del mateix library.',
      'dart': "class _PersonaPrivada {\n  String nom;\n  _PersonaPrivada(this.nom);\n}",
      'java': "// Java no suporta _privat de la mateixa manera\nclass PersonaPrivada {\n  String nom;\n  PersonaPrivada(String nom) { this.nom = nom; }\n}"
    },
    {
      'title': 'const per millorar el rendiment',
      'description': 'Els objectes const s’inicien en temps de compilació.',
      'dart': "const pi = 3.14;",
      'java': "final double pi = 3.14;"
    },
    {
      'title': 'Inicialització amb :',
      'description': 'Els constructors poden inicialitzar atributs amb : després del constructor.',
      'dart': "class Point {\n  final int x;\n  final int y;\n  Point(this.x, this.y);\n  Point.origin() : x = 0, y = 0;\n}",
      'java': "class Point {\n  final int x;\n  final int y;\n  Point(int x, int y) { this.x = x; this.y = y; }\n  Point() { x = 0; y = 0; }\n}"
    },
    {
      'title': 'Constructors sense codi si inicialitzen paràmetres bàsics',
      'description': 'Si només assigns valors als atributs, el constructor pot ser curt.',
      'dart': "class Persona {\n  String nom;\n  int edat;\n  Persona(this.nom, this.edat);\n}",
      'java': "class Persona {\n  String nom;\n  int edat;\n  Persona(String nom, int edat) { this.nom = nom; this.edat = edat; }\n}"
    },
    {
      'title': 'Declaració de lambdes',
      'description': 'Exemple de tipus d’una lambda amb paràmetres i retorn.',
      'dart': "String Function(int,int) suma = (a, b) => 'Resultat: \${a + b}';",
      'java': "BiFunction<Integer,Integer,String> suma = (a,b) -> \"Resultat: \" + (a+b);"
    },
    {
      'title': 'Pas de lambdes',
      'description': 'Passar una lambda directament com a argument.',
      'dart': "void execute(Function(int,int) f) {\n  print(f(3,4));\n}\nexecute((a,b) => a+b);",
      'java': "void execute(BiFunction<Integer,Integer,Integer> f) {\n  System.out.println(f.apply(3,4));\n}\nexecute((a,b) -> a+b);"
    },
    {
      'title': 'Genèrics',
      'description': 'Els genèrics poden aplicar-se al tipus de retorn o al paràmetre.',
      'dart': "T identity<T>(T value) => value;\nvar x = identity<int>(10);",
      'java': "<T> T identity(T value) { return value; }\nint x = identity(10);"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final highlightTheme = isDarkMode ? monokaiSublimeTheme : githubTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conceptes de Dart'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: isDarkMode ? 'Modo Claro' : 'Modo Oscuro',
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Dart'),
                  selected: mostrarDart,
                  onSelected: (_) => onToggleDartJava(true),
                ),
                const SizedBox(width: 12),
                ChoiceChip(
                  label: const Text('Java'),
                  selected: !mostrarDart,
                  onSelected: (_) => onToggleDartJava(false),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: concepts.length,
                itemBuilder: (context, index) {
                  final concept = concepts[index];
                  final codigoActual =
                      mostrarDart ? concept['dart'] ?? '' : concept['java'] ?? '';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.all(16),
                          title: Text(
                            concept['title'] ?? '',
                            style: theme.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          childrenPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          children: [
                            Text(
                              concept['description'] ?? '',
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.copy, size: 18),
                                  label: const Text('Copiar'),
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: codigoActual));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Codi copiat al portapapers!'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    isDarkMode ? Colors.grey[900] : Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(12.0),
                                child: HighlightView(
                                  codigoActual,
                                  language: mostrarDart ? 'dart' : 'java',
                                  theme: highlightTheme,
                                  textStyle: const TextStyle(
                                    fontFamily: 'SourceCodePro',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
