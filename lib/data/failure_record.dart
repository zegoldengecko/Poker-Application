// Represents a single record of a failed drill attempt
// Weight tracks how many times this particular spot has failed
class FailureRecord {
  int weight;

  FailureRecord({
    required this.weight,
  });
}

