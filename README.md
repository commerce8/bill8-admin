# Bill8:Admin - Flutter App
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](../LICENSE)
[![Built with Rust](https://img.shields.io/badge/Built%20with-Rust-orange.svg)](https://www.rust-lang.org/)
[![Docs](https://img.shields.io/badge/docs/read-3aa757.svg)](https://bill8.dev/docs/services/admin)
[![Website](https://img.shields.io/badge/website-bill8.dev-1a73e8.svg)](https://bill8.dev/docs/products/bill8-admin)

The platform operations dashboard: oversee accounts, review fraud, and
manage platform configuration.

## 1. Summary

Bill8:Admin is the staff-facing Flutter app for the bill8
vertical. It renders the admin/RFW surfaces of the vertical's services
in the platform dashboard, for platform operators.

## 2. Motivation

Platform operators need oversight of connected accounts, fraud reviews,
and platform configuration without touching the merchant surface.

## 3. Architecture & High-Level Design

```mermaid
graph TD
    APP["admin app (Flutter web)"] --> BFF["Sentin8:BFF"]
    BFF -->|"/proxy/risk/*"| R["Bill8:Risk"]
    BFF -->|"/proxy/merchants/*"| M["Bill8:Merchants"]
    BFF -->|"/proxy/reporting/*"| RP["Bill8:Reporting"]
    BFF -->|"/proxy/ledger/*"| L["Bill8:Ledger"]
```

## 4. Key Traits and Data Structures

- `Bff8ApiClient` - shared BFF client.
- Staff-only (SSO) access.

## 5. Rationale, Trade-offs, and Alternatives

- **BFF proxy only**; staff auth via operator SSO.

## 6. Internal Implementation & Invariants

- All calls route through `Bff8ApiClient`; staff-only.

## 7. Unresolved Questions / Future Designs

- See the vertical `backlog.md`.

---

**Architecture & Design:** bill8:admin and its underlying concepts were designed by [Hamid Jahanzad](https://www.linkedin.com/in/hamidjahanzad/).
