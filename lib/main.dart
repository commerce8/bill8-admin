// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the Bill8:Admin
// SPDX-License-Identifier: Apache-2.0

// Bill8:Admin — main entry point.
//
// The platform administration surface over Bill8 services. Each
// service publishes its admin UI as remote-UI definitions
// (GET /v1/admin/ui/{page}); this app is the rendering host with zero
// compile-time knowledge of the admin pages (the RFW pattern —
// architecture-principles §4.15).

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:sentin8/sentin8.dart';
import 'pages/rfw_host_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Semantics for e2e/Playwright ARIA access.
  SemanticsBinding.instance.ensureSemantics();
  runApp(const AdminApp());
}

/// Root widget — the RFW rendering host.
class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill8 Admin',
      debugShowCheckedModeBanner: false,
      theme: sentin8Theme(),
      home: const RfwHostPage(),
    );
  }
}