Return-Path: <linux-kernel+bounces-764863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D39B2282B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C621BC3F30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010B267B02;
	Tue, 12 Aug 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGdoQg8a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228A20B1F5;
	Tue, 12 Aug 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004180; cv=none; b=roNd5qQumv9RROR6m6Xv2QrfN0Zi5RIIwdG3phaG5w16QA/dZmunDTJ9uLfvdw4sKfbZkjMn1KVRIVK32ucIMPzLJNF+RVMCnWQrTGIrcbsLrn03v+j6YlMlqsWmzSVFtC1sgWkEU8DnCAAjC90bPyZF9GU/VUs3Mssahuz3Wc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004180; c=relaxed/simple;
	bh=4dw/dCbsdvNnpX2D+rr3n1ONj7c/Xg5bifqPSG2z1eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLvwlT9IFPSki911sPNyu+cZGDA/lntbh1LqL6SOgkJTxYlaKNUSVi9xQtZFWdcnoAdMk0i6nTt4kw1URIicBAffD2lzr0lrjy5qyX9TvsFMEIwMK1r+PZV4VGOd9bxVk/bckwAh1N+qA6XDn1pnv9QBVj7plCSHfzvsLKeN6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGdoQg8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D61C4CEF0;
	Tue, 12 Aug 2025 13:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755004179;
	bh=4dw/dCbsdvNnpX2D+rr3n1ONj7c/Xg5bifqPSG2z1eE=;
	h=From:To:Cc:Subject:Date:From;
	b=vGdoQg8a4YwSJrwMrrEweiDx22olFdwFJiBFuYxxzdZ2ZicdmGW4WV/NWmg22HUv7
	 taxbO+cQNGGLij804Qd5VTeYxMuRnkLVyOuL96Roy/c+22V8sk7FugT/rA2Kgzkiy2
	 CPNBrz0ShtnMcygdVvi5/qHXa3OZHFWrS274vyYREkkjtdh+MxQQ/knudW30vBL2aF
	 BSCrGC/1Y8jcJp53zQnl1UCThERLGXtZ3wgt216VQVjoddwNJCugSk4uGLv2tg6TIT
	 /pnoAkSjFqq7HjCe+gnxpiYSSR1n1bOAuFc6F07I7/lQYTgDqy0raT/XRfoXvlDLIr
	 1exk9y0xoNkzw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2] rust: devres: fix leaking call to devm_add_action()
Date: Tue, 12 Aug 2025 15:09:06 +0200
Message-ID: <20250812130928.11075-1-dakr@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the data argument of Devres::new() is Err(), we leak the preceding
call to devm_add_action().

In order to fix this, call devm_add_action() in a unit type initializer in
try_pin_init!() after the initializers of all other fields.

Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
Changes in v2:
  - Drop inner in-place when devm_add_action() fails.
  - Document to remove drop_in_place() once we can switch to UnsafePinned.
---
 rust/kernel/devres.rs | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index da18091143a6..d04e3fcebafb 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -115,10 +115,11 @@ pub struct Devres<T: Send> {
     /// Contains all the fields shared with [`Self::callback`].
     // TODO: Replace with `UnsafePinned`, once available.
     //
-    // Subsequently, the `drop_in_place()` in `Devres::drop` and the explicit `Send` and `Sync'
-    // impls can be removed.
+    // Subsequently, the `drop_in_place()` in `Devres::drop` and `Devres::new` as well as the
+    // explicit `Send` and `Sync' impls can be removed.
     #[pin]
     inner: Opaque<Inner<T>>,
+    _add_action: (),
 }
 
 impl<T: Send> Devres<T> {
@@ -140,7 +141,15 @@ pub fn new<'a, E>(
             dev: dev.into(),
             callback,
             // INVARIANT: `inner` is properly initialized.
-            inner <- {
+            inner <- Opaque::pin_init(try_pin_init!(Inner {
+                    devm <- Completion::new(),
+                    revoke <- Completion::new(),
+                    data <- Revocable::new(data),
+            })),
+            // TODO: Replace with "initializer code blocks" [1] once available.
+            //
+            // [1] https://github.com/Rust-for-Linux/pin-init/pull/69
+            _add_action: {
                 // SAFETY: `this` is a valid pointer to uninitialized memory.
                 let inner = unsafe { &raw mut (*this.as_ptr()).inner };
 
@@ -152,13 +161,13 @@ pub fn new<'a, E>(
                 //    live at least as long as the returned `impl PinInit<Self, Error>`.
                 to_result(unsafe {
                     bindings::devm_add_action(dev.as_raw(), Some(callback), inner.cast())
-                })?;
+                }).inspect_err(|_| {
+                    let inner = Opaque::cast_into(inner);
 
-                Opaque::pin_init(try_pin_init!(Inner {
-                    devm <- Completion::new(),
-                    revoke <- Completion::new(),
-                    data <- Revocable::new(data),
-                }))
+                    // SAFETY: `inner` is a valid pointer to an `Inner<T>` and valid for both reads
+                    // and writes.
+                    unsafe { core::ptr::drop_in_place(inner) };
+                })?;
             },
         })
     }

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


