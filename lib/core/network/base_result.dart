class Result<T> {
  final String? error;
  final T? data;
  final bool? success;

  Result.success(this.data)
      : success = true,
        error = null;
  Result.failure(this.error)
      : success = false,
        data = null;
}
