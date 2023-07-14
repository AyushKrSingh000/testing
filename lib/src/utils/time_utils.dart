import 'package:intl/intl.dart';

prettyTimestamp(DateTime? timestamp) {
  if (timestamp == null) return 'To Be Announced Soon';

  final formattedDate = DateFormat('LLLL d').format(timestamp);
  final formattedTime = DateFormat('jm').format(timestamp);

  return '$formattedTime, $formattedDate';
}
