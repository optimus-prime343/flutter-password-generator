final List<String> lowerCasedLetters =
    'abcdefghijklmnopqrstuvwxyz'.split('').toList();
final List<String> upperCasedLetters =
    lowerCasedLetters.map((letter) => letter.toUpperCase()).toList();

final List<String> letters = [...lowerCasedLetters, ...upperCasedLetters]
  ..shuffle();
final List<String> numbers = List.generate(10, (index) => index.toString())
  ..shuffle();
final List<String> symbols = [
  "!",
  "”",
  "#",
  "%",
  "\$",
  "&",
  "'",
  "(",
  ")",
  "*",
  "+",
  "-",
  ".",
  "/",
  ";",
  "<",
  "=",
  ">",
  "?",
];
String generatePassword({
  required int length,
  required bool includeNumbers,
  required bool includeLetters,
  required bool includeSymbols,
}) {
  List<String> selectedCharacters = [];
  if (includeLetters) selectedCharacters.addAll([...letters]);
  if (includeNumbers) selectedCharacters.addAll([...numbers]);
  if (includeSymbols) selectedCharacters.addAll([...symbols]);

  List<String> shuffledSelectedCharacters = selectedCharacters..shuffle();
  if (shuffledSelectedCharacters.isEmpty) {
    return letters.take(length).join();
  }
  return shuffledSelectedCharacters.take(length).join();
}
