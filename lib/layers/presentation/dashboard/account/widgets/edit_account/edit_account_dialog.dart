import 'package:base_project/core/di/injector.dart';
import 'package:base_project/core/state_manager/mobx_manager.dart';
import 'package:base_project/layers/domain/entities/account_info_model.dart';
import 'package:base_project/layers/presentation/common/button/button.dart';
import 'package:base_project/layers/presentation/common/text_input_validator/text_input_validator.dart';
import 'package:base_project/layers/presentation/dashboard/account/widgets/edit_account/edit_account_controller.dart';
import 'package:base_project/layers/presentation/dashboard/account/widgets/permission_group.dart';
import 'package:base_project/layers/presentation/widgets/custom_dropdown/custom_dropdown.dart';
import 'package:base_project/utils/enum/account_role.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_padding.dart';
import 'package:base_project/utils/helpers/app_spacing.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class EditAccountDialog extends MobxStatefulWidget<EditAccountController> {
  final AccountInfoModel accountInfo;
  final void Function() onSave;
  const EditAccountDialog({
    super.key,
    required this.accountInfo,
    required this.onSave,
  });

  @override
  MobxState<MobxStatefulWidget<EditAccountController>, EditAccountController>
      createState() => _EditAccountDialogState();

  @override
  EditAccountController? createController() =>
      EditAccountController(injector(), accountInfo);
}

class _EditAccountDialogState
    extends MobxState<EditAccountDialog, EditAccountController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController email =
        TextEditingController(text: controller.accountInfo?.email);

    return SizedBox(
        height: 365,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Username'),
                    TextInputValidator(
                      hintText: 'Username',
                      style: AppTextStyle.f16R,
                      errorStyle: AppTextStyle.f12R.copyWith(height: 0.4),
                      initialText: controller.accountInfo?.username,
                      enabled: false,
                    ),
                    AppSpacing.h16,
                    const Text('Email'),
                    TextInputValidator(
                      hintText: 'Email',
                      style: AppTextStyle.f16R,
                      errorStyle: AppTextStyle.f12R.copyWith(height: 0.4),
                      controller: email,
                    ),
                    AppSpacing.h16,
                    const Text('Role'),
                    Observer(
                        builder: (context) => CustomDropdown(
                            fitSize: true,
                            fitScreen: true,
                            items: AccountRole.values,
                            selectedItem: controller.accountInfo?.role,
                            onSelected: controller.selectRole,
                            itemBuilder: (item) {
                              return Padding(
                                padding: AppPadding.a8,
                                child: Text(
                                  item.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            })),
                    AppSpacing.h16,
                    ...permissionGroups.map((group) {
                      return PermissionGroup(
                        groupName: group.capitalize(),
                        permissions: allPermissions
                            .where((p) => p.startsWith("$group:"))
                            .toList(),
                        userPermissions:
                            controller.accountInfo?.permission ?? [],
                      );
                    }),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button(
                  backgroundColor: AppColors.midGrey,
                  onPressed: () => context.pop(),
                  child: const Text('Cancel', style: AppTextStyle.f16B),
                ),
                Button(
                    onPressed: () =>
                        controller.editAccount(context, widget.onSave),
                    child: const Text('Edit')),
              ],
            )
          ],
        ));
  }
}
