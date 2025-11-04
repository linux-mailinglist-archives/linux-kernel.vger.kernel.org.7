Return-Path: <linux-kernel+bounces-884825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5CEC313E3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86B3F34CC37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D9C32862E;
	Tue,  4 Nov 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVZ7a7Fx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65532860C;
	Tue,  4 Nov 2025 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263189; cv=none; b=PUgRjT0OKHzC+JnycercXxh4H9JZndvwqzQkubVZx0lN6YK5faaT8Md7+zA0iJdlDMu4uzCwboTIOZrnd52bd5eMGFXkwiUvnCx3bCzSZWMO9ch4D2j6T4iOlLky+6zKIswMsPp76adiUig1guXDc4IHo92ionU9c9kh7+v7L0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263189; c=relaxed/simple;
	bh=f0c+ZJ36CLOvekVxRAOBewUgIXI7AlVS9dRimYjitU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTNyG93oYW+viHy52K5L0i4IFF9SB1W66czXvCLyUEQsaPQk1uiyOfE9oGnFjRadmfMRSlndanETRYgaGeGDQEauuGVCxxhJKRIuWgSE2BjGEWYVHFuyqcu414DjUNSgqptVYAV9bDVjw5ZIywAM5FFjWfWI7xaHEcfYjrX2oy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVZ7a7Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471FFC116C6;
	Tue,  4 Nov 2025 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762263188;
	bh=f0c+ZJ36CLOvekVxRAOBewUgIXI7AlVS9dRimYjitU8=;
	h=From:To:Cc:Subject:Date:From;
	b=UVZ7a7Fx2oF8ZE9B7FWAjDHgd6o6Bs/xQ2wRNsM8UIEfuUwydXexdN+I1mwXyJe6v
	 Zs51fDzWKHWgloCpnrm0lHsuCqy66RDfzv9IohX5qiHoaedhao23oR106iu6cIJLxS
	 +rU1sX4Muj5myyHYRrYQ4GUvgH0qk804kyQgDA3jUDOMMEVQyJsxXoQrWygErmGECA
	 Y+jO8enTDKLttMVD7xcjFwdXlWNnQ5w5gh10uVDx4T+RMRTkzAdh2cvDvPG+A8kUWs
	 O9LJ8iD5VGFZWD9vE5xpLXay1g6YbXA175sA4tQR0z0GqMckVIprB/3xcYSMPZYtKh
	 w0L4drC81WQ1A==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com,
	daniel.almeida@collabora.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] rust: io: cleanup imports and use "kernel vertical" style
Date: Tue,  4 Nov 2025 14:32:54 +0100
Message-ID: <20251104133301.59402-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 46f045db5a94 ("rust: Add read_poll_timeout_atomic function")
initiated the first import change in the I/O module using the agreed
"kernel vertical" import style [1].

For consistency throughout the module, adjust all other imports
accordingly.

While at it, drop unnecessary imports covered by prelude::*.

Link: https://docs.kernel.org/rust/coding-guidelines.html#imports [1]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/io.rs          |  6 ++++--
 rust/kernel/io/mem.rs      | 28 ++++++++++++++++++----------
 rust/kernel/io/poll.rs     |  5 ++++-
 rust/kernel/io/resource.rs | 16 ++++++++++------
 4 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index ee182b0b5452..1aa9495f7774 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -4,8 +4,10 @@
 //!
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
-use crate::error::{code::EINVAL, Result};
-use crate::{bindings, build_assert, ffi::c_void};
+use crate::{
+    bindings,
+    prelude::*, //
+};
 
 pub mod mem;
 pub mod poll;
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 59096d579644..b03b82cd531b 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -4,16 +4,24 @@
 
 use core::ops::Deref;
 
-use crate::c_str;
-use crate::device::Bound;
-use crate::device::Device;
-use crate::devres::Devres;
-use crate::io;
-use crate::io::resource::Region;
-use crate::io::resource::Resource;
-use crate::io::Io;
-use crate::io::IoRaw;
-use crate::prelude::*;
+use crate::{
+    c_str,
+    device::{
+        Bound,
+        Device, //
+    },
+    devres::Devres,
+    io::{
+        self,
+        resource::{
+            Region,
+            Resource, //
+        },
+        Io,
+        IoRaw, //
+    },
+    prelude::*,
+};
 
 /// An IO request for a specific device and resource.
 pub struct IoRequest<'a> {
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index ebc29023d59d..e21ccf98b81a 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -5,7 +5,10 @@
 //! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
 
 use crate::{
-    error::{code::*, Result},
+    error::{
+        code::*,
+        Result, //
+    },
     processor::cpu_relax,
     task::might_sleep,
     time::{
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index bea3ee0ed87b..81220493a7f3 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -5,12 +5,16 @@
 //!
 //! C header: [`include/linux/ioport.h`](srctree/include/linux/ioport.h)
 
-use core::ops::Deref;
-use core::ptr::NonNull;
-
-use crate::prelude::*;
-use crate::str::{CStr, CString};
-use crate::types::Opaque;
+use core::{
+    ops::Deref,
+    ptr::NonNull, //
+};
+
+use crate::{
+    prelude::*,
+    str::CString,
+    types::Opaque, //
+};
 
 /// Resource Size type.
 ///
-- 
2.51.2


