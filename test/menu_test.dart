import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/screen/LocaleProvidelanguage_provider.dart';

void main() {
  test('LanguageProvider returns the correct translation', () {
    final provider = LanguageProvider();

    expect(provider.getTranslation('favorites'),
        'Favorites'); // ตรวจสอบการแปลที่คาดไว้
  });
}
