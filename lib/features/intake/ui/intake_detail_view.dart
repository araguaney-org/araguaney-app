import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error_mapper.dart';
import '../../../core/api/generated/models/intake_out.dart';
import '../../../core/i18n/l10n_extension.dart';
import '../../../core/ui/record_field.dart';
import '../../../core/ui/status_labels.dart';
import '../../boxes/ui/box_label_view.dart';
import '../data/intake_providers.dart';
import 'intake_list_view.dart';

/// A registered capture, with the boxes it produced.
///
/// Every box leads to its label: an old capture whose box lost its paper is
/// relabelled from here without going through the panel.
///
/// The capture is always asked for by its id, because only that answer carries
/// the boxes. Opened from the history, the listing's copy is shown while the
/// answer arrives, and stays if it never does.
class IntakeDetailView extends ConsumerWidget {
  const IntakeDetailView({super.key, required this.intakeId, this.summary});

  final String intakeId;

  /// What the history already knows, shown until the full capture arrives.
  final IntakeOut? summary;

  static Route<void> route(IntakeOut intake) => MaterialPageRoute<void>(
    builder: (_) => IntakeDetailView(intakeId: intake.id, summary: intake),
  );

  static Route<void> routeById(String intakeId) => MaterialPageRoute<void>(
    builder: (_) => IntakeDetailView(intakeId: intakeId),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(intakeDetailProvider(intakeId));
    final intake = detail.valueOrNull ?? summary;

    if (intake == null) {
      return Scaffold(
        appBar: AppBar(),
        body: switch (detail) {
          AsyncError(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                ApiErrorMapper.fromAny(error).operatorMessage(context.l10n),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      );
    }

    return _Record(
      intake: intake,
      boxesMissing: detail.hasError && intake.boxes.isEmpty,
      loading: detail.isLoading,
    );
  }
}

class _Record extends StatelessWidget {
  const _Record({
    required this.intake,
    required this.boxesMissing,
    required this.loading,
  });

  final IntakeOut intake;
  final bool boxesMissing;
  final bool loading;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(formatShortDate(intake.createdAt))),
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        RecordField(
          label: context.l10n.donorLabel,
          value: donorLabel(intake) ?? context.l10n.donorAnonymous,
        ),
        if (intake.notes case final notes?)
          RecordField(label: context.l10n.notesLabel, value: notes),
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            context.l10n.boxesTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        // The listing does not fill the boxes in, and the question that does
        // can fail without signal. Then it is said, rather than showing an
        // empty section, which would read as «this capture had no boxes».
        if (loading && intake.boxes.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (boxesMissing)
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(context.l10n.captureBoxesNotInHistory),
          ),
        for (final box in intake.boxes)
          ListTile(
            title: Text(box.code),
            subtitle: Text(
              '${box.quantity} ${box.unit} · ${boxStatusLabel(context.l10n, box.status)}',
            ),
            trailing: const Icon(Icons.qr_code_2),
            onTap: () =>
                Navigator.of(context).push(BoxLabelView.route(box.code)),
          ),
      ],
    ),
  );
}
