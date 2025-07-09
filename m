Return-Path: <linux-kernel+bounces-724331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 625B8AFF17B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1359E18963DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA9C23F413;
	Wed,  9 Jul 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3vd2pBn2"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B523E35D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088187; cv=none; b=LqON+9oH34ck82x0M9actrKRe/DFVjO6WVIgqGc6eFpcMGfNqFdQAnSNFHcYomyv+3WwvAXEzo/+oqdPk6cx9Nf/6hzWtagWoE9w8Qo+ie4qWMtO4Iq6e8IDl/sBwnnTG/uR2a7aGTFlNi+9VVfEkqv3im6qKMGOSAyFsz1dS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088187; c=relaxed/simple;
	bh=RQ6WlSJ5huRIlq7brHPoei5H/RzfutY8mWggxP7frgc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qGgbSWLepe64h7JCIGNIn7tT5kHr9XDdp9pPJMKMiLzyPj8EzmiCO/t/PIU4WJsIWbBLqaQzOitO7tSjMg1A7y9oKcW6GoKx3rToJgNtinfriVUlscZQqH1P1bG9sSCUk8jTrV2hpboTw5el7VcnNHywFE1dK6e2kBiV6odX8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3vd2pBn2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748d96b974cso135382b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752088185; x=1752692985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNAElYoeZ//XwlLTtUYFDMEB3pxtENpE+6ocThKiP9w=;
        b=3vd2pBn2uR4acd+cSpjq/Axo39svtf0JX4/vwIiL9i42Dod39UFi8sBu/dip+4rZIh
         yKyl7UTnTIzFAToF2lc4FVIsJD6Hyq/iyEye2JMGt9vZ7P+i5dC1Gx+EpA4qsPAF3QKa
         zxXqy7XdzgjyYd7rq6awAj07xtsDduT6JkrobVHBjGau37UXf6N1yDzMww20iEUleQ8/
         rLkmYGnPA68dYsU0JetCAfwpG7K8LYk359DTBj2g7IsJ1wn1uSae257jN35gAHn82QcC
         GtHq+SZnjULeWJ/e9x7EQdo8iKJroHrFv/+EREJjOcA/TFnlinqkfnNVeNcFwl57DBdO
         ACyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088185; x=1752692985;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNAElYoeZ//XwlLTtUYFDMEB3pxtENpE+6ocThKiP9w=;
        b=O0bkdhA2UFHOVhtz81odY2uKIuMyFIxAYqpg58w1+fTDFORd1bj42PZv69zlh6ZxJY
         zwmFL/qjEE4iD5XoIKxIn/I1tdEJVzBCdSqXrDZXz+M7gDhDzoGPOtDvOz3o9oIy8VpQ
         8QPagAIjCGzEpXhv/z5i+cjN7Md51Zc6d/UWQ1861WfqKdACez7MyC2ytSIQ6UdhmqtM
         gDhdX+CcqccJhJZLSu2xhejVtTNYoNU8KzFKbpLKFtrxCtym8nnRJVRLu/lED9QZffnt
         0EjQztI+voS6/Z7zo8RGpvj1GbSaX+ho/1/r4k+Qd0Rlp4rxByk0XiNzkPhb1VTZ5mwg
         fVww==
X-Gm-Message-State: AOJu0YxAd0/pbwHDYN3L+2zWS+SYVfPDv60tuQD3UNuelSQENEfw4YGO
	MrwW9E4hOyxXlw625uh0Vak6KkL2Fmmrs/apOwYbunvJuGH//W941/ajGaJAxMseZOrsBBqhpRs
	pitYATkcXIQ==
X-Google-Smtp-Source: AGHT+IE5vRO3Q3eFARbezu5DXeGqmMT1wM6O0/smswHpoXmYxUGOFfc7aAnR8SkyJrPWJdB98kY2RQmYgCJS
X-Received: from pfbg22.prod.google.com ([2002:a05:6a00:ae16:b0:746:2d8f:cac1])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4516:b0:74e:ab26:aa81
 with SMTP id d2e1a72fcca58-74eab26ad4dmr4449406b3a.13.1752088184824; Wed, 09
 Jul 2025 12:09:44 -0700 (PDT)
Date: Wed, 09 Jul 2025 19:09:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGi+bmgC/2XSy27DIBAF0F+JWJcWBvPKqv9RdcFj7CA1cQuOl
 SrKv5ckquLgHRd0LtJozqRgTljIdnMmGedU0niowb5sSNi5w4A0xZoJMJCsA0Mj+uPQF5qPZaI
 iRBmsRq8jJ5V8Z+zT6Vb38VnzLpVpzL+39plfb/+L7HPRzCmjyivUwWsLtn8fxnH4wtcw7sm1a
 YaFFqzRUDWgicIaaTj4lRYPLRlvtKjaSGaU7Z1XGla6W2podFe1NsbZoAKg1istl1o2WlYt0Iq
 A2nutcKXVQyvejH9W178hOATOPRdipfVCQ9doXbUNxgjptAO2nrlZat1oU3VQEhR2XMSOPenLf Rky/hzrSk33jSDeFaT1fZ+m7SbmNGOuMePb4kwPeJpqweUPVyqay5sCAAA=
X-Change-Id: 20250428-debugfs-rust-3cd5c97eb7d1
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752088183; l=5227;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=RQ6WlSJ5huRIlq7brHPoei5H/RzfutY8mWggxP7frgc=; b=MCsonrHNemnUNxWIXxJtxnYsrLWXWN1R7U6v6Oqy0JmnTY2cMPbO+6bbH+DVG/WO6kIMqCs3R
 ct5ADTZYEgjAPOW+J0PQtCvV1QPKycKZlmHZP7Bv1Sg2DJb6go6+r9W
X-Mailer: b4 0.14.2
Message-ID: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
Subject: [PATCH v9 0/5] rust: DebugFS Bindings
From: Matthew Maurer <mmaurer@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

This series provides safe DebugFS bindings for Rust, with a sample
module using them.

Example interaction with the sample driver:
~ # mount -t debugfs debugfs /debug
~ # cat /debug/sample_debugfs/*
"sample-debugfs"
0
0
Inner { x: 3, y: 10 }
~ # cat /debug/sample_debugfs/inc_counter
1
~ # cat /debug/sample_debugfs/inc_counter
2
~ # cat /debug/sample_debugfs/inc_counter
3
~ # cat /debug/sample_debugfs/*
"sample-debugfs"
4
4
Inner { x: 3, y: 10 }
~ # cat /debug/sample_control/swap
Swapped!
~ # cat /debug/sample_debugfs/*
"sample-debugfs"
5
5
Inner { x: 10, y: 3 }
~ # cat /debug/sample_control/add_counter 
Counter added!
~ # cat /debug/sample_debugfs/*
"sample-debugfs"
6
6
Inner { x: 16, y: 3 }
~ # 

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
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
Matthew Maurer (5):
      rust: debugfs: Bind DebugFS directory creation
      rust: debugfs: Bind file creation for long-lived Display
      rust: debugfs: Support `PinInit` backing for `File`s.
      rust: debugfs: Support format hooks
      rust: samples: Add debugfs sample

 MAINTAINERS                         |   3 +
 rust/bindings/bindings_helper.h     |   1 +
 rust/kernel/debugfs.rs              | 286 ++++++++++++++++++++++++++++++++++++
 rust/kernel/debugfs/display_file.rs | 100 +++++++++++++
 rust/kernel/debugfs/entry.rs        |  66 +++++++++
 rust/kernel/lib.rs                  |   1 +
 samples/rust/Kconfig                |  11 ++
 samples/rust/Makefile               |   1 +
 samples/rust/rust_debugfs.rs        | 182 +++++++++++++++++++++++
 9 files changed, 651 insertions(+)
---
base-commit: 6d16cd5769bbb5eb62974e8eddb97fca830b49fd
change-id: 20250428-debugfs-rust-3cd5c97eb7d1

Best regards,
-- 
Matthew Maurer <mmaurer@google.com>


