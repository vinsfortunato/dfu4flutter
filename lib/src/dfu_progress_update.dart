/// Represents a progress update for a DFU operation.
class DfuProgressUpdate {
  DfuProgressUpdate({
    required this.step,
    required this.stepName,
    required this.stepMessage,
    required this.stepProgress,
    required this.totalSteps,
  });

  /// The current step of the operation, starting from 0.
  int step;

  /// The name of the current step.
  ///
  /// This is a string that describes the current operation.
  String stepName;

  /// A message that describes the current step.
  ///
  /// This is a string that provides additional information about the current operation.
  String stepMessage;

  /// The progress of the current step.
  ///
  /// A double between 0 and 1 or a value less than 0
  /// if the progress is indeterminate.
  double stepProgress;

  /// The total number of steps in the operation.
  ///
  /// -1 if the total number of steps is unknown.
  int totalSteps;

  DfuProgressUpdate copyWith({
    int? step,
    String? stepName,
    String? stepMessage,
    double? stepProgress,
    int? totalSteps,
  }) {
    return DfuProgressUpdate(
      step: step ?? this.step,
      stepName: stepName ?? this.stepName,
      stepMessage: stepMessage ?? this.stepMessage,
      stepProgress: stepProgress ?? this.stepProgress,
      totalSteps: totalSteps ?? this.totalSteps,
    );
  }

  @override
  String toString() {
    return 'DfuProgressUpdate{'
        'step: $step, '
        'stepName: $stepName, '
        'stepProgress: $stepProgress, '
        'totalSteps: $totalSteps'
        '}';
  }
}
