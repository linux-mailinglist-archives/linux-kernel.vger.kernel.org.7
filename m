Return-Path: <linux-kernel+bounces-798677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63385B4213D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093E87ABD7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F79301485;
	Wed,  3 Sep 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="HW3EIXvM"
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86222F7449;
	Wed,  3 Sep 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905692; cv=none; b=ihHQWDLpnM0IdVHt0s2vTrvUmP8xz7LdTy+zrCRbLt8gWJhNxYgCCNHBJE5UaS1JxWVnIBqjIflcNz2r3Al4DlJoAAXsvJ1NkS7emLFxPaRdYW1k2du8rGqAsqnD6wg6sdF1NkkL0fj2tVHRjrYbn2wOrm6DhNc3D+87SQYjFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905692; c=relaxed/simple;
	bh=89TA99TzngR1DPri1zBaKB6jSqwWX+ssbHxAwLZGtQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChOAsIbcYrQLa0R4gxAtQUPOjCNi9yg0ig0Qo8WecTr/V3rqN2VNVe4vIrx05/LFP2+/rK5JJolJPp3OHqSR7tkbL+I8S08dzMQCAcJVptErK6sJIuZannMaaZmFgwChmpo+mvfAkQP9015hVUPrZNRpxIkbZaQ+h79JqfPNYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=HW3EIXvM; arc=none smtp.client-ip=178.154.239.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward206a.mail.yandex.net (Yandex) with ESMTPS id D5F14826D2;
	Wed, 03 Sep 2025 16:13:48 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3e17:0:640:f9aa:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id D74E8C0036;
	Wed, 03 Sep 2025 16:13:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GDgKkBDMquQ0-0DBmNgtu;
	Wed, 03 Sep 2025 16:13:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756905220;
	bh=nnsW47jRpu2o9uucmiKj09c8TsfRK6GusYy4hDbXhkY=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=HW3EIXvMT33sPsjj08LGs3vgRvzAuttbM/2RJ57tUPq4zoZ/T3Y1c4pA1YDUkIxu2
	 Gas5FNNXn+cFQ/v1eOlBq+vAcynOfPiuIm/rClR2Az9qkOF8JZ3NRUv8o/b+L2KEQO
	 r3DYr13giwGpOaSbMtyVMAthtiDFpyEUoHN5hHfI=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	felipe_life@live.com,
	daniel@sedlak.dev,
	bjorn3_gh@protonmail.com,
	daniel.almeida@collabora.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v6 2/7] rust: implement `WwClass` for ww_mutex support
Date: Wed,  3 Sep 2025 16:13:08 +0300
Message-ID: <20250903131313.4365-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250903131313.4365-1-work@onurozkan.dev>
References: <20250903131313.4365-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds the `WwClass` type, the first step in supporting
`ww_mutex` in Rust. `WwClass` represents a class of ww
mutexes used for deadlock avoidance for supporting both
wait-die and wound-wait semantics.

Also adds the `define_ww_class!` macro for safely declaring
static instances.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync/lock.rs          |   1 +
 rust/kernel/sync/lock/ww_mutex.rs | 136 ++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 rust/kernel/sync/lock/ww_mutex.rs

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 27202beef90c..5b320c2b28c1 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -15,6 +15,7 @@

 pub mod mutex;
 pub mod spinlock;
+pub mod ww_mutex;

 pub(super) mod global;
 pub use global::{GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
new file mode 100644
index 000000000000..ca5b4525ace6
--- /dev/null
+++ b/rust/kernel/sync/lock/ww_mutex.rs
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel Wound/Wait Mutex.
+//!
+//! This module provides Rust abstractions for the Linux kernel's `ww_mutex` implementation,
+//! which provides deadlock avoidance through a wait-wound or wait-die algorithm.
+//!
+//! C header: [`include/linux/ww_mutex.h`](srctree/include/linux/ww_mutex.h)
+//!
+//! For more information: <https://docs.kernel.org/locking/ww-mutex-design.html>
+
+use crate::bindings;
+use crate::prelude::*;
+use crate::types::Opaque;
+
+/// Create static [`WwClass`] instances.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::{c_str, define_ww_class};
+///
+/// define_ww_class!(WOUND_WAIT_GLOBAL_CLASS, wound_wait, c_str!("wound_wait_global_class"));
+/// define_ww_class!(WAIT_DIE_GLOBAL_CLASS, wait_die, c_str!("wait_die_global_class"));
+/// ```
+#[macro_export]
+macro_rules! define_ww_class {
+    ($name:ident, wound_wait, $class_name:expr) => {
+        static $name: $crate::sync::lock::ww_mutex::WwClass =
+            // SAFETY: This is `static`, so address is fixed and won't move.
+            unsafe { $crate::sync::lock::ww_mutex::WwClass::unpinned_new($class_name, false) };
+    };
+    ($name:ident, wait_die, $class_name:expr) => {
+        static $name: $crate::sync::lock::ww_mutex::WwClass =
+            // SAFETY: This is `static`, so address is fixed and won't move.
+            unsafe { $crate::sync::lock::ww_mutex::WwClass::unpinned_new($class_name, true) };
+    };
+}
+
+/// A class used to group mutexes together for deadlock avoidance.
+///
+/// All mutexes that might be acquired together should use the same class.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::lock::ww_mutex::WwClass;
+/// use kernel::c_str;
+/// use pin_init::stack_pin_init;
+///
+/// stack_pin_init!(let _wait_die_class = WwClass::new_wait_die(c_str!("graphics_buffers")));
+/// stack_pin_init!(let _wound_wait_class = WwClass::new_wound_wait(c_str!("memory_pools")));
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[pin_data]
+pub struct WwClass {
+    #[pin]
+    inner: Opaque<bindings::ww_class>,
+}
+
+// SAFETY: [`WwClass`] is set up once and never modified. It's fine to share it across threads.
+unsafe impl Sync for WwClass {}
+// SAFETY: Doesn't hold anything thread-specific. It's safe to send to other threads.
+unsafe impl Send for WwClass {}
+
+impl WwClass {
+    /// Creates an unpinned [`WwClass`].
+    ///
+    /// # Safety
+    ///
+    /// Caller must guarantee that the returned value is not moved after creation.
+    pub const unsafe fn unpinned_new(name: &'static CStr, is_wait_die: bool) -> Self {
+        WwClass {
+            inner: Opaque::new(bindings::ww_class {
+                stamp: bindings::atomic_long_t { counter: 0 },
+                acquire_name: name.as_char_ptr(),
+                mutex_name: name.as_char_ptr(),
+                is_wait_die: is_wait_die as u32,
+                // TODO: Replace with `bindings::lock_class_key::default()` once stabilized for `const`.
+                //
+                // SAFETY: This is always zero-initialized when defined with `DEFINE_WD_CLASS`
+                // globally on C side.
+                //
+                // Ref: <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ww_mutex.h?h=v6.16-rc2#n85>
+                acquire_key: unsafe { core::mem::zeroed() },
+                // TODO: Replace with `bindings::lock_class_key::default()` once stabilized for `const`.
+                //
+                // SAFETY: This is always zero-initialized when defined with `DEFINE_WD_CLASS`
+                // globally on C side.
+                //
+                // Ref: <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ww_mutex.h?h=v6.16-rc2#n85>
+                mutex_key: unsafe { core::mem::zeroed() },
+            }),
+        }
+    }
+
+    /// Creates a [`WwClass`].
+    ///
+    /// You should not use this function directly. Use the [`define_ww_class!`]
+    /// macro or call [`WwClass::new_wait_die`] or [`WwClass::new_wound_wait`] instead.
+    const fn new(name: &'static CStr, is_wait_die: bool) -> Self {
+        WwClass {
+            inner: Opaque::new(bindings::ww_class {
+                stamp: bindings::atomic_long_t { counter: 0 },
+                acquire_name: name.as_char_ptr(),
+                mutex_name: name.as_char_ptr(),
+                is_wait_die: is_wait_die as u32,
+                // TODO: Replace with `bindings::lock_class_key::default()` once stabilized for `const`.
+                //
+                // SAFETY: This is always zero-initialized when defined with `DEFINE_WD_CLASS`
+                // globally on C side.
+                //
+                // Ref: <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ww_mutex.h?h=v6.16-rc2#n85>
+                acquire_key: unsafe { core::mem::zeroed() },
+                // TODO: Replace with `bindings::lock_class_key::default()` once stabilized for `const`.
+                //
+                // SAFETY: This is always zero-initialized when defined with `DEFINE_WD_CLASS`
+                // globally on C side.
+                //
+                // Ref: <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/ww_mutex.h?h=v6.16-rc2#n85>
+                mutex_key: unsafe { core::mem::zeroed() },
+            }),
+        }
+    }
+
+    /// Creates wait-die [`WwClass`].
+    pub fn new_wait_die(name: &'static CStr) -> impl PinInit<Self> {
+        Self::new(name, true)
+    }
+
+    /// Creates wound-wait [`WwClass`].
+    pub fn new_wound_wait(name: &'static CStr) -> impl PinInit<Self> {
+        Self::new(name, false)
+    }
+}
--
2.50.0


