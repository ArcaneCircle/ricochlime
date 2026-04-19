import 'dart:js_interop';

@JS('highscores')
external HighscoresApi get highscores;

@JS()
extension type HighscoresApi._(JSObject _) implements JSObject {
  external int getScore();
  external void setScore(int score);
}
