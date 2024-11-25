import 'package:base_project/layers/data/response/base_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../request/login_request.dart';
import '../request/register_account_request.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('/auth/login')
  Future<dynamic> login(
    @Body() LoginRequest request,
  );

  @POST('/account/reg')
  Future<dynamic> registerAccount(
    @Body() RegisterAccountRequest request,
  );

  @GET('/account/')
  Future<BaseResponse> getAccountInfo();

  @GET('/user/project')
  Future<BaseResponse> getProjects();

  @GET('/account/list')
  Future<BaseResponse> getAccounts();

  @GET('/scanner')
  Future<BaseResponse> getScanners();

  @GET('/phase/template')
  Future<BaseResponse> getTemplates();

  @GET('/history?total=5')
  Future<BaseResponse> getHistories();

  @GET('/auth/logout')
  Future<BaseResponse> logout();

  @GET('/project/{projectName}')
  Future<BaseResponse> getProjectWithName(
    @Path('projectName') String projectName,
  );

  @GET('/project/{projectName}/member')
  Future<BaseResponse> getProjectMembers(
      @Path('projectName') String projectName);

  @GET('/activity/{projectName}')
  Future<BaseResponse> getProjectActivity(
    @Path('projectName') String projectName,
    @Query('username') String? username,
  );

  @GET('/user')
  Future<BaseResponse> getProjectMemberFromId(
    @Query('memberId') String? memberId,
    @Query('accountId') String? accountId,
  );

  @GET('/workflow')
  Future<BaseResponse> getProjectWorkflowWithName(
    @Query('projectName') String projectName,
  );
}