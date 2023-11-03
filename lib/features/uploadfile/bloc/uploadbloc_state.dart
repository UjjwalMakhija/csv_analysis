part of 'uploadbloc_bloc.dart';

@immutable
sealed class UploadblocState {}
sealed class UploadActionState extends UploadblocState{}
final class UploadblocInitial extends UploadblocState {}
