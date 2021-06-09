import 'package:firebasestarter/constants/assets.dart';
import 'package:firebasestarter/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:firebasestarter/widgets/team/employees_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Employees list text', (WidgetTester tester) async {
    const employee1 = Employee(
      id: 'testID',
      firstName: 'testName',
      lastName: 'testLastName',
      email: 'testEmail',
      avatarAsset: Assets.anonUser,
      age: 20,
      phoneNumber: '098123456',
      address: 'testAddress',
      description: 'testDescription',
    );

    const employee2 = Employee(
      id: 'testID2',
      firstName: 'testName2',
      lastName: 'testLastName2',
      email: 'testEmail2',
      avatarAsset: Assets.anonUser,
      age: 20,
      phoneNumber: '098123452',
      address: 'testAddress2',
      description: 'testDescription2',
    );

    final employees = [employee1, employee2];

    await tester.pumpWidget(MaterialApp(home: EmployeesList(employees)));

    await tester.pump();
    expect(find.text('testName testLastName'), findsOneWidget);
    expect(find.text('testName2 testLastName2'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}
