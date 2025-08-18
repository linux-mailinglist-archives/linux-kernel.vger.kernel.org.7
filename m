Return-Path: <linux-kernel+bounces-773697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D03B2A57C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1CA7BE303
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F582334711;
	Mon, 18 Aug 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y00JnkB5"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34132A3DE;
	Mon, 18 Aug 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523567; cv=none; b=G2YIMBZlmIDnE7GzK7AC8PkoDRWORtP9qAJQ7H2xR77lyWYnIDtwqsS4Uhf1hcjs9zZwxvtowABeOd4Y+7o/AEaqLPWmtNtGT4GxIpgpd0L5c+B1zylSqZmXnVVWg36t42mN0XiDcTAUes695b/NdEHRZIlUNcdyPtLqc/uJZp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523567; c=relaxed/simple;
	bh=YcyheI2lrt7t0suwpCgWUQ699t6WLJAJVxLnwYrM6SM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avCep4W23yWsHruB0ExY2WPHsEw8126tF8K0A+B9Se8Nr408tB38sTAOK8MRRSKBX10WGjyW9n1jJlA67hbU0itgErp2HTALHSQJ90v9MI8teP7ks7xK1pDVHZhUZFJ9jvKDHUKFX3O5a2ouwKsWI1kTuBpzLF7SPy8pG/UElts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y00JnkB5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24458242b33so37848855ad.3;
        Mon, 18 Aug 2025 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755523565; x=1756128365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6IH0foQZWl66cdnGlTKcPrjNVNNfo4VgHeZkeA5sus=;
        b=Y00JnkB5NxCheue+f6HhhgNCBFUDmDpiVanJiHN+U4c0mp9Tp3K8IyTUB2wgTy86wx
         bG9ZyFZOYhsd8fGqeikOUWba6LL0IJ4yYP74hqwsGnzvj15RKoGohdC+tJF+KOa6jYp2
         cQLqWgHDJyicolorEEuGR5EB3eh5imaElkHXZF/JwXP7C/3AgKfZG9POQVIb3VWBy6Zv
         A/OhZvjlZZ5Whp8XylQzKbdly/x23vg4g1J+7rO5pXhBlmlcqR7Qvj0QcBeMIQgplXin
         iGC/EEyxHk7K8Gl6TrGARkzpi0N84W0Jkx/4QQytZfN+Th/FNxd4+wlzIRkj/MWY8A8k
         4CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523565; x=1756128365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6IH0foQZWl66cdnGlTKcPrjNVNNfo4VgHeZkeA5sus=;
        b=r3+xsNZo/yS6wEjl3ohMFP1agLOzF8r8UPQDdqgy9U+V4Ngq60VjKXi9D2iCqfNMgf
         1Hw2YsKaufFPpjdz1z3ehf2FhPFiztP3QP5UP8MQpgKOBt4r0RiI0QBURrP7QBU0p9Q8
         TEqnhez1reDISSxcgGbCRoeF2U/kAJI/G51sAYLeenYcgKIEPpddkZWVTRHev4Td/y+p
         SinNAUZC2cza9SkSTvS6cjFYdhh1GH+6GYGhpd6dGpicE+D5tcuKQHQYkivVAGM084lf
         b4wrq1cYibQ4rh4JfLOC/Pbki1AbDRZ4G0D9oiy3Ayen21AXxorE9sOeZRHep7sihCNu
         1cSw==
X-Forwarded-Encrypted: i=1; AJvYcCVTpBdc6frBGME5qP0rm82CMOBSzKLk63h6a5nXEAQrGumf8zRlE26qRXq649u8iXdm79JJBt6dStylodtQ1PE=@vger.kernel.org, AJvYcCWxEvS5XjeEOxEbDbcAmbadLzEZWl/cZtnddfPTe/2AkvCHqA8gAHl4P7kqfCs4XUOTzcwruy7rtfYVf6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKz/FszsYIYMT/YBcNOLrtuPDzXNCIqXziLmzQPPSMDuW/G3O
	95tS9spMfJpvZTP9NrW+AJj4QE+veClXzdZwrIJ7RDmJSeB8XA6T5eR6
X-Gm-Gg: ASbGncvNayU+2YVKTlvxKIlDTjc62Xboi2nCscqS5XzKVQRq+qHEvwTod8gwgsDzhsO
	bre7l7eX/DyEYxEwjchzQw0louUTDDFXQQvDTVDlIUlHElTK8UteExcT6SH0qvYjNA0HSi/BsIa
	N1dWQTZDw43AiWTAuzcqH4klpplYYyMAzBqjqdDO4pl92nZenRhdX5R4CVa6AGp6r6+PR1Y6eh/
	VRxx4DafdYvdH4AGiWyLMF9nGcztQxNJpV26lsEo3OkrfNA3JIFwfgLrxdetTYMuXJz6oYTaODF
	hL5sXLK7O4R1Uw+cWW0tVD6q7/ZHx+DU206qRDVFzugfH3E0U4yYYw+/VNiJs5zN5RuPKCuRo8V
	MANGSrmgfnQ2/Yc3dHEc9smo9L10rGes6YLw9
X-Google-Smtp-Source: AGHT+IHe60ORRThkbSRVu/emFHzn+cvbbErpkvVQdvOId6PHJWb9r+ixnHcQi24qmwGuZVfVDC+pdA==
X-Received: by 2002:a17:903:19c7:b0:240:92cc:8fcf with SMTP id d9443c01a7336-2446d97a21dmr196931805ad.49.1755523565088;
        Mon, 18 Aug 2025 06:26:05 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9ea8fsm80852595ad.4.2025.08.18.06.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:26:04 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH] rust: task: update ARef and AlwaysRefCounted imports from sync::aref
Date: Mon, 18 Aug 2025 18:55:51 +0530
Message-Id: <20250818132551.133410-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in `task.rs` to import `ARef` and
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
 rust/kernel/task.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 7d0935bc325c..49fad6de0674 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -9,7 +9,8 @@
     ffi::{c_int, c_long, c_uint},
     mm::MmWithUser,
     pid_namespace::PidNamespace,
-    types::{ARef, NotThreadSafe, Opaque},
+    sync::aref::ARef,
+    types::{NotThreadSafe, Opaque},
 };
 use core::{
     cmp::{Eq, PartialEq},
@@ -76,7 +77,7 @@ macro_rules! current {
 /// incremented when creating `State` and decremented when it is dropped:
 ///
 /// ```
-/// use kernel::{task::Task, types::ARef};
+/// use kernel::{task::Task, sync::aref::ARef};
 ///
 /// struct State {
 ///     creator: ARef<Task>,
@@ -347,7 +348,7 @@ pub fn active_pid_ns(&self) -> Option<&PidNamespace> {
 }
 
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
-unsafe impl crate::types::AlwaysRefCounted for Task {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Task {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


