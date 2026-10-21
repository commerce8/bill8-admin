// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the Bill8:Admin
// SPDX-License-Identifier: Apache-2.0

// Bill8:Admin RFW host page — the remote-admin-UI rendering host.
//
// Zero compile-time knowledge of the services' admin pages: the shell
// navigates to #/{service}/{page} and this page fetches the service's
// RFW definition (GET /v1/admin/ui/{page} through the BFF proxy) and
// renders it via the shared Sentin8RfwPage (architecture-principles
// §4.15 — the platform's remote-UI pattern).

import 'package:flutter/material.dart';
import 'package:sentin8/sentin8.dart';

/// The RFW rendering host for a service admin page.
class RfwHostPage extends StatefulWidget {
  const RfwHostPage({super.key});

  @override
  State<RfwHostPage> createState() => _RfwHostPageState();
}

class _RfwHostPageState extends State<RfwHostPage> {
  String _service = 'payments';
  String _page = 'overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bill8 Admin')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Bill8 services')),
            for (final svc in const [
              'payments',
              'billing',
              'ledger',
              'merchants',
              'webhooks',
              'risk',
              'reporting',
              'checkout',
            ])
              ListTile(
                title: Text(svc),
                selected: svc == _service,
                onTap: () => setState(() {
                  _service = svc;
                  _page = 'overview';
                }),
              ),
          ],
        ),
      ),
      body: Sentin8RfwPage(
        key: ValueKey('$_service/$_page'),
        service: _service,
        page: _page,
        bffClient: BffApiClient(
          bffBaseUrl: _bffBaseUrl(),
          serviceName: _service,
        ),
        onNavigate: (route) =>
            setState(() => _page = route.replaceFirst('/', '')),
      ),
    );
  }

  /// The BFF base URL derives from the app's own origin (the platform
  /// hostname derivation: bff.{app_domain}).
  String _bffBaseUrl() {
    // The runtime context carries the BFF domain in production; the
    // default targets the local dev BFF.
    return 'https://bff.ops.sys.local.sentin8.dev';
  }
}