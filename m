Return-Path: <linux-kernel+bounces-771161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E7B283AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEB61888D40
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF4308F31;
	Fri, 15 Aug 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfHlGCCa"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E731E0DFE;
	Fri, 15 Aug 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274648; cv=none; b=Qei/TQV1e8hMo1LEAItAQTuhJ4oPhoy6cxef0R6WKLL4mrf0969NXy3hRSfusOY7c+WZ/SjH8Kn0NPLyrvTZ39J2srO3sDUysRPVSov/bHW+Bl9yWUzjYnt2dKTS+ULQazOlSNeSZE1YEg1jAdazWSYCyvQ9RUlXuHWU4yBaMLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274648; c=relaxed/simple;
	bh=5R7pCSZabRR8WOR88qPtUBrH8rhbbLg6cjgm3pue50o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kfv43gtnsKerFl0iTpWBVrcUODq5rbTt9mNbahBQlniUlbHSR5dxMoMT6v+KN8MsT4bOzCrVMjQm+7BVZ4kf1rAmgvJjOUI7dJ4RErDATfHFmTw8BSym76+x4u77+eE8uZaaXOn4zZiuOl/id+eezrYXznPjnfF81XES9zjri9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfHlGCCa; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso2269350a91.1;
        Fri, 15 Aug 2025 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755274647; x=1755879447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xkWSMBvv97tE0L87n/+xzEranVDE18RxLy9xOEa9WnE=;
        b=gfHlGCCaCSmQ95rotdzyg5ffnukqV4tNhiRJ1ooR8dkmtwUVLBiMiybt9m36w0Mc9y
         EKsePgPUmRZJE4NFs9JLor2LGRh56QUVopBsj1LHkH6zgC58F/qKRNYGicBjtei1Ch+Z
         AKtQVTV5QZgHD3XF6Z+7Qw3TuSBttoTklF3vv6P+tD+4cO54ictYAZ+3ANEFWvoBiuTt
         8R0o0ik6RQWNnbo1MBXrOihsDPhhoSzAu4R6d14MZCXyShbwnGBxJjfk8fFK2uYvEoTz
         GwI6HEl0OolnuU1GMJwoNRIrmOELzPT1S0lpa7tmQ3Fr6U2o1gvk6HwhVwyQho6rzNPY
         qYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274647; x=1755879447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkWSMBvv97tE0L87n/+xzEranVDE18RxLy9xOEa9WnE=;
        b=irP2rw55Bfu5eJt5NVuC4mS6QPI/qSoc5DtWgpgWih4wB/BxjCFu/hdzxsdVi8Z0kv
         aUrHardnrNtmjj+ElTlSObXNCIRbSaRSH+AeICwr4Ne1ib123WJ2roCenYOjOzMrP5kU
         vzgkrEx/BjlvkzWb2zvBfU/k5kjpnL1PU6ZIoPxGzrf8wZYseXZutTdbpIlyyqu71qRW
         aRxHdQ2KvB9eI+AgbjaZBV4N3PluQxOt4aWOyscyJdNZV83s+4Spc04rghKyXSOYetf0
         DTjNV4Q+Q4yl5NBRv4Wnos/xIONfd/hwS0JxvFPbeworwYXtXDwsfDwflCW+Thh8185N
         crUA==
X-Forwarded-Encrypted: i=1; AJvYcCVspcWBsh7i1BFB7oAFT1cK8SfVCQRkCZFjnemCxA8wu//jzm1Myxj5BZyE8GUZRsZ0IhDZGQbIHaSfJVop2/0=@vger.kernel.org, AJvYcCWHY7ec/P0RpeDwjo8GYWExpL7BZmM6or11A1Q65fkyaMy8dyAT6BEhRkcWLzlylpHvH2vz2bJmwdiKOxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPmK/wh2Fi9jILKT4bSeIAq2IGjOZ55AYqN/jtuJVdo6xOHp6
	s0FkePUnDHUQI/JHYIbCfuSH0AlSUmE2uV6ndZPmXlHDP94h6l7B4ura
X-Gm-Gg: ASbGnctjA0FG3b8CfZGWmiKli/HAPZv9h0vtP5+sXzcu0dra1Hcf9A1NXg5IuNql+g1
	iivIUy4dWdRfsrTiwjXOGM/JS6ouObtB6FAIJurEaM5q+cRkDL7otX7vlryQjzGkQF+m0bAaZH6
	RjKDKBOtrNSUMvXx50gd40+/FmFajvxxZ0s6ennLmnlumNlxCeNEHKcAGgJ4+8kLsDsiYdJgV0h
	5iMZWJs+TPY7cD4oVElRBM14tIO/XqL262eoDgHKJa63JFv3eQLbt2aMZrTOw8Lj9dMDgbi1qEP
	TB6J+YO6d3hkzp8oykACHzBFJmpdRe7Z28FpvfplW9EgQyUWk/kWwr9vpDhS2evqagv2b7aQAXL
	f076xKihC9v1MOZidOiQr7RhITo2BPl41qRIq
X-Google-Smtp-Source: AGHT+IGVoswd+Ft6FzSer0QgtETxBKAle0x+MVxXRA3yaUqXxz79J+RPMgiPQB3UuhrBDm4gvslv2Q==
X-Received: by 2002:a17:90a:d44d:b0:321:c9e7:d9ef with SMTP id 98e67ed59e1d1-32341ee9181mr3841094a91.21.1755274646761;
        Fri, 15 Aug 2025 09:17:26 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32328ac9010sm2156104a91.0.2025.08.15.09.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:17:26 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH] rust: drm: update ARef and AlwaysRefCounted imports from sync::aref
Date: Fri, 15 Aug 2025 21:47:06 +0530
Message-Id: <20250815161706.1324860-1-shankari.ak0208@gmail.com>
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
It part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here: (commit 07dad44aa9a93)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 rust/kernel/drm/device.rs  | 3 ++-
 rust/kernel/drm/driver.rs  | 2 +-
 rust/kernel/drm/gem/mod.rs | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 3bb7c83966cf..4a62f9fd88b7 100644
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
index fe7e8d06961a..8fefae41bcc6 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -8,7 +8,7 @@
     bindings, device, devres, drm,
     error::{to_result, Result},
     prelude::*,
-    types::ARef,
+    sync::aref::ARef,
 };
 use macros::vtable;
 
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index b71821cfb5ea..a822aedee949 100644
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

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


