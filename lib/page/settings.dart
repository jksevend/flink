import 'package:easy_localization/easy_localization.dart';
import 'package:flink/utility/app_locale.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tr('app_settings_title')),
      ),
      body: ListView(
        children: [
          /// Language chooser
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              subtitle: Text(tr('app_settings_change_locale_subtitle')),
              title: DropdownButton<AppLocale>(
                onChanged: (value) {
                  if (value != null) {
                    context.setLocale(value.locale);
                  }
                },
                value: context.locale == const Locale('en', 'US')
                    ? AppLocale.english
                    : AppLocale.german,
                items: AppLocale.values
                    .map(
                      (locale) => DropdownMenuItem(
                    value: locale,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(locale.localeFlag),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(tr(locale.translationKey)),
                      ],
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ),

          /// Licenses
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: Text(tr('app_settings_about_title')),
              subtitle: Text(tr('app_settings_about_subtitle')),
              onTap: () => showAboutDialog(
                context: context,
                applicationVersion: '1.0.0+1',
                applicationName: 'Todo App',
                applicationLegalese: 'Julian Otto',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
