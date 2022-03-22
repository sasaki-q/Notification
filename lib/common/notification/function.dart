import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification/common/global_context.dart';
import 'package:notification/common/notification/plugin.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> showMyNotification() async {
  await localPlugin.initialize(
    initSettings,
    onSelectNotification: pushPage,
  );
  localPlugin.show(
    100, 
    "local notification title", 
    "local notification body", 
    const NotificationDetails(),
    payload: "/next"
  );
}

Future<void> showMyScheduledNotification() async {
  tz.initializeTimeZones();
  await localPlugin.initialize(
    initSettings,
    onSelectNotification: pushPage,
  );
  localPlugin.zonedSchedule(
    100, 
    "show schedule notification title", 
    "show schedule notification body", 
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    const NotificationDetails(), 
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, 
    androidAllowWhileIdle: true,
    payload: "/next"
  );
}

void pushPage(String? payload) {
  Navigator.of(globalCtx).pushNamed(payload!);
}