fromMillisecondsSinceEpochToDateTime(int? value) =>
    DateTime.fromMillisecondsSinceEpoch(value ?? 00000000);

double calculateProfitOrLossValue(double points) =>
    100 * (points - 1000) / 1000;
