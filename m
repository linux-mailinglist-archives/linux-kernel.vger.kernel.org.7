Return-Path: <linux-kernel+bounces-776609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F83B2CF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB2B1C20429
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827E238C1E;
	Tue, 19 Aug 2025 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MA5amxrz"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22F236451
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644026; cv=none; b=DvZbVmRZbsdcqo9kGK3NzF3yZ3LE8vRhq8vUC4Eweq7Nmqyo+dYj2pyaHmYLwvGttNcf8hSCgx2/12ImJeqLmnKcrFPjSMCNpo5jELDftDHGsU92Zqb47PoAYrUX5pfwHyx8NZARTgYzlMwJ28eDt6vgg18ltET18tLn+GwEqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644026; c=relaxed/simple;
	bh=lX444EIDCnnA8D2jKhc4Rwvq8m9EnnJBzSijBAgJZwk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SB4MNTBmuQ+B3+grZLZ0vn5rzoVXfNl2uK0YTvsoaQAQve1exChToEvZc7HyGOGbvhEK+YBh9QwEb1Ga7AbEa+bZVANlF6kYo8WNShx9iO4jZNgXBwk4lq9IyHUo7z72IB6EL8d8ogdesBYn6EjXJ0mr/ls7CxE3lGHgjeU5a5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MA5amxrz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581950a1so66723225ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755644024; x=1756248824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lYEVB3pRXH6lT21Cyl3SADOl1TwGJtAaTRsYJ3uoDn0=;
        b=MA5amxrzupYCbJIpwjqvq9Gl4BxNmjgG8fpUENmYnXeSFjH/m5rHO87Zy33CqENfyT
         B5c0LUbmaUpa5oDb+M72JVst+HZbmSTIOEk3caXV4eLiqJzk4O/+md19PITLxSO2BEtp
         7I47FLj6Ug7NnkCsvQ+fK8jEdt5y09gbNzjFqtAZ8cmpBA9onczyI9dDYVEGeWg3I0pp
         cfa0ac0p7bMLSqV98MLWzlnXbsxkIJtt9SXqhtBkrUcOXxI1bhH26rrhE2+9nlLUpdMx
         +ujKpKcxTX00F2pKOKfeu1qiVD/UlhDlWJ8OwHiijBChWiDOWQlXD88Ktv//c89tyUKY
         hpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755644024; x=1756248824;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYEVB3pRXH6lT21Cyl3SADOl1TwGJtAaTRsYJ3uoDn0=;
        b=q23mZma2GDLpo4Z5szyFIA2F6yjuwjD1TxrI1pbBro+2rCsvFOXbsGuLM89xbM7P56
         jgHzAKAgEj6oXo+4/Jgtz/f46UlMTF91FTcwiRCG5QSOweybY6koNmw2quIOhqbMYzyp
         IcOuJ2Bs9pXUtSnAcY9c4WiSpB8N0n7DyP7UBqAiVFh6PBNbEF/pI09koGyMfHuVEUGC
         qbHVT0SD0nzNr80X8KMlm96E69n+OUMjg1TDTefMWhRKB5sFaaUvxJANU9lEJ+Ui5j/u
         Z5SI2KHPnham0fJJbp0YsobYLGYxrxp+2RRSx+gHi6NbL6WMv0QyatD4VRix9E4GLsVR
         lRQg==
X-Gm-Message-State: AOJu0Yxak5KfNE0T82cgUCWZhs5minWq7d0ckMFi5bL+cwMdKSv7zwvt
	025VgYC2DvjtRxpnca/pcyo+PiYJ86VBodd1bVHBDfOJCk6OtY1Y4xKFP1McpCF3yabW3GfJsSU
	KBn5i1VizJw==
X-Google-Smtp-Source: AGHT+IEiuVRDjMMsXYqUGudDnn8pYnCV6/bvlO922pBB7z+GLfN0XMDV/qP933U1d62ffFRdxsdwMyywD0BY
X-Received: from plbmq6.prod.google.com ([2002:a17:902:fd46:b0:23f:e9a5:d20a])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2350:b0:23f:aec2:c880
 with SMTP id d9443c01a7336-245ef1388b6mr7633835ad.19.1755644024291; Tue, 19
 Aug 2025 15:53:44 -0700 (PDT)
Date: Tue, 19 Aug 2025 22:53:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG8ApWgC/2XSwW7DIAwG4FepOI8KTMDQ095j2gGIkyKty5ak0
 aaq7z7SamoKRwzfb8n4wiYaE03ssLuwkZY0peEzH6R42bF49J898dTmAgMBWjRgeUvh3HcTH8/
 TzFVsdXRIAVvJMvkaqUs/t7y393w+pmkext9b/CLX6n+Qew5aJBfcBEMYAzpw3Ws/DP0H7eNwY
 mvSAhutRKEhayDbKme1lRAqrR5aC1lolbXVwhrX+WAQKt1sNRS6yRqt9S6aCIRYab3VutA6a0V
 ORcIQ0FClzUMbWYx/MWtviJ5AyiCVqjRuNDSFxqxdtFZpjx5EPXO71Vhom3U0Ggw1UrWNqLR7a BTlf7u1NwRHPmjvtHzS1/sqjfR9zhs53/eJBT8Rz/enNB92i9lL5GOE/Pr6Bze1FxjHAgAA
X-Change-Id: 20250428-debugfs-rust-3cd5c97eb7d1
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755644022; l=5583;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=lX444EIDCnnA8D2jKhc4Rwvq8m9EnnJBzSijBAgJZwk=; b=nc1nPF8V0i/bJOhVzuronl2caaCuoX/nms4qiJAAdX2CoBI79of8Gr40jsNNzOKdfBHVrXKoc
 1qDjHSSpCsHBwm9oDPg9oJ2nRJnVixmCv5K8CXgAWSLnsbS888p+xy1
X-Mailer: b4 0.14.2
Message-ID: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
Subject: [PATCH v10 0/7] rust: DebugFS Bindings
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

Shortly after this is sent, you will see a real driver WIP using this
implenting the qcom socinfo driver.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
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
 rust/kernel/debugfs.rs                   | 613 +++++++++++++++++++++++++++++++
 rust/kernel/debugfs/callback_adapters.rs | 122 ++++++
 rust/kernel/debugfs/entry.rs             | 164 +++++++++
 rust/kernel/debugfs/file_ops.rs          | 246 +++++++++++++
 rust/kernel/debugfs/traits.rs            |  97 +++++
 rust/kernel/lib.rs                       |   1 +
 samples/rust/Kconfig                     |  22 ++
 samples/rust/Makefile                    |   2 +
 samples/rust/rust_debugfs.rs             | 151 ++++++++
 samples/rust/rust_scoped_debugfs.rs      | 134 +++++++
 12 files changed, 1557 insertions(+)
---
base-commit: f3c5631f70e434e318c44001e2417d4770f06cd0
change-id: 20250428-debugfs-rust-3cd5c97eb7d1

Best regards,
-- 
Matthew Maurer <mmaurer@google.com>


