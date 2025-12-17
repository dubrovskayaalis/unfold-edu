// This is a generated file - do not edit.
//
// Generated from cnc.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use dimensionDescriptor instead')
const Dimension$json = {
  '1': 'Dimension',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 2, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `Dimension`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dimensionDescriptor = $convert.base64Decode(
    'CglEaW1lbnNpb24SEgoEbmFtZRgBIAEoCVIEbmFtZRIUCgV2YWx1ZRgCIAEoAVIFdmFsdWU=');

@$core.Deprecated('Use photoDescriptor instead')
const Photo$json = {
  '1': 'Photo',
  '2': [
    {'1': 'filename', '3': 1, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
    {'1': 'view', '3': 3, '4': 1, '5': 9, '10': 'view'},
  ],
};

/// Descriptor for `Photo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List photoDescriptor = $convert.base64Decode(
    'CgVQaG90bxIaCghmaWxlbmFtZRgBIAEoCVIIZmlsZW5hbWUSEgoEZGF0YRgCIAEoDFIEZGF0YR'
    'ISCgR2aWV3GAMgASgJUgR2aWV3');

@$core.Deprecated('Use uploadPhotosRequestDescriptor instead')
const UploadPhotosRequest$json = {
  '1': 'UploadPhotosRequest',
  '2': [
    {'1': 'project_id', '3': 1, '4': 1, '5': 9, '10': 'projectId'},
    {'1': 'photos', '3': 2, '4': 3, '5': 11, '6': '.cnc.Photo', '10': 'photos'},
    {
      '1': 'dimensions',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.cnc.Dimension',
      '10': 'dimensions'
    },
  ],
};

/// Descriptor for `UploadPhotosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadPhotosRequestDescriptor = $convert.base64Decode(
    'ChNVcGxvYWRQaG90b3NSZXF1ZXN0Eh0KCnByb2plY3RfaWQYASABKAlSCXByb2plY3RJZBIiCg'
    'ZwaG90b3MYAiADKAsyCi5jbmMuUGhvdG9SBnBob3RvcxIuCgpkaW1lbnNpb25zGAMgAygLMg4u'
    'Y25jLkRpbWVuc2lvblIKZGltZW5zaW9ucw==');

@$core.Deprecated('Use uploadPhotosResponseDescriptor instead')
const UploadPhotosResponse$json = {
  '1': 'UploadPhotosResponse',
  '2': [
    {'1': 'job_id', '3': 1, '4': 1, '5': 9, '10': 'jobId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `UploadPhotosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadPhotosResponseDescriptor = $convert.base64Decode(
    'ChRVcGxvYWRQaG90b3NSZXNwb25zZRIVCgZqb2JfaWQYASABKAlSBWpvYklkEhYKBnN0YXR1cx'
    'gCIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use artifactRefDescriptor instead')
const ArtifactRef$json = {
  '1': 'ArtifactRef',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `ArtifactRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List artifactRefDescriptor = $convert.base64Decode(
    'CgtBcnRpZmFjdFJlZhISCgR0eXBlGAEgASgJUgR0eXBlEhAKA3VybBgCIAEoCVIDdXJs');

@$core.Deprecated('Use getArtifactsRequestDescriptor instead')
const GetArtifactsRequest$json = {
  '1': 'GetArtifactsRequest',
  '2': [
    {'1': 'job_id', '3': 1, '4': 1, '5': 9, '10': 'jobId'},
  ],
};

/// Descriptor for `GetArtifactsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getArtifactsRequestDescriptor =
    $convert.base64Decode(
        'ChNHZXRBcnRpZmFjdHNSZXF1ZXN0EhUKBmpvYl9pZBgBIAEoCVIFam9iSWQ=');

@$core.Deprecated('Use getArtifactsResponseDescriptor instead')
const GetArtifactsResponse$json = {
  '1': 'GetArtifactsResponse',
  '2': [
    {
      '1': 'artifacts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.cnc.ArtifactRef',
      '10': 'artifacts'
    },
  ],
};

/// Descriptor for `GetArtifactsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getArtifactsResponseDescriptor = $convert.base64Decode(
    'ChRHZXRBcnRpZmFjdHNSZXNwb25zZRIuCglhcnRpZmFjdHMYASADKAsyEC5jbmMuQXJ0aWZhY3'
    'RSZWZSCWFydGlmYWN0cw==');

@$core.Deprecated('Use modelChunkDescriptor instead')
const ModelChunk$json = {
  '1': 'ModelChunk',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `ModelChunk`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List modelChunkDescriptor =
    $convert.base64Decode('CgpNb2RlbENodW5rEhIKBGRhdGEYASABKAxSBGRhdGE=');
