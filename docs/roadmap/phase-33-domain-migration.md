# Phase 33 — Moving the client to araguaney.org

> The backend moved the product to `araguaney.org` (its Phase 29). The web and
> the API now live there, and `araguaney.lat` redirects. This client still
> points at the old host in every place that matters for a release: the API
> base URL and the web base URL it builds into the QR codes it draws. Both old
> hosts still answer today, so nothing is broken on the server side; the
> client is simply on a host that is being retired.

---

## What the backend already did, and what it asks of this client

| Backend state (2026-10-04) | What it means here |
|---|---|
| `api.araguaney.org` is live behind Cloudflare with the Galileo rules | The client can move to it. Cloudflare injects the secret header, so the client sends nothing new |
| `api.araguaney.lat` is still live, "while the native app uses it" | The client must keep working on `.lat` until a release points at `.org` and old binaries are gated out |
| `araguaney.lat` and `www.araguaney.lat` return 301 to `www.araguaney.org` | Links already printed still resolve, but they are no longer canonical |
| Box QR codes are built from the first entry of the backend's `FRONTEND_URL`, which is `https://www.araguaney.org` (checked 2026-10-05) | The QR the phone draws must use that same host, or a label printed from the app and one printed from the panel lead to different URLs. Until task 1 shipped, they differed |

The backend roadmap's Block E ("native app") lists the same work from the
server's side. Its task 19 retires `api.araguaney.lat` and depends on this
phase's task 4.

## Objectives

1. The release build talks to `api.araguaney.org` and draws QR codes that point
   to `www.araguaney.org`.
2. Old binaries that still call `api.araguaney.lat` are told to update before
   that host is retired, not after.
3. Public addresses the store, the docs and the security policy publish match
   the canonical host.

## Non-objectives

- Retiring `api.araguaney.lat` itself. That is the backend's Phase 29 task 19,
  and it waits until no supported version uses the host.
- Android App Links. The manifest declares no `autoVerify` intent filter, so no
  `assetlinks.json` is needed for this migration. Adding verified links is a
  separate product decision.
- Moving the GitHub organisation or repository. Those are identifiers, not the
  domain, and they are tracked outside this phase.

## Tasks

| # | Task | Description | Complexity | Status |
|---|---|---|---|---|
| 1 | Point the QR base at the canonical host | Set the `WEB_BASE_URL` repository variable to `https://www.araguaney.org`. Done 2026-10-05, after finding the variable still at `.lat` while the backend's `FRONTEND_URL` already led with `.org`. Only builds made from now on draw the new QR; binaries already installed keep `.lat` until they update. Both hosts resolve, so the mismatch was wrong but not broken. | 🟠 Media | ✅ Done |
| 2 | Pin the QR host in release builds | The existing test checks the format (`{base}/b/{code}`) but compares against whatever base was configured, so it passes on any host. A new test pins the canonical host when the build defines `WEB_BASE_URL`, and skips otherwise. CI passes the repository variable to that one file, so a release with the old host fails before it is built. Verified red against `https://araguaney.lat` and green against `https://www.araguaney.org`. | 🟢 Baja | ✅ Done |
| 3 | Switch the API base URL | Set `API_BASE_URL` to `https://api.araguaney.org` in a release build. Verify on a real device: login, a catalogue read, and an offline intake draining its queue. | 🟠 Media | ⬜ Pending |
| 4 | Publish the gate target | Once the build from task 3 is downloadable, ask the backend to raise `MIN_SUPPORTED_CLIENT_VERSION` so older binaries are asked to update. Coordinate with the backend's Phase 29 task 18; do not raise it before the binary exists. | 🟢 Baja | ⬜ Pending |
| 5 | Update the repository's public addresses | `SECURITY.md` (`security@araguaney.org`), `docs/release/android.md` (both variables), `docs/release/store-listing.md` (privacy policy and website). Check that the links to the backend repository still point at the right organisation. | 🟢 Baja | ⬜ Pending |
| 6 | Update the store listing | Play Console: website, contact address and privacy policy URL on the canonical host. Manual step in the console; record it here when done. | 🟢 Baja | ⬜ Pending |
| 7 | Clean test fixtures | Test emails and the `.lat` domain in `test/` are cosmetic. Replace them with `.org` when the files are next touched, not in a dedicated pass. | 🟢 Baja | ⬜ Pending |

## Suggested order

1. Tasks 1 and 2 are done. Task 3 next: its device verification is the only
   thing left in this phase that needs a phone.
3. Task 4 only after the build from task 3 is out.
4. Tasks 5 to 7 in any order; they do not block anything.

## Open question

The client's behaviour after the server move has not been reproduced on a
device. The API still answers on both hosts, and the `.lat` web address
redirects. If something specific fails on a phone, that symptom should be
recorded here before task 3 is scheduled, because it may change the order.

## Done when

- A release built from the repository variables talks to `.org` and draws QR
  codes that point to `www.araguaney.org`.
- The minimum-version gate has been raised after that build was published.
- No file in the repository or the store listing names `araguaney.lat` as the
  address people should use, except where it is named as the redirecting host.
