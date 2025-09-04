Return-Path: <linux-kernel+bounces-801643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCEFB4484C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDAD1C84399
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E96129B216;
	Thu,  4 Sep 2025 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yySFxCNx"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC329E112
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020444; cv=none; b=UlCQNZbnmfNXkZpN/a4yomAbZuMJWg4LAr4CIm/7xnUBL0VTMx3B2zpo2T6bwOKZV0sCg2hA6YnSJ56W2dERIFCKEfDBo8Ln51tITxvCiQaA3Ba6ity5TKOh3f+qVxIacsiOHEZztJZmuL3G+HJp2vgFz4m/n/M8FvU4AkvCh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020444; c=relaxed/simple;
	bh=pG7w/3JHU8axFyAFdX9e0nFyT0oX71h+TjUDTVFGEkA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lHCTLgLaymwVNVbKOqWEBO8R99Sk/Fo2Su0/zSU2I6ck9mdvcEpepQXnm/8MhCvpl6KyspwQdR5JpvELyT1KAB3AvsIEv0CpHGi1ANTZIQy/2PsWZtz+S6mT7MzJxkDqDxTbksVYatEk4LieN3fdhm/fJeaSqv96lKVf9/MS8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yySFxCNx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24cba71c71fso11920635ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757020442; x=1757625242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TJYwU2yPPd0EE6hrwXyI4Ct3oTbe0VrmrCjZwMAZaNg=;
        b=yySFxCNxmQLXdjX5N+KevTH6sm6opxbc+g/MnGH8PNyHlbgYlMHh0aiJsG0CwP3TeB
         MMhsx4abUSTmiH7xlbr1O6RGSECYXizEs4gVoVdu7D39TJNjEvkw0Nq6B9/aA5kVE0/X
         5u15/2NDwlUBxKfTLIQ+chiFj0J4qPpfi7rYha0L1dKne/KT/8C7M30weZ4LRDNRLIi0
         MEbw3gBvBAVPzac6vnThbttjUird9F1Ya0Ww+zCStHUiYvDE9GEkFomHz8RIi1fMfDf6
         YUCaO9PKaUeR6WpnsHX9M5MeRpdH64KQ7qbI7lcvga6LDMBaVpHokTi9KKr3hIg68qLB
         CvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020442; x=1757625242;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJYwU2yPPd0EE6hrwXyI4Ct3oTbe0VrmrCjZwMAZaNg=;
        b=ijLISrmdcYHs5u9p9RHRLyTZg9VBOP6DKoNimjFSPfwPgrEPvyw7VDPgYb00bkxQMM
         mVRd77vVii5Y/LFHquvkDufjnr7X9fbgvpIYHhCVjgFPQdRXCgmsxflJSqFbEZSzS/IF
         Y2ammY1T/kWUv74b0K7mOaPkS8S6LDLNd5L5hgPFdocoDRIOs9b9EWETr5mX/v/YMs0b
         5itfrqQrjGZOnAstMJRs4fBzQxkeyOr1A0/NcrR5mReCmSKoEnxpRPnSbadfF4B1Tzjg
         kJykaifjggFf1EXO5fgScEou72RrgbM24ALjaGVgYi6XY39b/DeZlEKjU5aXp8V57jJb
         ogKQ==
X-Gm-Message-State: AOJu0YyF9nAZxhuszsQk6lTd01NN+E3DCa846fC3lD/GiRkRaBVdwbDZ
	gkbxI8kndETLS5WvCH00OOEVfZeEGlLqLBgWOFECnL0xgptWV0w2UuKszdel+1jfwM3K7unWD9+
	HSWtMiSBhqw==
X-Google-Smtp-Source: AGHT+IFnOCNhfUC3rzOF/0ujJoDz5JXVR+P5i65FDIYEF3jrwCYtHQJHtt2dKcmSkcstvk2jFoQNyLB+aEUP
X-Received: from pjbsj13.prod.google.com ([2002:a17:90b:2d8d:b0:328:116e:273])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac8:b0:248:cd0b:3441
 with SMTP id d9443c01a7336-24944b0dcb1mr247773305ad.30.1757020442072; Thu, 04
 Sep 2025 14:14:02 -0700 (PDT)
Date: Thu, 04 Sep 2025 21:13:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA8BumgC/2XSwW7DIAwG4Fepch4VNgFDT3uPaQcgThtpXbYkj
 TZVffeRVlNSOGL4fhD2tRp56HisDrtrNfDcjV3/mRYAL7sqnvznkUXXpEKFErWs0YqGw+XYjmK
 4jJNQsdHREQdqoErka+C2+7nnvb2n9akbp374vcfPsFT/g9xz0AxCChMMUwzk0LWvx74/fvA+9
 udqSZpxo5XMNCaNbBvlrLaAodBq1VpCplXSVktrXOuDISx0vdWY6Tppsta7aCIyUaH1VutM66Q
 VOxWZQiDDhTarNpB9/2yWuzF6RoAAShWaNhrrTFPSLlqrtCePsvxzu9WUaZt0NBoN16CaWhbar
 Zpk3m+33I3BsQ/aOw2FBrlyC8W4yKVnhtOrVWxVeO747TGKA39f0kRPj3msgh9ZpP1zNx12s9k DiSFiOn37A/twKVUHAwAA
X-Change-Id: 20250428-debugfs-rust-3cd5c97eb7d1
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757020440; l=5962;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=pG7w/3JHU8axFyAFdX9e0nFyT0oX71h+TjUDTVFGEkA=; b=NhgcVfJ+Dz+XKdXa9mw16yqlipg7kgSXv1v8b+sui3OC40XLGb5SQ7rTG/VybhANxKJoK2Eyj
 tbNJZ6kt8lCAQhCAzMorrA0+6+byHc/3bsTfMUPTYzyUzXTpCzTN42b
X-Mailer: b4 0.14.2
Message-ID: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
Subject: [PATCH v11 0/7] rust: DebugFS Bindings
From: Matthew Maurer <mmaurer@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>, 
	Dirk Beheme <dirk.behme@de.bosch.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

This series provides safe DebugFS bindings for Rust, with sample
modules using them.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
Changes in v11:
- Rephrased comments/docs based on list feedback
- Switched longer polymorphic declarations to use where clauses
- Switched `TI: PinInit` to `impl PinInit` (this was previously required
  for `use<>`
- Keep `Scope` private until the scoped interface is added
- `Render` -> `Writer`, `UpdateFromSlice` -> `Reader`
- Documented that `Debug` format is subject to change
- Link to v10: https://lore.kernel.org/r/20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com

Changes in v10:
- Introduced Scoped to show how either a File or Dir can be bound to
  data
- Remove use of `use<>` for MSRV compatibility
- Added Write support
- Added more complex sample driver using scoped interface
- Updated original sample driver to use writes to drive mutation
- Added `FileOps<T>` (only for DebugFS, not a kernel-wide abstraction)
  to decrease needed `unsafe` for keeping vtables paired to types.
- Centralized `dentry` lifecycle management to `entry.rs`.
- Link to v9: https://lore.kernel.org/r/20250709-debugfs-rust-v9-0-92b9eab5a951@google.com

Changes in v9:
- Switched to `PinInit` backing instead of `ForeignOwnable`
- Changed sample to be a platform driver
- Exported a static property
- Demonstrated runtime mutation in platform driver (`inc_counter`)
- Demonstrated how driver code would interact with data structures
  exported through DebugFS (`Wrapper`)
- Link to v8: https://lore.kernel.org/r/20250627-debugfs-rust-v8-0-c6526e413d40@google.com

Changes in v8:
- Switched from casts to `core::from_{ref, mut}` in type change
- Link to v7: https://lore.kernel.org/r/20250624-debugfs-rust-v7-0-9c8835a7a20f@google.com

Changes in v7:
- Rewrote `entry::Entry` -> `Entry`
- Use `c_int` and `c_void` from kernel prelude rather than core
- Removed unnecessary `display_open` cast
- Switched from `Deref` + an explicit box to `ForeignOwnable` for
  attaching owned data.
- Made `&'static` and `&'static mut` implement `ForeignOwnable`
- Swapped "driver" to "module" in sample code
- Link to v6: https://lore.kernel.org/r/20250618-debugfs-rust-v6-0-72cae211b133@google.com

Changes in v6:
- Replaced explicit lifetimes with children keeping their parents alive.
- Added support for attaching owned data.
- Removed recomendation to only keep root handles and handles you want
  to delete around.
- Refactored some code into separate files to improve clarity.
- Link to v5: https://lore.kernel.org/r/20250505-debugfs-rust-v5-0-3e93ce7bb76e@google.com

Changes in v5:
- Made Dir + File wrappers around Entry
- All functions return owning handles. To discard without drop, use
  `forget`. To keep a handle without drop, use `ManuallyDrop`.
- Fixed bugs around `not(CONFIG_DEBUG_FS)`
- Removed unnecessary `addr_of!`
- Link to v4: https://lore.kernel.org/r/20250502-debugfs-rust-v4-0-788a9c6c2e77@google.com

Changes in v4:
- Remove SubDir, replace with type-level constant.
- Add lifetime to Dir to prevent subdirectories and files from outliving
  their parents and triggering an Oops when accessed.
- Split unsafe blocks with two calls into two blocks
- Access `private` field through direct pointer dereference, avoiding
  creation of a reference to it.
- Notably not changed - owning/non-owning handle defaults. The best read
  I had from the thread was to continue with this mode, but I'm willing
  to change if need be.
- Comment changes
  - More comment markdown
  - Remove scopes from examples
  - Put `as_ptr` properties into a `# Guarantees` section.
- Link to v3: https://lore.kernel.org/r/20250501-debugfs-rust-v3-0-850869fab672@google.com

Changes in v3:
- Split `Dir` into `Dir`/`SubDir`/`File` to improve API.
- Add "." to end of all comments.
- Convert INVARIANT to # Invariants on types.
- Add backticks everywhere I found variables/types in my comments.
- Promoted invariant comment to doc comment.
- Extended sample commenting to make it clearer what is happening.
- Link to v2: https://lore.kernel.org/r/20250430-debugfs-rust-v2-0-2e8d3985812b@google.com

Changes in v2:
- Drop support for builder / pinned bindings in initial series
- Remove `ARef` usage to abstract the dentry nature of handles
- Remove error handling to discourage users from caring whether DebugFS
  is enabled.
- Support CONFIG_DEBUG_FS=n while leaving the API available
- Fixed mistaken decimal/octal mixup
- Doc/comment cleanup
- Link to v1: https://lore.kernel.org/r/20250429-debugfs-rust-v1-0-6b6e7cb7929f@google.com

---
Matthew Maurer (7):
      rust: debugfs: Add initial support for directories
      rust: debugfs: Add support for read-only files
      rust: debugfs: Add support for writable files
      rust: debugfs: Add support for callback-based files
      samples: rust: Add debugfs sample driver
      rust: debugfs: Add support for scoped directories
      samples: rust: Add scoped debugfs sample driver

 MAINTAINERS                              |   4 +
 rust/bindings/bindings_helper.h          |   1 +
 rust/kernel/debugfs.rs                   | 594 +++++++++++++++++++++++++++++++
 rust/kernel/debugfs/callback_adapters.rs | 122 +++++++
 rust/kernel/debugfs/entry.rs             | 164 +++++++++
 rust/kernel/debugfs/file_ops.rs          | 247 +++++++++++++
 rust/kernel/debugfs/traits.rs            | 102 ++++++
 rust/kernel/lib.rs                       |   1 +
 samples/rust/Kconfig                     |  22 ++
 samples/rust/Makefile                    |   2 +
 samples/rust/rust_debugfs.rs             | 151 ++++++++
 samples/rust/rust_scoped_debugfs.rs      | 134 +++++++
 12 files changed, 1544 insertions(+)
---
base-commit: f3c5631f70e434e318c44001e2417d4770f06cd0
change-id: 20250428-debugfs-rust-3cd5c97eb7d1

Best regards,
-- 
Matthew Maurer <mmaurer@google.com>


