class ApiResponse<T> implements Exception {
  final int? code;
  final String? message;
  final T? data;

  ApiResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        data = json['data'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }

  @override
  String toString() {
    return 'ApiResponse{code: $code, message: $message, data: $data}';
  }
}
