import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ShadApp.custom(
      appBuilder: (context, theme) => GetMaterialApp(
        theme: theme,
        initialRoute: '/home',
        getPages: [
          GetPage(name: '/home', page: () => Home()),
        ],
      ),
    );
  }
}

const frameworks = {
  'next': 'Next.js',
  'react': 'React',
  'astro': 'Astro',
  'nuxt': 'Nuxt.js',
};

class Home extends StatelessWidget {
  Home({super.key});
  var count = 0.obs;

  @override
  Widget build(context) {
    final theme = ShadTheme.of(context);
    return Scaffold(
      body: ShadCard(
        width: 350,
        title: Text('Create project', style: theme.textTheme.h4),
        description: const Text('Deploy your new project in one-click.'),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShadButton.outline(
              child: const Text('Cancel'),
              onPressed: () {},
            ),
            ShadButton(
              child: const Text('Deploy'),
              onPressed: () {},
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // const Text('Name'),
              Text("hi"),
              const ShadInput(placeholder: Text('Name of your project')),
              const SizedBox(height: 6),
              // const Text('Framework'),
              ShadSelect<String>(
                placeholder: const Text('Select'),
                options: frameworks.entries
                    .map((e) => ShadOption(value: e.key, child: Text(e.value)))
                    .toList(),
                selectedOptionBuilder: (context, value) {
                  return Text(frameworks[value]!);
                },
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
