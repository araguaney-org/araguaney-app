import 'package:araguaney_app/core/config/app_config.dart';
import 'package:araguaney_app/core/i18n/generated/app_localizations.dart';
import 'package:araguaney_app/features/boxes/ui/box_label_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  test('the QR carries the same address the backend prints', () {
    // If the two labels of the same box led to different places, whoever
    // receives it would see one record and whoever dispatched it another.
    expect(
      BoxLabelView.payloadFor('BX-0001'),
      '${AppConfig.webBaseUrl}/b/BX-0001',
    );
  });

  test('a trailing slash in the configured base does not double up', () {
    expect(BoxLabelView.payloadFor('BX-1').contains('//b/'), isFalse);
  });

  // The test above passes for any base, so it cannot notice a release built
  // against the old host. When the build defines WEB_BASE_URL (CI does, from
  // the repository variable), this pins the canonical host. Without the
  // define it is skipped, because the local default is not the release value.
  const definedBase = String.fromEnvironment('WEB_BASE_URL');
  test(
    'a build with WEB_BASE_URL defined draws the canonical host',
    () {
      expect(
        BoxLabelView.payloadFor('BX-0001'),
        'https://www.araguaney.org/b/BX-0001',
      );
    },
    skip: definedBase.isEmpty
        ? 'WEB_BASE_URL not defined for this build'
        : false,
  );

  testWidgets('the label shows the code and its QR', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BoxLabelView(code: 'BX-0007'),
      ),
    );
    await tester.pumpAndSettle();

    // What gets encoded is checked by the `payloadFor` tests: the widget keeps
    // that value private, so what is verified here is that the label exists and
    // that the code can be read at a glance.
    expect(find.text('BX-0007'), findsWidgets);
    expect(find.byType(QrImageView), findsOneWidget);
  });
}
