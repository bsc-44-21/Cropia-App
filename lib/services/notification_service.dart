import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import '../models/field_activity.dart';
import 'weather_service.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz_data.initializeTimeZones();
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
    );
  }

  static Future<void> scheduleTaskNotification({
    required int id,
    required String fieldName,
    required String location,
    required FieldActivity activity,
  }) async {
    final weatherAlerts = WeatherService.getWeeklyAlerts(location);
    // Find alert for the activity date (simplified matching for mock)
    final String dayName = _getDayName(activity.date);
    final alert = weatherAlerts.firstWhere((a) => a.day == dayName, orElse: () => weatherAlerts[0]);

    String weatherMessage = "Time for your farm task!";
    if (alert.type == 'Good') {
      weatherMessage = "☀️ Weather is favorable! Perfect for ${activity.title}.";
    } else if (alert.type == 'Warning') {
      weatherMessage = "⚠️ Alert: Rain/Storm predicted. Delay ${activity.title}?";
    } else {
      weatherMessage = "☁️ Check sky before ${activity.title}. Possible ${alert.alert.toLowerCase()}.";
    }

    // Schedule for 8:00 AM on the activity date
    final scheduledDate = DateTime(
      activity.date.year,
      activity.date.month,
      activity.date.day,
      8, 0,
    );

    if (scheduledDate.isBefore(DateTime.now())) return;

    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: "Task for $fieldName",
      body: weatherMessage,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'field_tasks',
          'Field Tasks',
          channelDescription: 'Reminders for scheduled field activities',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }

  static String _getDayName(DateTime date) {
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}
