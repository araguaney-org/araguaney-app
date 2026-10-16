# Phase 34 — Catching up with the contract

> The vendored snapshot in `api/openapi.json` dates from 2026-08-20. On
> 2026-09-03 the backend closed six of the requests in
> [`backend-requests.md`](../backend-requests.md) in a single change (its PR
> #299), and this repository never noticed: the snapshot was not refreshed, so
> the generated client does not know the new fields and routes, and the
> workarounds written while those requests were open are all still running.
> Nothing is broken — every change was additive — but the application keeps
> paying for gaps that no longer exist.

---

## What the deployed contract adds

Compared on 2026-10-16 against `https://api.araguaney.org/openapi.json`, which
serves the same document as the `.lat` host.

| Change | Closes | Here, today |
|---|---|---|
| `GET /v1/intakes/{intake_id}` | Request 2 | A risk review notice lands on the review list, one step away from the capture |
| `from_center_name` / `to_center_name` on `TransferOut` and `TransferDetailOut` | Request 3 | Transfers show only the direction, never the other centre |
| `PalletAddBoxIn` as the body of `POST /v1/pallets/{id}/add-box` | Request 4 | `pallets_repository.dart` writes `{'code': …}` by hand |
| `role`, `center_role`, `center_id` on `POST /v1/auth/refresh` | Request 7 | `session_controller.dart` asks `GET /v1/auth/me` when `center_role` is missing — which for a national administrator, who has no centre role, is every restore |
| `status` filter on `GET /v1/reports/campaign/{id}/by-category` | Request 1, reading half | The screen reads «captured in window»; `status=SEALED` reads it as stock |
| `NOT_CAMPAIGN_MEMBER` from the thread service | Request 6, partly | Already handled by `refusal_copy.dart`; nothing to change. `NOT_THREAD_PARTICIPANT` does not exist yet |

The rest of the difference is outside this phase: product aliases, catalogue
mapping choices, reading a label from a photo (`POST /v1/intakes/read-label`),
centre time zones, and the weight fields losing the regular expression Pydantic
used to publish for decimals. The last is a serializer change, not a type
change — the fields are strings and numbers before and after.

**Requests still open after this phase:** 6 (`NOT_THREAD_PARTICIPANT`), 9, 10,
11, 12 and 13. Phase 23 task 5 stays blocked on request 11, and Phase 24 task 2
stays partial on request 12.

## Objectives

1. The vendored snapshot matches the deployed contract, and the generated
   client is regenerated from it.
2. Every workaround written for a request the backend has since closed is
   removed, not left running beside the real answer.
3. `backend-requests.md` says which requests are closed and when.

## Non-objectives

- Adopting the routes nobody asked for (aliases, label reading, time zones).
  They arrive in the generated client and wait for a phase that wants them.
- Pointing the application at `api.araguaney.org`. That is Phase 33 task 3, and
  it travels in the same release.

## Tasks

| # | Task | Description | Complexity | Status |
|---|---|---|---|---|
| 1 | Refresh the snapshot | Fetch from the deployed API, store it sorted, regenerate the client, in its own commit as `api/README.md` describes. | 🟢 Low | ✅ Done |
| 2 | Identity from the refresh response | Ask `GET /v1/auth/me` only when the token carries no `role`, not when it carries no `center_role`. Keep the fallback: a server that answers without identity is still handled, and the session still opens with less rather than more. | 🟢 Low | ✅ Done |
| 3 | Typed `add-box` | Send `PalletAddBoxIn` through the generated client instead of the hand-written map. The test that pinned the key stays: it now checks what the generated model puts on the wire. | 🟢 Low | ✅ Done |
| 4 | Name the other centre in a transfer | Show `from_center_name` / `to_center_name` on the list and the record, falling back to the direction when the server sends no name. | 🟢 Low | ✅ Done |
| 5 | Open the capture from a risk review | The notice and the review open the capture through `GET /v1/intakes/{id}`. Check whether the detail carries the boxes before removing the «the history does not carry the boxes» note from the record. | 🟠 Medium | ⬜ Pending |
| 6 | Stock on hand by category | Read the by-category report with `status=SEALED` where the screen means stock, and say so in the title. | 🟢 Low | ⬜ Pending |
| 7 | Close the requests | Mark requests 1, 2, 3, 4 and 7 resolved in `backend-requests.md` and request 6 partly resolved; update the parity count. | 🟢 Low | ⬜ Pending |
| 8 | Verify on a device | Restore a session as a national administrator and as a coordinator, follow a risk review notice to its capture, and read a transfer from both centres. | 🟢 Low | ⬜ Pending |

## Suggested order

Task 1 first: every other task needs the regenerated client. Tasks 2 to 6 are
independent of each other. Task 7 closes the code work; task 8 goes with the
Phase 33 task 3 device pass, since both need the same release build.

## Done when

- `api/openapi.json` matches the deployed contract, and CI's `api-client` job
  passes on it.
- No code path in the application works around a request that is marked
  resolved.
