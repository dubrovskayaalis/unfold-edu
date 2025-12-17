// This is a generated file - do not edit.
//
// Generated from cnc.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'cnc.pb.dart' as $0;

export 'cnc.pb.dart';

@$pb.GrpcServiceName('cnc.Gateway')
class GatewayClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  GatewayClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.UploadPhotosResponse> uploadPhotos(
    $0.UploadPhotosRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$uploadPhotos, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetArtifactsResponse> getArtifacts(
    $0.GetArtifactsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getArtifacts, request, options: options);
  }

  $grpc.ResponseFuture<$0.UploadPhotosResponse> modelToUnfold(
    $async.Stream<$0.ModelChunk> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$modelToUnfold, request, options: options)
        .single;
  }

  // method descriptors

  static final _$uploadPhotos =
      $grpc.ClientMethod<$0.UploadPhotosRequest, $0.UploadPhotosResponse>(
          '/cnc.Gateway/UploadPhotos',
          ($0.UploadPhotosRequest value) => value.writeToBuffer(),
          $0.UploadPhotosResponse.fromBuffer);
  static final _$getArtifacts =
      $grpc.ClientMethod<$0.GetArtifactsRequest, $0.GetArtifactsResponse>(
          '/cnc.Gateway/GetArtifacts',
          ($0.GetArtifactsRequest value) => value.writeToBuffer(),
          $0.GetArtifactsResponse.fromBuffer);
  static final _$modelToUnfold =
      $grpc.ClientMethod<$0.ModelChunk, $0.UploadPhotosResponse>(
          '/cnc.Gateway/ModelToUnfold',
          ($0.ModelChunk value) => value.writeToBuffer(),
          $0.UploadPhotosResponse.fromBuffer);
}

@$pb.GrpcServiceName('cnc.Gateway')
abstract class GatewayServiceBase extends $grpc.Service {
  $core.String get $name => 'cnc.Gateway';

  GatewayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.UploadPhotosRequest, $0.UploadPhotosResponse>(
            'UploadPhotos',
            uploadPhotos_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UploadPhotosRequest.fromBuffer(value),
            ($0.UploadPhotosResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetArtifactsRequest, $0.GetArtifactsResponse>(
            'GetArtifacts',
            getArtifacts_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetArtifactsRequest.fromBuffer(value),
            ($0.GetArtifactsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ModelChunk, $0.UploadPhotosResponse>(
        'ModelToUnfold',
        modelToUnfold,
        true,
        false,
        ($core.List<$core.int> value) => $0.ModelChunk.fromBuffer(value),
        ($0.UploadPhotosResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.UploadPhotosResponse> uploadPhotos_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UploadPhotosRequest> $request) async {
    return uploadPhotos($call, await $request);
  }

  $async.Future<$0.UploadPhotosResponse> uploadPhotos(
      $grpc.ServiceCall call, $0.UploadPhotosRequest request);

  $async.Future<$0.GetArtifactsResponse> getArtifacts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetArtifactsRequest> $request) async {
    return getArtifacts($call, await $request);
  }

  $async.Future<$0.GetArtifactsResponse> getArtifacts(
      $grpc.ServiceCall call, $0.GetArtifactsRequest request);

  $async.Future<$0.UploadPhotosResponse> modelToUnfold(
      $grpc.ServiceCall call, $async.Stream<$0.ModelChunk> request);
}
