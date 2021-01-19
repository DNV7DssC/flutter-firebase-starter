import 'package:flutter/material.dart';
import 'package:flutterBoilerplate/bloc/employees/employees_bloc.dart';
import 'package:flutterBoilerplate/bloc/employees/employees_event.dart';
import 'package:flutterBoilerplate/bloc/employees/employees_state.dart';
import 'package:flutterBoilerplate/constants/strings.dart';
import 'package:flutterBoilerplate/utils/dialog.dart';
import 'package:flutterBoilerplate/widgets/employee_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  EmployeesBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = BlocProvider.of<EmployeesBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer(
        cubit: _bloc,
        listener: (context, state) {
          if (state.runtimeType == EmployeeCreated) {
            return DialogHelper.showAlertDialog(
              context: context,
              story: AppString.employeeAddedSuccessfully,
              btnText: AppString.ok,
              btnAction: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          } else if (state.runtimeType == Error) {
            return DialogHelper.showAlertDialog(
              context: context,
              story: (state as Error).message,
              btnText: AppString.ok,
              btnAction: () => Navigator.pop(context),
            );
          }
        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: state.runtimeType == Loading,
          child: Scaffold(
            backgroundColor: Colors.teal,
            appBar: AppBar(
              title: const Text(AppString.addNewEmployee),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmployeeForm(
                  bloc: _bloc,
                  editEmployee: false,
                  execute: () => _bloc.add(const CreateEmployee()),
                ),
              ),
            ),
          ),
        ),
      );
  @override
  void dispose() {
    _bloc.add(const GetEmployees(null));
    super.dispose();
  }
}
