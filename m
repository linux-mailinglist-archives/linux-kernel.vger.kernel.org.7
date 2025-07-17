Return-Path: <linux-kernel+bounces-734814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1CEB08698
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140AB189A575
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B8E22F74A;
	Thu, 17 Jul 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeaRQXxd"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84731235354;
	Thu, 17 Jul 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737263; cv=none; b=pyHT537tNko6mtH2DVbt+zlmawTuvoRgUP/muUVDy8foe5ib6lVbZvegBXRiOA9CVH9w5NVHaDD4DXFSDUP7ZdkkOMcNnA89wmrA7Lpo1x0H7U56xoVH725tXb28ZcYtun+xFcyqcctgm1yQXIJEmjrMgKVwlE9gNaIKSveJo64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737263; c=relaxed/simple;
	bh=2OY9tCpe44+TA1RFup/OOX+vsoCybeEJVzld1o3rH/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YNqFKk0nIZP9a8TvZssy4gJG/NA5UKDNHmvfFqDr1L96Sf3DKQzchTGsq4adKJB7Mm+Ll8/5YgZA8YP70HesKSq1S+Coj1yk6XMvoZCQAf//J16rv5aLE96K5VG09KIQX3Yxe37C8eNzhuaajoji+ZrylK8/3ss6/0/8myT88RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeaRQXxd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so875109b3a.2;
        Thu, 17 Jul 2025 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752737260; x=1753342060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLnoXGdj/M0uxgMdyQaYHvfFtkVhPebQXjsZCXxynJU=;
        b=AeaRQXxdjmL4UwG/9cw9IDu08Kn+yIJtx7et+xq2rEh07CWlHMm/s/aWKRsyFYxC5Q
         g2Ks2auosFu6u6/EDPLO0+nrubUOix7W+cbSwltKZdYfmWE1jyO+OFyf8slEmUvgXYl0
         t4G/0XXGwg5Jl2icdxuq+G/JZFeeSci8sH8Uby5I459lUjFqSWFIEAU2OWY71Ag8h+Re
         NbEbWwFqu48SeLC1wfbol1vAK7knNU9xr45T7ATtdagwMAixYs0LWCiIubw5MoUrV1rm
         D1uFMvaMda6xI/htuwqKrOv4z4gFxh6mXv15U6YOUF6Ut+QS34URCC11IpKjdNAhsa+Y
         Rq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737260; x=1753342060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLnoXGdj/M0uxgMdyQaYHvfFtkVhPebQXjsZCXxynJU=;
        b=owHOq9wNDPLxi8u7A1TCBAKyB1DrggPoI4al07lPDYb91pcfVf0zppWXmSApdtGZ+y
         XoVqt3JjYt842lmb6wTV/JahcuS9E3ilYtZhOZLhyelGF5mwAKofcCA+dl9Y+yFKklvL
         yZ1RTRbw0C7m81LUYsQnEwNX2RJAOEoNFeLeUIdffyCqgl817RQda5ITr0q5lj9uk4vK
         W5m4KAckqNJILCyv7Bdfh6CeWX0coONu9DKoYXYB/LmDfrNrHUSI+ituiWFLLvvGAcJ+
         IYzOUQFk9V13il1JM0TYoNiSeMUKu7RsHSHs8LYBfmaoF1dk4svZrtRgUu4OaQLOVTfk
         Jobw==
X-Forwarded-Encrypted: i=1; AJvYcCVoupnDnWK8qFyLvn0StPi0qzdCupsN01bOBC66TgRxOVRyrD9oYvGZ1hg9B4iN4znVm3U23O1f9nr72bYoZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWmR0CZxjOa0MVI7Ig8AJarf/vd6pxDnUzscZzByJDgAH6RAz
	l2qap2xueWCIjCz6OKnF52xYfj+XOZR46FOG+q+wloHW9gg0XwSmqiHQFamnNTEz
X-Gm-Gg: ASbGncv1KR3Eye8vf92b3K/MhbhUP+ReV+Z+wk+VYYbZDkRWTj6BtkhWI5CjVxo3uVK
	v77n4h4ONCZlfV5aTfRzT1MHmHqcg28B8gpOW5sVFdo90h+XNdERXYtb9JbcytXx08npb0J5k50
	jlnWWuIM/Z//mToFzfvYnU/Rxv2os5KUeDfT4H210ygbADgmkfUfzRyzjOaVs90cF2G7fLa5+QU
	5hRZOg1z0NQCLDQbFTcgD76O549I7AdzTSmp+PyLr51wWfhEO+cX5JRuXFsBbw0nPosmiSwQY4s
	T2wdD6m9WD0VeH4VwgZv6Uufjvpd4m1Fcxbu0/w9sye4WZdTW1rrfB7uaxkbVfK2SvemrpyQEdL
	zQEfqQ7vu7ytuzkfaGyaVx0hnoTnK9W89Vyu2fVtUalwHCDSuVd/3
X-Google-Smtp-Source: AGHT+IEmFkiFvGLL1z9IVIuQEsNe2fyLPnLIYJHlr3lVvQJv8xwuJmLiMZe6ptSx528VTkO1HIHEig==
X-Received: by 2002:a05:6a20:2590:b0:1f5:7eee:bb10 with SMTP id adf61e73a8af0-23810d55196mr9367609637.8.1752737260425;
        Thu, 17 Jul 2025 00:27:40 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:4080:e0f:ae0a:ee10:e231:d467:2ec0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f46479sm15525349b3a.109.2025.07.17.00.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:27:39 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH 5/7] rust: drm: update ARef and AlwaysRefCounted imports from sync::aref
Date: Thu, 17 Jul 2025 12:57:24 +0530
Message-Id: <20250717072724.14602-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in drm to import `ARef` and
`AlwaysRefCounted` from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
Its part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here:
https://lore.kernel.org/rust-for-linux/DBCLH4WXYTJL.FDZ9B39OO3TY@kernel.org/T/#mb67fbddcd894665d6ec6b0854e37930dedab468b

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 rust/kernel/drm/device.rs  | 3 ++-
 rust/kernel/drm/driver.rs  | 2 +-
 rust/kernel/drm/gem/mod.rs | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index e598c4274f29..391bcc959308 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -10,7 +10,8 @@
     error::from_err_ptr,
     error::Result,
     prelude::*,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque,
 };
 use core::{mem, ops::Deref, ptr, ptr::NonNull};
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index acb638086131..9f3450f77ca0 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -11,7 +11,7 @@
     error::{to_result, Result},
     prelude::*,
     str::CStr,
-    types::ARef,
+    sync::aref::ARef,
 };
 use macros::vtable;
 
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 6f914ae0a5aa..01f1b3a80c58 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -10,7 +10,8 @@
     drm::driver::{AllocImpl, AllocOps},
     error::{to_result, Result},
     prelude::*,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque,
 };
 use core::{mem, ops::Deref, ptr::NonNull};
 
base-commit: 8ecb65b7b68ea48350833ba59c1257718e859768
-- 
2.34.1


